Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268490AbUILG3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268490AbUILG3g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 02:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268488AbUILG3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 02:29:36 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:43214 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S268490AbUILG3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 02:29:33 -0400
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local (probable Remote) Denial
	of Service
From: Peter Zaitsev <peter@mysql.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Wolfpaw - Dale Corse <admin@wolfpaw.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20040911204710.4aa7abed.davem@davemloft.net>
References: <022601c49866$9e8aa8f0$0300a8c0@s>
	 <000001c49872$99333460$0200a8c0@wolf>
	 <20040911204710.4aa7abed.davem@davemloft.net>
Content-Type: text/plain
Message-Id: <1094970424.29211.489.camel@sphere.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 11 Sep 2004 23:27:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-11 at 20:47, David S. Miller wrote:

> If the application doesn't close it's file descriptors there is
> absolutely nothing the kernel can do about it.
> 
> It's a resource leak, plain and simple.
> 
> > That being said - below is a the proper description, and the code
> > used to exploit it. Hope it helps. This version is not the one
> > which invokes the CLOSE_WAIT state, but rather the TIME_WAIT one,
> > I am not able to publish the source code for the CLOSE_WAIT bug.
> 
> There is nothing wrong with creating tons of TIME_WAIT sockets,
> they simply time out after 60 seconds (unless hit by a RESET
> packet or similar).  This is how TCP works.
> 

Hm,

As this question arose may I ask where this timeout is configured ?

There is tcp_fin_timeout  configuration but I found nothing
corresponding to TIME_WAIT.

Here is how it bothers me.  On the Web sites using Apache/PHP and MySQL 
on different hosts I often see  "Sleep" connections hanging for many
minutes on MySQL hosts.    Tracking remote host and port shows this
connection is not assigned to any process on other end any more but
rather being in TIME_WAIT state. 

I do not care about TIME_WAIT  connection on client site itself, what
concerns me is, until connection is not fully closed server side does
not seems to be informed connection is dead and so  server resources are
not deallocated.    

Any ideas ? 



-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



