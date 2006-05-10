Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWEJVVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWEJVVY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWEJVVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:21:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:64903 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964862AbWEJVVX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:21:23 -0400
Date: Wed, 10 May 2006 22:20:58 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060510212058.GE27946@ftp.linux.org.uk>
References: <1147257266.17886.3.camel@localhost.localdomain> <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net> <1147273787.17886.46.camel@localhost.localdomain> <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net> <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com> <20060510162404.GR3570@stusta.de> <Pine.LNX.4.58.0605101506540.22959@gandalf.stny.rr.com> <1147290577.21536.151.camel@c-67-180-134-207.hsd1.ca.comcast.net> <Pine.LNX.4.58.0605101636580.22959@gandalf.stny.rr.com> <1147295515.21536.168.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147295515.21536.168.camel@c-67-180-134-207.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 02:11:54PM -0700, Daniel Walker wrote:
> > I really don't see why it couldn't be added.  What's the problem with it?
> > 
> > I mean, I see lots of advantages, and really no disadvantages.

Your vision is quite selective, then.
 
> We are in complete agreement .. The only disadvantage is maybe we cover
> up and real error

... which is more than enough to veto it.  However, that is not all.
Consider the following scenario:

1) gcc gives false positive
2) tosser on a rampage "fixes" it
3) code is chaged a month later
4) a real bug is introduced - one that would be _really_ visible to gcc,
with "is used" in a warning
5) thanks to aforementioned tosser, that bug remains hidden.

And that's besides making code uglier for no good reason, etc.

Consider that preemptively NAKed.
