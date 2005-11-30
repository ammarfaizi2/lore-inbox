Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVK3LGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVK3LGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 06:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVK3LGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 06:06:18 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:8908 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751065AbVK3LGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 06:06:18 -0500
Date: Wed, 30 Nov 2005 12:06:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] timer locking optimization
In-Reply-To: <438D8BC0.1993824F@tv-sign.ru>
Message-ID: <Pine.LNX.4.61.0511301156300.1609@scrub.home>
References: <438C5057.A54AFA83@tv-sign.ru> <Pine.LNX.4.61.0511300330130.1609@scrub.home>
 <438D8BC0.1993824F@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Nov 2005, Oleg Nesterov wrote:

> Another problem. __mode_timer() does:
> 
> 	if (timer_pending(timer)) {
> 		detach_timer(timer, 0);
> 
> Note that 'clear_pending' parameter == 0. This means that detach_timer()
> will remove the timer from list, but won't clear 'pending' status. So
> this will crash after 'goto restart' (or in case of concurrent del_timer()).

I just noticed this too. I'll drop the patch and I'll also change the 
second patch.
Thanks for looking into this.

bye, Roman
