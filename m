Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWAaUgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWAaUgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWAaUgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:36:23 -0500
Received: from main.gmane.org ([80.91.229.2]:2739 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751459AbWAaUgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:36:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: vgacon scrolling problem [Was: Re: 2.6.16-rc1-mm4]
Date: Tue, 31 Jan 2006 21:35:31 +0100
Message-ID: <drohmk$itt$1@sea.gmane.org>
References: <drln68$n82$1@sea.gmane.org> <20060131202454.CDC2322AEAC@anxur.fi.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080301010301000901020408"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chaos.mk.cvut.cz
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
In-Reply-To: <20060131202454.CDC2322AEAC@anxur.fi.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080301010301000901020408
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Jiri Slaby wrote:
> Jindrich Makovicka wrote:
> 
>>In vgacon.c, there is a stray printk("vgacon delta: %i\n", lines); which
>>effectively disables the scrollback of the vga console (at least when
>>not using the new soft scrollback). Removing it fixes the problem.
> 
> Then ... could you post a patch?

if you insist :)

-- 
Jindrich Makovicka

--------------080301010301000901020408
Content-Type: text/plain;
 name="vgacon.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vgacon.c.diff"

--- linux-2.6.16-rc1-mm4/drivers/video/console/vgacon.c	2006-01-25 19:16:35.000000000 +0100
+++ linux-2.6.16-rc1-mm4/drivers/video/console/vgacon.c	2006-01-31 21:33:40.433055896 +0100
@@ -331,7 +331,6 @@
 		int margin = c->vc_size_row * 4;
 		int ul, we, p, st;
 
-		printk("vgacon delta: %i\n", lines);
 		if (vga_rolled_over >
 		    (c->vc_scr_end - vga_vram_base) + margin) {
 			ul = c->vc_scr_end - vga_vram_base;

--------------080301010301000901020408--

