Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVI2PRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVI2PRq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVI2PRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:17:46 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:42442 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S932189AbVI2PRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:17:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=havMTSB9E7qPndcqG30f14yrilY9GjBAAhLuK/LQ7/1YcEC1xkVBx5eWehYhJAL4hzL5lNJRYaghfX1c4N1fZjONKwOYgFrbJOdlrib4H4yiCTjm4mvkQ2vm72I7NyKfPf0e+XYVIQAql9PqsDAHuSr/FE3IZZMnaAmllJs9Pzs=;
Date: Thu, 29 Sep 2005 19:17:29 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Ion Badulescu <lists@limebrokerage.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org, gautran@mrv.com
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x kernels
Message-ID: <20050929151729.GA2158@ms2.inr.ac.ru>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com> <20050901.154300.118239765.davem@davemloft.net> <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com> <20050902183656.GA16537@yakov.inr.ac.ru> <Pine.LNX.4.61.0509281223560.30951@ionlinux.tower-research.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509281223560.30951@ionlinux.tower-research.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> >Anyway, ignoring this puzzle, the following patch for 2.4 should help.
> >
> >
> >--- net/ipv4/tcp_input.c.orig	2003-02-20 20:38:39.000000000 +0300
> >+++ net/ipv4/tcp_input.c	2005-09-02 22:28:00.845952888 +0400
> >@@ -343,8 +343,6 @@
> >			app_win -= tp->ack.rcv_mss;
> >		app_win = max(app_win, 2U*tp->advmss);
> >
> >-		if (!ofo_win)
> >-			tp->window_clamp = min(tp->window_clamp, app_win);
> >		tp->rcv_ssthresh = min(tp->window_clamp, 2U*tp->advmss);
> >	}
> >}
> 
> I'm very happy to report that the above patch, applied to 2.6.12.6, seems 
> to have cured the TCP window problem we were experiencing.

Good. I think the patch is to be applied to all mainstream kernels.

The only obstacle is the second report by Guillaume Autran <gautran@mrv.com>,
which has some allied characteristics, but after analysis it is something
impossible, read, cryptic and severe bug. :-( I did not get a responce
to the last query, so the investigation stalled.

Alexey
