Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSHGEdg>; Wed, 7 Aug 2002 00:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSHGEdg>; Wed, 7 Aug 2002 00:33:36 -0400
Received: from goshen.rutgers.edu ([165.230.180.150]:11906 "HELO
	goshen.rutgers.edu") by vger.kernel.org with SMTP
	id <S316882AbSHGEdf>; Wed, 7 Aug 2002 00:33:35 -0400
Date: Wed, 7 Aug 2002 00:37:09 -0400 (EDT)
From: Vasisht Tadigotla <vasisht@eden.rutgers.edu>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiple connect on a socket
In-Reply-To: <200208070210.GAA26429@sex.inr.ac.ru>
Message-ID: <Pine.GSO.4.21.0208070024110.19932-100000@er3.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >				Shouldn't it throw an error when I
> > try to connect to it a second time ? Am I missing something here.
> 
> Yes, it used to return success once upon connection is complete.
> 
> When the connection is in progress, it returns EALREADY,
> after this it returns EISCONN, but success is indicated when it goes
> from unconnected to connected state. Maybe, this is wrong but it used
> to work in this way.

since O_NONBLOCK is set for the socket fd, the initial connect will fail
with an EINPROGRESS, and the connection request is established
asynchronously. If there is another connect during this period before the
connection is established, as you said it returns EALREADY. This is after
the connection is established and I read data from the socket. Since the
connection is already established, a further connect attempt should return
EISCONN. This is the behaviour on SunOS and IRIX. 

On Linux if I attempt to connect to the same socket after the connection
has been established, connect() returns 0. I'm not sure if this is the
correct behaviour.


thanks,

vasisht




