Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVDESJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVDESJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVDESBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:01:50 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:51367 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261876AbVDESAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:00:15 -0400
Date: Tue, 5 Apr 2005 20:00:07 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
Message-ID: <20050405180007.GD12536@wohnheim.fh-wedel.de>
References: <4252BC37.8030306@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4252BC37.8030306@grupopie.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 April 2005 17:26:31 +0100, Paulo Marques wrote:
> 
> Would this be a good thing to clean up, or isn't it worth the effort at all?

I would welcome such a stream of patches.  But in spite of the calloc
interface being rather stupid, I'd prefer to see patches with kcalloc
instead of kmalloc_zero.

> --- ./lib/kobject_uevent.c.orig	2005-04-05 16:39:09.000000000 +0100
> +++ ./lib/kobject_uevent.c	2005-04-05 17:01:26.000000000 +0100
> @@ -234,10 +234,9 @@ void kobject_hotplug(struct kobject *kob
>  	if (!action_string)
>  		return;
>  
> -	envp = kmalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
> +	envp = kmalloc_zero(NUM_ENVP * sizeof (char *), GFP_KERNEL);
>  	if (!envp)
>  		return;
> -	memset (envp, 0x00, NUM_ENVP * sizeof (char *));
>  
>  	buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
>  	if (!buffer)


Jörn

-- 
There's nothing better for promoting creativity in a medium than
making an audience feel "Hmm ­ I could do better than that!"
-- Douglas Adams in a slashdot interview
