Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUEAVq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUEAVq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 17:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUEAVq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 17:46:28 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:56808 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261580AbUEAVq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 17:46:26 -0400
Date: Sat, 1 May 2004 14:46:17 -0700
From: Chris Wedgwood <cw@f00f.org>
To: koke@amedias.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040501214617.GA6446@taniwha.stupidest.org>
References: <20040430195351.GA1837@amedias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430195351.GA1837@amedias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 09:53:51PM +0200, Jorge Bernal wrote:

> On tty's != 1 it takes a long time (~20-30 secs) from logout to next
> login but on tty1 it takes a normal time.

Oddly I've seen the same thing off-and-on for quite some time now
(early 2.6.x or beofe, I can't be sure).  For me it affects all tty's.

> If I launch getty on tty9 and logout (in tty9) getty ends
> inmediately and I can start it again and get another login.

For me I see this on all tty's most (but not all) of the time.

> I'm not sure if it actually has something to do with the kernel
> (maybe with /sbin/init). dmesg doesn't say anything about that.

When (ie. during the 'dead time') I see this the tty isn't used by
anyone and even more rarely the tty will get stuck so that when init
gets around starting a getty, it exits immediately and then init
rate-limits by noy respwaning a console for 5 minutes.

I'm not sure who is to blame here, it looks like some tty's get into a
state that either init or the getty doesn't like and don't want to
come unstuck easily (stty sane > /dev/tty<foo> sometimes helps).

I need to get an init working as pid != 1 with debugging so I can
figure out what init thinks here.  I've just been so short of time.


 --cw
