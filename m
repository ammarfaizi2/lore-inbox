Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317833AbSGVVkn>; Mon, 22 Jul 2002 17:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317842AbSGVVkn>; Mon, 22 Jul 2002 17:40:43 -0400
Received: from cs180154.pp.htv.fi ([213.243.180.154]:660 "EHLO devil.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S317833AbSGVVkm>;
	Mon, 22 Jul 2002 17:40:42 -0400
Subject: Re: 2.2 to 2.4... serious TCP send slowdowns
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
To: Hayden Myers <hayden@spinbox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10207221646120.4476-100000@compaq.skyline.net>
References: <Pine.LNX.4.10.10207221646120.4476-100000@compaq.skyline.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 23 Jul 2002 00:43:49 +0300
Message-Id: <1027374229.11240.17.camel@cs180154>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 00:13, Hayden Myers wrote: 

> I dumped the other side and it does confirm that the advertised window is
> increasing.  This is may not be the problem.  So if I understand
> correctly 2.4 has window scaling while 2.2 didn't and that's why the
> window advertisement is larger initially in the 2.2 than the 2.4.

The TCP window scaling option is something else. You are correct,
however, that 2.4 manages receiver side buffers differently and
therefore advertises differently. This is designed to save buffer memory
in a HTTP server and should actually be good for your application.

> I 
> still have a theory as to why this smaller window size and/or scaling
is
> slowing us down.
> 
> > 
> > The 6432 you're seeing is the server telling the client how much the
> > client is allowed send. Only, the client isn't sending anything. You
> > need to look at what the client is advertising to the server.
> The client's advertisement seems to increase as the packets keep rolling
> in.

Correct. 

> I just noticed a large number of delayed acks in /proc/net/netstat.  Do
> you think it's possible that a lot of clients have delayed ack and are
> holding up our connections?

Again, don't think so. Unless Alexey has changed something recently,
Linux quickacks every full sized segment immediately during the
slowstart phase. This means that, in the beginning, the congestion
window is growing as fast as the specs allow. 

If in doubt, you can set the TCP_NODELAY option. Just make sure your app
is sending full sized segments if you do this, otherwise it will just
degrade performance. 

Anyway, try posting some hard data. Maybe somebody on these lists can
figure it out.

	MikaL

