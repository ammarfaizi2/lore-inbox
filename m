Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270608AbTHEThr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270609AbTHEThr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:37:47 -0400
Received: from host81-136-142-241.in-addr.btopenworld.com ([81.136.142.241]:9171
	"EHLO mx.homelinux.com") by vger.kernel.org with ESMTP
	id S270608AbTHEThl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:37:41 -0400
Date: Tue, 5 Aug 2003 20:37:38 +0100 (BST)
From: Mitch@0Bits.COM
X-X-Sender: mitch@mx.homelinux.com
Reply-To: Mitch@0Bits.COM
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with
Message-ID: <Pine.LNX.4.53.0308052032220.31114@mx.homelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Hits: -0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Works fine with XFree86 4.3.x, 2.4.22-pre10 and the radeon.o
drm module. If you look backwards in your strace file, what is the
device that file descriptor 5 belongs to ?

core ~% lspci | grep VGA
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]
core ~% uname -a
Linux core 2.4.22-pre10 #7 Mon Aug 4 18:59:06 BST 2003 i686 unknown unknown GNU/Linux


On Tue Aug 05, 2003 at 06:49:25PM +0200, Ruben Puettmann wrote:
> DRI doesn't work with Radeon 7500 on IBM Thinkpad R40 (2722).
[-----------snip---------------]
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
[-----------snip---------------]
> XFree86 : 4.2.1
>
>
> Both glxgears and tuxracer crashes with the Illegal instruction error
> message. the strace output of glxgears is:
[-----------snip---------------]
> ioctl(3, FIONREAD, [0])                 = 0
> ioctl(5, 0x40186448, 0xbffffb30)        = 0
> --- SIGILL (Illegal instruction) @ 0 (0) ---
> +++ killed by SIGILL +++


I get this too, with vanilla 2.4.22-pre10....

$ lspci | grep VGA
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY
[Radeon 7000/VE]
$ lspci | grep AGP
00:01.0 PCI bridge: Intel Corp. 82865G/PE/P Processor to AGP Controller
(rev 02)

$ strace glxgears
[-----------snip---------------]
ioctl(3, FIONREAD, [0])                 = 0
ioctl(4, 0x40186448, 0xbffff4d0)        = 0
--- SIGILL (Illegal instruction) @ 0 (0) ---
+++ killed by SIGILL +++

 -Erik


