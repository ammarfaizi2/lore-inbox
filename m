Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWJGORM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWJGORM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 10:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWJGORM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 10:17:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:42633 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932087AbWJGORL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 10:17:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jtyMHMlCwOx3LZLBJWC7TSo9AQm06/auoxlRg6n8h1DL8ezE4nD2fYixGbsvR1GEHivFgT1MeGer4i5Thw+O60g+VGDYSvyPKFcVxLkL3LSo5yPEnhfu4sKbjK3bwTdPyQFkEOKpnyZstbfYWDt2Bfmvk3wjq2Ev8oET+VDygBs=
Message-ID: <74d0deb30610070717k17079940ybedbf94dc8af8460@mail.gmail.com>
Date: Sat, 7 Oct 2006 16:17:09 +0200
From: "pHilipp Zabel" <philipp.zabel@gmail.com>
To: "Pierre Ossman" <drzeus@drzeus.cx>
Subject: Re: [PATCH] [MMC] Use own work queue
Cc: rmk+lkml@arm.linux.org.uk, "Pierre Ossman" <drzeus-list@drzeus.cx>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061001124240.16996.34557.stgit@poseidon.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061001124240.16996.34557.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/1/06, Pierre Ossman <drzeus@drzeus.cx> wrote:
> The MMC layer uses the standard work queue for doing card detection. As
> this queue is shared with other crucial subsystems, the effects of a long
> (and perhaps buggy) detection can cause the system to be unusable. E.g. the
> keyboard stops working while the detection routine is running.
>
> The solution is to add a specific mmc work queue to run the detection code
> in. This is similar to how other subsystems handle detection (a full
> kernel thread is the most common theme).
>
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

This patch makes pxamci stop working for me on a HTC Magician (PXA272).
Switching from 2.6.18 to 2.6.19-rc1 I got a kernel panic:

mmc0: clock 0Hz busmode 1 powermode 0 cs 0  Vdd 0 width 0
PXAMCI: clkrt = 0 cmdat = 0
VFS: Cannot open root device "mmcblk0p2" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

After removing this patch from 2.6.19-rc1, everything is working again.
Are there any changes to pxamci.c needed to be compatible with it?

regards
Philipp
