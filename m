Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269555AbUKAP6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269555AbUKAP6Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268856AbUKAP6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 10:58:21 -0500
Received: from [193.112.238.6] ([193.112.238.6]:50311 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S273271AbUKAPnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 10:43:12 -0500
From: John M Collins <jmc@xisl.com>
Organization: Xi Software Ltd
To: linux-kernel@vger.kernel.org
Subject: Re: Fchown on unix domain sockets?
Date: Mon, 1 Nov 2004 15:43:04 +0000
User-Agent: KMail/1.6.1
References: <200410312255.00621.jmc@xisl.com> <200411011441.56524.jmc@xisl.com> <Pine.LNX.4.53.0411011546050.30106@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411011546050.30106@yvahk01.tjqt.qr>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200411011543.04881.jmc@xisl.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 Nov 2004 14:49, you wrote:
> >> As some manpage might say, the socket thing you see in "ls -l" is just a
> >> reference thing. When you connect to it, ls -l /proc/pidofprogram/fd/
> >> does not show the path, but [socket:xxxx] which shows that the
> >> filesystem object is not used anymore.
> >
> >When I connect to it is the point. I want to set the permissions etc so
> > that only the progams that are supposed to be talking to it talk to it.
>
> How about setting the permissions beforehand?

We're talking about fchown not fchmod. Obviously you can set "umask" so that 
the appropriate permissions are on or off.

As I've said, I don't mind the answer "no" but I think it's wrong to silently 
do nothing.

What I'm trying to do is have a server process, which for various reasons has 
to run as root, create a socket for clients which belong to same package and 
are all set-user to "packageusername" to send requests and receive replies. I 
don't want all and sundry connecting and sending lumps of data and possibly 
making the server process do inappropriate things.

I don't have a problem - the server process creates the socket and then uses 
"chown" on the path name before clients start to get at it. Or I can invoke 
"seteuid" before creating the socket.

I just thought it would be worth drawing attention to the fact that "fchown" 
silently does nothing and the whole thing is not documented anywhere (even on 
OSes which give an error code). It just seemed a gap worth plugging.

-- 
John Collins Xi Software Ltd www.xisl.com
