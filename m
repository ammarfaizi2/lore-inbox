Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261611AbSJJPyM>; Thu, 10 Oct 2002 11:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261626AbSJJPyM>; Thu, 10 Oct 2002 11:54:12 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:43693 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261611AbSJJPyK>; Thu, 10 Oct 2002 11:54:10 -0400
Subject: Re: O_STREAMING has insufficient info - how about fadvise() ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: andersen@codepoet.org, Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Mark Mielke <mark@mark.mielke.cc>,
       Giuliano Pochini <pochini@denise.shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DA59DED.6167C13B@digeo.com>
References: <20021010032950.GA11683@codepoet.org>
	<1034249932.2044.128.camel@irongate.swansea.linux.org.uk> 
	<3DA59DED.6167C13B@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Oct 2002 17:08:48 +0100
Message-Id: <1034266128.7042.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 16:34, Andrew Morton wrote:
> In 2.5, the radix tree gang lookup thing will do this search in O(zilch).
> 
> The other problem with fadvise is writebehind - there are up to
> 30 seconds' worth of dirty pages behind the application's write
> cursor which fadvise wouldn't be able to do anything with.  So
> the application would end up running fadvise(offset=0, length=current-pos)
> all the time.   Which is equivalent to O_STREAMING.

The write side is actually not very interesting. We can do that already
with fsync in a thread.

