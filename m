Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754864AbWKKUiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbWKKUiH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 15:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754865AbWKKUiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 15:38:07 -0500
Received: from [139.30.44.16] ([139.30.44.16]:52234 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1754864AbWKKUiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 15:38:06 -0500
Date: Sat, 11 Nov 2006 21:38:05 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Christian Kujau <evil@g-house.de>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: OOM in 2.6.19-rc*
In-Reply-To: <Pine.LNX.4.64.0611111832180.1247@sheep.housecafe.de>
Message-ID: <Pine.LNX.4.63.0611112127490.28908@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.64.0611111318230.1247@sheep.housecafe.de>
 <20061111181937.GC25057@stusta.de> <Pine.LNX.4.64.0611111832180.1247@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006, Christian Kujau wrote:

> I think I'm more interested as to why the OOM killer seems to kill innocent
> apps at random. I can imagine that it's not easy for the kernel to tell which
> userland-application is using up too much memory. Hm, egrep -r "OOM|ut of
> memory" Documentation/    does not reveal much :(

A look at /proc/*/oom_score might shed some light on the "at random" part.
I.e., doing
  for job in /proc/[0-9]* ; do \
    echo -e "`cat $job/oom_score` \t $job \t `head -c50 $job/cmdline`"; \
  done | sort -n
the last process listed is considered the biggest memory hog of the 
moment (Of course, this still does not tell _why_).

Tim
