Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268504AbUILHOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268504AbUILHOC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 03:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268505AbUILHOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 03:14:01 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:7143 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S268504AbUILHNy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 03:13:54 -0400
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local (probable Remote) Denial
	of Service
From: Peter Zaitsev <peter@mysql.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: "David S. Miller" <davem@davemloft.net>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20040912065608.GC1444@alpha.home.local>
References: <022601c49866$9e8aa8f0$0300a8c0@s>
	 <000001c49872$99333460$0200a8c0@wolf>
	 <20040911204710.4aa7abed.davem@davemloft.net>
	 <1094970424.29211.489.camel@sphere.site>
	 <20040912065608.GC1444@alpha.home.local>
Content-Type: text/plain
Message-Id: <1094973089.29211.507.camel@sphere.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 12 Sep 2004 00:11:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-11 at 23:56, Willy Tarreau wrote:
> Hi Peter,
> 
> On Sat, Sep 11, 2004 at 11:27:05PM -0700, Peter Zaitsev wrote:
>  
> > I do not care about TIME_WAIT  connection on client site itself, what
> > concerns me is, until connection is not fully closed server side does
> > not seems to be informed connection is dead and so  server resources are
> > not deallocated.    
> > 
> > Any ideas ? 
> 
> TIME_WAIT status does not eat much resource, since they're in a separate
> list. I've already had several *millions* of while stressing some equipment,
> and I can assure you that it's really not a problem as long as you increase
> your tcp_max_tw_buckets accordingly. There is even no performance impact
> (I could still get 40000 hits/s with this number of time-waits). As David
> said, the connection has been closed when it enters TIME_WAIT, so it has
> been detached from apache.

Once again,

I do not care about resources on Client side (Apache/PHP). My concern is
Server side (MySQL).  MySQL will close connection after timeout, which
is normally large (hours) to support interactive clients, or when it is
informed socket is closed.   This last part is getting very delayed,
300+ seconds for some reason.


> 
> I think you confuse it with CLOSE_WAIT. This is a very common case on web
> servers when the client does not support HTTP keep-alive and does a
> shutdown(WRITE) after sending its request. The server receives the FIN, and
> passes from ESTABLISHED to CLOSE_WAIT during all the time it sends its data
> to the client, then closes the connection, making it TIME_WAIT.

I'm not speaking about   HTTP server in this case at all but about
Apache/PHP to MySQL  part only.  

It is quite typical for each page load to establish connection so we can
end up with pretty large number of connections. 

To be honest I can't truly explain exactly when this happens - in many
cases I can see connections  closed on the server as soon as client
closes them, in other cases they are dangling for quite a time. 





-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



