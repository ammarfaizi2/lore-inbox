Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317472AbSGTTjH>; Sat, 20 Jul 2002 15:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSGTTjH>; Sat, 20 Jul 2002 15:39:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:56817 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317472AbSGTTjG>; Sat, 20 Jul 2002 15:39:06 -0400
Subject: Re: 2.2 to 2.4... serious TCP send slowdowns
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hayden Myers <hayden@spinbox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10207191302330.32173-100000@compaq.skyline.net>
References: <Pine.LNX.4.10.10207191302330.32173-100000@compaq.skyline.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Jul 2002 21:53:42 +0100
Message-Id: <1027198422.16819.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-19 at 18:04, Hayden Myers wrote:
>  seemed to help.  I believe the problem is definately with sending the
>  files over the line.  We files are read into the socket to be sent across
>  the network byte by byte.  The boss says this is the best way to do it but
>  I'm curious if this is so.  The code that reads the file into the socket
>  to go across the network is below.  

Your buffers are way too small buf_cnt wants to be probably 60K or
higher. Making it large ensures one write syscall will fill all
available space in the queue immediately drastically reducing syscall
and wakeup rates. Also avoiding breaks in streaming.

>  The application is a single threaded app using a multiprocess pre forking
>  model if that helps any.  I'm really baffled as to why using the 2.4
>  kernel is slowing us down.  Any help is appreciated.  Sorry if this has
>  come up before.  I really have been looking for help for quite some time
>  before posting this.

Without tcpdump data its hard to guess

