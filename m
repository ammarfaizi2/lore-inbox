Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270479AbRHHNY7>; Wed, 8 Aug 2001 09:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270481AbRHHNYt>; Wed, 8 Aug 2001 09:24:49 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:58888 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S270479AbRHHNYm>;
	Wed, 8 Aug 2001 09:24:42 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7-ac9 drivers/scsci/Makefile cpqfc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Aug 2001 23:24:46 +1000
Message-ID: <2694.997277086@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This chunk of code in 2.4.7-ac9 drivers/scsi/Makefile makes no sense.

  #if we have a triggerable HBA (extra circuit addition for
  #TTL level output on GPIO line), build in the trigger file

  #CPQTRIGGER_FILE = cpqfcTStrigger.c

  CPQTRIG = cpqfcTStrigger.o

  cpqfcTStrigger.o: cpqfcTStrigger.c

  cpqfcTSinit.o: cpqfcTSinit.c cpqfcTSstructs.h cpqfcTSchip.h cpqfcTSioctl.h

  cpqfcTScontrol.o: cpqfcTScontrol.c cpqfcTSstructs.h cpqfcTSchip.h

  cpqfcTSi2c.o: cpqfcTSi2c.c cpqfcTSchip.h

  cpqfcTSworker.o: cpqfcTSworker.c cpqfcTSchip.h cpqfcTSstructs.h cpqfcTSioctl.h

  cpqfc.o: cpqfcTSinit.o cpqfcTScontrol.o cpqfcTSi2c.o cpqfcTSworker.o $(CPQTRIG)
	  $(LD) -r -o cpqfc.o cpqfcTSinit.o cpqfcTScontrol.o \
	  cpqfcTSi2c.o cpqfcTSworker.o $(CPQTRIG)

Why are all the individual dependencies listed, make dep does it
automatically.  Why is cpqfc not coded like this?

list-multi += cpqfc.o
cpqfc-objs := cpqfcTSinit.o cpqfcTScontrol.o cpqfcTSi2c.o cpqfcTSworker.o cpqfcTStrigger.o
...
cpqfc.o: $(cpqfc-objs)
	$(LD) -r -o $@ $(cpqfc-objs)


