Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265975AbRGMHgO>; Fri, 13 Jul 2001 03:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266950AbRGMHgF>; Fri, 13 Jul 2001 03:36:05 -0400
Received: from ns.suse.de ([213.95.15.193]:32263 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S265975AbRGMHfy>;
	Fri, 13 Jul 2001 03:35:54 -0400
To: Tim Hockin <thockin@sun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SOMAXCONN - bump up or sysctl?
In-Reply-To: <3B4E7EA1.F904DC43@sun.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Jul 2001 09:35:49 +0200
In-Reply-To: Tim Hockin's message of "13 Jul 2001 07:09:53 +0200"
Message-ID: <oupn169cmcq.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@sun.com> writes:

> hey all,
> 
> We have a request to bump up SOMAXCONN.  Are there are repurcussions to
> doing so?  Would it be better to make it a sysctl?

Have you checked if the requester is not satisfied with an increase 
of /proc/sys/net/ipv4/tcp_max_syn_backlog? If they "know" from 2.0
that they want a SOMAXCONN increase then that's very likely the case.

In 2.2+ SOMAXCONN only applies to established sockets waiting to get
accept()ed; and when you have 128 established sockets that don't get served
by accept you have a big problem.

SYN-RECV sockets are a completely different thing and they are tuned
by the first sysctl and some other heuristics in 2.4.
You can also turn on syncookies there to handle syn-recv load spikes.

-Andi

