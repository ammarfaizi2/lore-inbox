Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135416AbRDMFRc>; Fri, 13 Apr 2001 01:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135417AbRDMFRW>; Fri, 13 Apr 2001 01:17:22 -0400
Received: from smtp1.legato.com ([137.69.200.1]:42629 "EHLO smtp1.legato.com")
	by vger.kernel.org with ESMTP id <S135416AbRDMFRS>;
	Fri, 13 Apr 2001 01:17:18 -0400
Message-ID: <061f01c0c3d8$c34e8870$5c044589@legato.com>
From: "David E. Weekly" <dweekly@legato.com>
To: "ML-linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Yacc in 2.4.3 causes kernel compile to fail (aicasm_gram.y)
Date: Thu, 12 Apr 2001 22:15:32 -0700
Organization: Legato Systems, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a singular Yacc file in 2.4.3:
linux/drivers/scsi/aic7xxx/aicasm/aicasm_gram.y

This is the first time I remember seeing a Yacc file in the Linux kernel
source code, but I'm young and stupid.

Since the default Makefile mapping for .y files is to call yacc, and since I
have bison on my system instead, compiling the aic7xxx code into 2.4.3 broke
my build.

The Makefile system is expecting the YACC variable to be defined; a
straightforward workaround is then to define:

export YACC="`which bison` -y"

The -y option makes sure that bison outputs files in the same way that yacc
does (i.e., y.tab.c and not [filename].tab.c).

I would put in my two cents that the better way to do this is to add YACC to
the list of "make variables" in the root Makefile.

I'm guessing that anyone compiling the AIC 7xxx SCSI drivers who has bison
and hasn't configured a spoof "yacc" will run into this problem.

-david


