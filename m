Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261980AbREXN7U>; Thu, 24 May 2001 09:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbREXN7K>; Thu, 24 May 2001 09:59:10 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:9996 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262008AbREXN67>; Thu, 24 May 2001 09:58:59 -0400
Date: Thu, 24 May 2001 15:51:38 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: dhinds@zen.stanford.edu, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Minor cleanup in drivers/net/pcmcia/Makefile
Message-ID: <20010524155138.F1477@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Because make can't track intermediate targets made in a rule, the
ibmtr_cs drivers was rebuild every time you run "make modules". This
patch fixes that by making the intermediate files explicit rules in the
Makefile. Patch is against linux-2.4.5-pre5, but should apply cleanly
against other kernel versions as well. Please apply.


Erik

--- drivers/net/pcmcia/Makefile.orig	Thu May 24 15:33:26 2001
+++ drivers/net/pcmcia/Makefile	Thu May 24 15:35:53 2001
@@ -38,8 +38,10 @@
 include $(TOPDIR)/Rules.make
 
 tmp-ibmtr.o: ../tokenring/ibmtr.c
-	$(CC) $(CFLAGS) -D__NO_VERSION__ -DPCMCIA -c -o $@ ../tokenring/ibmtr.c
+	$(CC) $(CFLAGS) -D__NO_VERSION__ -DPCMCIA -c -o $@ $<
 
-ibmtr_cs.o: tmp-ibmtr.o ibmtr_cs.c
-	$(CC) $(CFLAGS) -DPCMCIA -c -o tmp-$@ ibmtr_cs.c
-	$(LD) -r -o $@ tmp-$@ tmp-ibmtr.o
+tmp-ibmtr_cs.o: ibmtr_cs.c
+	$(CC) $(CFLAGS) -DPCMCIA -c -o $@ $<
+
+ibmtr_cs.o: tmp-ibmtr.o tmp-ibmtr_cs.o
+	$(LD) -r -o $@ tmp-ibmtr_cs.o tmp-ibmtr.o


-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
