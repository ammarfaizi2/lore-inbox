Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261844AbTCGXNf>; Fri, 7 Mar 2003 18:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261860AbTCGXNf>; Fri, 7 Mar 2003 18:13:35 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:4363 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S261844AbTCGXNe>; Fri, 7 Mar 2003 18:13:34 -0500
Date: Sat, 8 Mar 2003 00:23:55 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA/VIA woes on SuSE 2.4.19-167
Message-ID: <20030307232355.GA9267@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030305024446.GA13870@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030305024446.GA13870@merlin.emma.line.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Mar 2003, Matthias Andree wrote:

> Plextor PX-W4824TA 1.03 as hdc (no hdd)
> VIA KT133
> 
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
>         Flags: bus master, medium devsel, latency 32
>         I/O ports at ffa0 [size=16]
>         Capabilities: [c0] Power Management version 2
> 
> When I try to enable DMA (hdparm -d1 or hdparm -d1 -X66), hdparm -tT
> chokes, SuSE k_athlon-2.4.19-167. FreeBSD-5 (with atapicam) is fine and
> uses UDMA33.

Now, seems that PIO manages the default hdparm -tT block size, but DMA
doesn't; but the error messages in the kernel ring buffer aren't
specific.

I let go of hdparm -tT, installed Jörg Schilling's sdd and ran sdd
if=/dev/sr1 -onull -t bs=2048 and lo and behold, it passed and read a
data CD with up to 45x. So the remaining problem is that the ATAPI
drives stick to PIO for data reads.

I tried applying Andrew's ide-akpm on top of SuSE's kernel, to find it
crashes on boot on SuSE's hardware scan.

If that's interesting enough, I can try to dig up the crash messages
(I'll have to use a serial console for that though).
