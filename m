Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSFUODJ>; Fri, 21 Jun 2002 10:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSFUODJ>; Fri, 21 Jun 2002 10:03:09 -0400
Received: from mta3.snet.net ([204.60.203.69]:59587 "EHLO mta3.snet.net")
	by vger.kernel.org with ESMTP id <S316605AbSFUODH>;
	Fri, 21 Jun 2002 10:03:07 -0400
From: "Taavo Raykoff" <traykoff@snet.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18 IDE channels block each other under load?
Date: Fri, 21 Jun 2002 10:03:41 -0400
Message-ID: <000801c2192c$72e37580$ad0aa8c0@trws>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone tell me what is going on here?

dd if=/dev/zero of=/dev/hda bs=1024 count=1000000

then in another vt:
fdisk /dev/hdc, then immediately press "q".

fdisk "hangs" for a long, long time.
ps -aux says state of dd and fdisk are both "D"
strace says fdisk is hanging on the close()
/proc/interrupts tell me that ide1 (/dev/hdc) is getting no 
 int activity for a long, long time. ide0 is very busy.

It is not just dd/fdisk.  Any intensive writes on one IDE 
channel (direct to the hd? device) seem to block any IO on 
the other device. 

Intel SAI2 MB, ServerWorks IDE chipset, 2.4.18, two IDE 
hard drives /dev/hda and /dev/hdc, 1024MB RAM, RH73 kernel
build.

Also seen on Promise PDCx IDE controllers hanging off the PCI.

hdparm settings appear to have no influence on this behavior.

Thanks,
TR.



