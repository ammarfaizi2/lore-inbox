Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVDESx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVDESx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVDESxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:53:13 -0400
Received: from host201.dif.dk ([193.138.115.201]:10512 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261897AbVDESwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:52:06 -0400
Date: Tue, 5 Apr 2005 20:54:07 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Paulo Marques <pmarques@grupopie.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
In-Reply-To: <4252BC37.8030306@grupopie.com>
Message-ID: <Pine.LNX.4.62.0504052052230.2444@dragon.hyggekrogen.localhost>
References: <4252BC37.8030306@grupopie.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, Paulo Marques wrote:

> Hi,
> I noticed there are a number of places in the kernel that do:
> 	ptr = kmalloc(n * size, ...)
> 	if (!ptr)
> 		goto out;
> 	memset(ptr, 0, n * size);
> It seems that these could be replaced by:
> 	ptr = kcalloc(n, size, ...)
> 	if (!ptr)
> 		goto out;
or simply
	if (!(ptr = kcalloc(n, size, ...)))
		goto out;
and save an additional line of screen realestate while you are at it...


-- 
Jesper Juhl


