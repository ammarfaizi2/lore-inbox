Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVBJAYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVBJAYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVBJAYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:24:31 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:17027 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261984AbVBJAYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:24:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VV70g3JxpbcLyx5U0+71KR1j0QrWKqEeOT5ylQSIEc35J5pSNeNNJMagXRO0hS+H3BdRute23QMjVzbHn0M21rh2OI9+2ov5FnyuK0xBkOaxj0yZARDZkv9WwPYUrHXeiYWpnleGxJsNxbQAPLAFVpEL7dz1X9OO/+CbuHfY5JM=
Message-ID: <58cb370e050209162437808733@mail.gmail.com>
Date: Thu, 10 Feb 2005 01:24:21 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [rfc][patch] ide: fix unneeded LBA48 taskfile registers access
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <tj@home-tj.org>
In-Reply-To: <420AA476.1040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.GSO.4.58.0502062348200.2763@mion.elka.pw.edu.pl>
	 <4206F2E5.7020501@gmail.com>
	 <200502070959.54973.bzolnier@elka.pw.edu.pl>
	 <420AA476.1040406@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On Thu, 10 Feb 2005 09:01:58 +0900, Tejun Heo <htejun@gmail.com> wrote:
>   Hello, Bartlomiej.  Happy new lunar year.
> 
> Bartlomiej Zolnierkiewicz wrote:
> >
> > I would prefer to not teach do_rw_taskfile() about ->tf_{in,out}_flags
> > (and convert all users to use helpers) - it is much simpler this way,
> >
> > ->flags field in ide_task_t is needed anyway (32-bit I/O flag).
> >
> 
>   New lunar year day is one of the biggest holidays here, so I haven't
> got time to work for a few days.  As it's over now, I began to work on
> ide drivers again.  I applied your task->flags patch and am moving my
> patches over it.
> 
>   One problem is that, with ATA_TFLAG_LBA48, whether to use HOB
> registers or not cannot be determined separately for writing and
> reading.  So, when initializing flush tasks, if WIN_FLUSH_CACHE_EXT is
> used, we need to turn on ATA_TFLAG_LBA48 to read error location
> properly, and we end up unnecessarily writing HOB registers.

Yep, good catch.

>   I think we can...
> 
>   1. Just leave it as it is.  It's not that big a deal.
>   2. Use another flag(s) to control LBA48 reading/writing separately.
>   3. do my proposal. :-)
> 
>   I'm currently sticking to #1.  Please let me know what you think.

agreed, #1 is a good choice, it is not that important to make things
more complicated

Thanks,
Bartlomiej
