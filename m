Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269891AbUJGXK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269891AbUJGXK4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269897AbUJGXIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:08:38 -0400
Received: from smtp08.auna.com ([62.81.186.18]:30421 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S269914AbUJGXHB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:07:01 -0400
Date: Thu, 07 Oct 2004 23:06:53 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc3-mm3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<200410071041.20723.sandersn@btinternet.com>
	<20041007025007.77ec1a44.akpm@osdl.org>
	<20041007114040.GV9106@holomorphy.com>
	<1097184341l.10532l.0l@werewolf.able.es>
	<1097185597l.10532l.1l@werewolf.able.es>
	<20041007150708.5d60e1c3.akpm@osdl.org>
	<1097188883l.6408l.1l@werewolf.able.es>
	<20041007155441.5a8e8e3a.akpm@osdl.org>
In-Reply-To: <20041007155441.5a8e8e3a.akpm@osdl.org> (from akpm@osdl.org on
	Fri Oct  8 00:54:41 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1097190413l.6408l.3l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.08, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > Thanks, that made it work again !!
> > 
> > Total set of patches to boot:
> > - your latest fix
> > - revert optimize profile + Andi's patch
> > - uhci fix (still needed ?)
> 
> I don't know anything about the uhci fix.  Sending a changelogged,
> signed-off patch would hep get the ball rolling.

http://marc.theaimsgroup.com/?l=linux-kernel&m=109690445623905&w=2

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

===== drivers/usb/host/uhci-hcd.c 1.134 vs edited =====
--- 1.134/drivers/usb/host/uhci-hcd.c	2004-09-30 13:58:40 -04:00
+++ edited/drivers/usb/host/uhci-hcd.c	2004-10-04 10:37:21 -04:00
@@ -2412,7 +2412,7 @@
 		goto up_failed;
 
 	retval = pci_register_driver(&uhci_pci_driver);
-	if (retval)
+	if (retval < 0)
 		goto init_failed;
 
 	return 0;


> 
> > - e100 fix (only thing I have seen at the moment...)
> 
> What's this and why is it needed?

Original thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109631322832372&w=2

Patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109632033331453&w=2


> 
> > - 1Gb lowmem
> > 
> > How about including the last one in -mm, for testing ? I use it in a server
> > and in my home workstation and it works fine (even with nvidia drivers ;) ).
> 
> Never seen it before.
> 
> 

Patch by Con Kolivas. It allows to use 1Gb without highmem. The magic number
of 1Gb is so common that I think it useful...

http://marc.theaimsgroup.com/?l=linux-kernel&m=109582272410486&w=2
Patch:
http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-rc2/2.6.9-rc2-ck2/patches/1g_lowmem1_i386.diff


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc3-mm3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


