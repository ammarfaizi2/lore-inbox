Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSFRPud>; Tue, 18 Jun 2002 11:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317461AbSFRPuc>; Tue, 18 Jun 2002 11:50:32 -0400
Received: from host194.steeleye.com ([216.33.1.194]:9745 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317458AbSFRPub>; Tue, 18 Jun 2002 11:50:31 -0400
Message-Id: <200206181550.g5IFoQ005746@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: make dep fails on 2.5.22
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Jun 2002 10:50:26 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is in drivers/scsi because of the auto generated header files for 
certain scsi scripts.

It currently errors out for me with my NCR_D700 controller because 53c700.c 
requires 53c700_d.h which is an automatically generated header file and thus 
doesn't exist when make dep is run.

I can fix this by adding the rule:

$(MODVERDIR)/53c700.ver: 53c700_d.h

but this looks wrong.  The dependency is already listed in the existing rule:

53c700.o: 53c700_d.h

Is there any way we can cause make deps to see dynamically generated header 
files, which will globally fix the problem?  Otherwise, perhaps just adding an 
extra variable into the Makefile to tell make dep about the necessary dynamic 
headers would be in order?

James


