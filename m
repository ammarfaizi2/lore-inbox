Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbSKOV4l>; Fri, 15 Nov 2002 16:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266809AbSKOV4l>; Fri, 15 Nov 2002 16:56:41 -0500
Received: from suonpaa.iki.fi ([62.236.96.196]:18130 "EHLO
	oberon.erasmus.jurri.net") by vger.kernel.org with ESMTP
	id <S266806AbSKOV4k>; Fri, 15 Nov 2002 16:56:40 -0500
To: Justin A <ja6447@albany.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47-ac4 panic on boot.
References: <200211150059.51743.ja6447@albany.edu>
	<3DD49520.7927434C@digeo.com> <200211150254.25306.ja6447@albany.edu>
From: Samuli Suonpaa <suonpaa@iki.fi>
Date: Sat, 16 Nov 2002 00:02:49 +0200
In-Reply-To: <200211150254.25306.ja6447@albany.edu> (Justin A's message of
 "Fri, 15 Nov 2002 02:54:25 -0500")
Message-ID: <877kfelcdy.fsf@puck.erasmus.jurri.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin A <ja6447@albany.edu> writes:
> On another note, pcibios_read_config_dword seems to be missing, and
> pcmcia-core wants it. I'll have to see whats up with that
> tomorrow...but at least I got it booting now:)

Osamu Tomita sent following fix a few days ago. No rediffed against
2.5.47-ac4. With this, I was able to get pcmcia_core loading. On the
other hand, I seem to be able to crash my Dell Latitude by removing
and then re-inserting 3c59x -cardbus-adapter. And by trying to reboot
or halt, so I really cannot tell whether this patch _really_ works.
But it definitely did something!-)

Suonpää...

--- linux-2.5.47-ac4/drivers/pcmcia/cistpl.c.orig	2002-11-15 23:29:24.000000000 +0200
+++ linux-2.5.47-ac4/drivers/pcmcia/cistpl.c	2002-11-15 23:31:35.000000000 +0200
@@ -430,7 +430,7 @@
 #ifdef CONFIG_CARDBUS
     if (s->state & SOCKET_CARDBUS) {
 	u_int ptr;
-	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
+	pci_bus_read_config_dword(s->cap.cb_dev->subordinate, 0, 0x28, &ptr);
 	tuple->CISOffset = ptr & ~7;
 	SPACE(tuple->Flags) = (ptr & 7);
     } else

