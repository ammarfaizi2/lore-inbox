Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317788AbSGVU3t>; Mon, 22 Jul 2002 16:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317790AbSGVU3s>; Mon, 22 Jul 2002 16:29:48 -0400
Received: from cs180154.pp.htv.fi ([213.243.180.154]:22418 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S317788AbSGVU3s> convert rfc822-to-8bit;
	Mon, 22 Jul 2002 16:29:48 -0400
Subject: Re: 2.2 to 2.4... serious TCP send slowdowns
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
To: Hayden Myers <hayden@spinbox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10207221603340.4476-100000@compaq.skyline.net>
References: <Pine.LNX.4.10.10207221603340.4476-100000@compaq.skyline.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.7 
Date: 22 Jul 2002 23:32:55 +0300
Message-Id: <1027369975.10556.24.camel@cs180154>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 23:09, Hayden Myers wrote:
> Is it possible the window scaling mechanism is slowing us down.  Since the
> connections are so short the window never scales upwards.

I'm pretty sure the window DOES scale upwards. As I said, you didn't
dump the other direction of the connection, which would actually SHOW
the advertised window.

The 6432 you're seeing is the server telling the client how much the
client is allowed send. Only, the client isn't sending anything. You
need to look at what the client is advertising to the server.

> Do you think
> I'd benefit by starting off with a larger window?

I don't think so. The transfer is unlikely to be limited by the
advertised window. Short TCP connections are constrained by the
congestion window, not the advertised window.

> My tests have shown
> that the 2.2 can handle more traffic with our application than the 2.4's
> I've used so far.  I would expect the 2.4 to be faster.  I imagine it's a
> tuning issue somewhere or an inefficient code issue.  I changed the code
> for sending files from the disk across the wire from using read and writen
> to sendfile and set the tcp cork option with setsockopt but contrary to
> everyones messages about it being faster, it slowed things down, more
> noticeably in 2.2.  

Not sure why you're seeing a difference here and it's hard to say
without a complete TCP dump. As far as I can see, the half­dump doesn't
exhibit any abnormalities.

This could easily be something completely unrelated to the networking
stack, however. You could be limited by file I/O, for instance. Have you
tried measuring pure TCP throughput without file access?

	MikaL

