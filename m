Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUA1Ls3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 06:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbUA1Ls3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 06:48:29 -0500
Received: from intra.cyclades.com ([64.186.161.6]:52917 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265865AbUA1Ls2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 06:48:28 -0500
Date: Wed, 28 Jan 2004 09:42:30 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: marcelo.tosatti@cyclades.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL PATCH] 2.4.25pre7 warning fix
In-Reply-To: <m3u12hcc9f.fsf@defiant.pm.waw.pl>
Message-ID: <Pine.LNX.4.58L.0401280939400.1311@logos.cnet>
References: <m3u12hcc9f.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jan 2004, Krzysztof Halasa wrote:

> Hi,
>
> The attached patch fixes the following warning msg:
>
> time.c:435: warning: `do_gettimeoffset_cyclone' defined but not used
>
> There is no need to define functions which do just { return 0; } and
> which aren't called by anything.
>
> (In case CONFIG_X86_SUMMIT is defined, there is another (real)
> do_gettimeoffset_cyclone() function, and it is referenced - but
> it's simply not related to this empty function).

Applied, thanks.

Btw, why do we need cyclone_setup() for !CONFIG_X86_SUMMIT ?

/* No-cyclone stubs */
#ifndef CONFIG_X86_SUMMIT
int __init cyclone_setup(char *str)
{
        printk(KERN_ERR "cyclone: Kernel not compiled with
CONFIG_X86_SUMMIT, cannot use the cyclone-timer.\n");
        return 1;
}


