Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbTGJRcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269510AbTGJRcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:32:33 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:60581 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266425AbTGJRb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:31:56 -0400
Date: Thu, 10 Jul 2003 19:46:36 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm3 OOM killer fubared ?
In-Reply-To: <bejhrj$dgg$1@news.cistron.nl>
Message-ID: <Pine.LNX.4.44.0307101943350.6757-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Enough memory free, no problems at all .. yet every few minutes
> the OOM killer kills one of my innfeed processes.
>
> I notice that in -mm3 this was deleted relative to -vanilla:
>
> -
> -       /*
> -        * Enough swap space left?  Not OOM.
> -        */
> -       if (nr_swap_pages > 0)
> -               return;
>
> .. is that what causes this ? In any case, that should't vene matter -
> there's plenty of memory in this box, all buffers and cached, but that
> should be easily freed ..

This is not cause, it only makes the bug more obvious.

With that code it is wrong too, it would trigger exactly same unnecesary
oom kills if you didn't have swap or if you had swap full and lot of free
memory as dirty filesystem cache.

Mikulas

