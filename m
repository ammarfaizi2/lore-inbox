Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVEJTPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVEJTPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 15:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVEJTPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 15:15:43 -0400
Received: from graphe.net ([209.204.138.32]:2833 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261747AbVEJTPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 15:15:35 -0400
Date: Tue, 10 May 2005 12:15:32 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       kenneth.w.chen@intel.com
Subject: Re: [RFC][PATCH] timers fixes/improvements
In-Reply-To: <42808B84.BCC00574@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0505101212350.20718@graphe.net>
References: <424D373F.1BCBF2AC@tv-sign.ru> <424E6441.12A6BC03@tv-sign.ru> 
 <Pine.LNX.4.58.0505091312490.27740@graphe.net> <20050509144255.17d3b9aa.akpm@osdl.org>
 <Pine.LNX.4.58.0505091449580.29090@graphe.net> <42808B84.BCC00574@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005, Oleg Nesterov wrote:

> > There is no corruption around ptype_all as you can see from the log. There
> > is a list of hex numbers which are from ptype_all -8 to ptype_all +8.
> > Looks okay to me.
>
> Still ptype_all could be accessed (and corrupted) as ptype_base[16].
>
> Christoph, could you please reboot with this patch?

Ok. I added padding before and after ptype_all.
With padding the problem no longer occurs.

However, if the padding is put before ptype_base and after ptype_all
then the problem occurs.

So it looks like this is due to writes intended for ptype_base going
out of bounds. However, there nothing in the code in net/core/dev.c
that would allow this to happen. Also why is the list head set
to 0x10:0x10?

