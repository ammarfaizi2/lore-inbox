Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbUL1D6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUL1D6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUL1D6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:58:11 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:57148 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262059AbUL1D6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:58:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lrE0to1hMpY0J0VMiCCIuO3fI0h0FNn9GvvXpqmSR5yu9gr4jQcpSDZdqEJHRTosr/FsUHniF26kE0UxxGTPl2nBrKukVahAVVaUkC/KdE9Jji8mdlFdsAiY+bNfKlcJuQASz5ABEAb36OEDPx+wDia0jUSn8frlDVdImb6vsy4=
Message-ID: <2cd57c90041227195893509d3@mail.gmail.com>
Date: Tue, 28 Dec 2004 11:58:01 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATCH: (Discussion) Stop IDE legacy ISA probes on PCI systems
Cc: Adam Sampson <azz@us-lot.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <Pine.LNX.4.58.0412271629270.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104156823.20898.21.camel@localhost.localdomain>
	 <y2a7jn34f4h.fsf@cartman.at.fivegeeks.net>
	 <Pine.LNX.4.58.0412271629270.2353@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should solve the problem. 

              coywolf


--- linux-2.6.10/include/asm-i386/ide.h 2004-10-19 05:53:13.000000000 +0800
+++ linux-2.6.10-cy/include/asm-i386/ide.h      2004-12-28
11:45:38.000000000 +0800
@@ -44,13 +44,18 @@ static __inline__ unsigned long ide_defa
        switch (index) {
                case 0: return 0x1f0;
                case 1: return 0x170;
-               case 2: return 0x1e8;
-               case 3: return 0x168;
-               case 4: return 0x1e0;
-               case 5: return 0x160;
-               default:
-                       return 0;
        }
+
+       if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
+               switch (index) {
+                       case 2: return 0x1e8;
+                       case 3: return 0x168;
+                       case 4: return 0x1e0;
+                       case 5: return 0x160;
+               }
+       }
+
+       return 0;
 }

 #define IDE_ARCH_OBSOLETE_INIT


On Mon, 27 Dec 2004 16:29:52 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> 
> On Mon, 27 Dec 2004, Adam Sampson wrote:
> >
> > I don't think that code will have the intended effect, unless your
> > GCC has some funny ideas about switch statements...
> 
> Indeed. That if-statement is unreachable and has no effect.
> 
>                 Linus
> -

-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
