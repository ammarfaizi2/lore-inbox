Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVIXQi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVIXQi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 12:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVIXQi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 12:38:28 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:5866 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750755AbVIXQi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 12:38:27 -0400
Date: Sat, 24 Sep 2005 18:38:18 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Unify sys_tkill() and sys_tgkill()
Message-ID: <20050924163818.GA7339@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0509231913550.5348@shell3.speakeasy.net> <9a8748490509240752436ef7b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a8748490509240752436ef7b2@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 September 2005 16:52:28 +0200, Jesper Juhl wrote:
> 
> [snip]
> > +static int do_tkill(int tgid, int pid, int sig)
> 
> I would probably have made this
> 
>   static inline int do_tkill(int tgid, int pid, int sig)

Why?  It would only return the original duplication in binary form and
save a minimal amount of time for something already slow - a system
call.  With small caches, the code duplication could even waste more
performance than the missing function call would gain you.

Other nits were well-picked.

Jörn

-- 
You can't tell where a program is going to spend its time. Bottlenecks
occur in surprising places, so don't try to second guess and put in a
speed hack until you've proven that's where the bottleneck is.
-- Rob Pike
