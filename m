Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbTAVTKZ>; Wed, 22 Jan 2003 14:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTAVTKZ>; Wed, 22 Jan 2003 14:10:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:32175 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262089AbTAVTKY>;
	Wed, 22 Jan 2003 14:10:24 -0500
Date: Wed, 22 Jan 2003 11:14:14 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jamie Lokier <jamie@shareable.org>
cc: Ed Tomlinson <tomlins@cam.org>, <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
In-Reply-To: <20030122132040.GA4752@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.33L2.0301221112160.3511-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Jamie Lokier wrote:

| Ed Tomlinson wrote:
| > Jamie Lokier wrote:
| >
| > >         jtimeout = 0;
| > >         if (timeout) {
| > >                 /* Careful about overflow in the intermediate values */
| > >                 if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
| > >                         jtimeout = (unsigned long)(timeout*HZ+999)/1000+1;
| > >                 else /* Negative or overflow */
| > >                         jtimeout = MAX_SCHEDULE_TIMEOUT;
| > >         }
| >
| > Why assume HZ=1000?  Would not:
| >
| > timeout = (unsigned long)(timeout*HZ+(HZ-1))/HZ+1;
| >
| > make more sense?
|
| No, that's silly.  Why do you want to multiply by HZ and then divide by HZ?

OK, I don't get it.  All Ed did was replace 1000 with HZ and
999 with (HZ-1).  What's bad about that?  Seems to me like
the right thing to do.  Much more portable.

What if HZ changes?  Who's going to audit the kernel for changes?

-- 
~Randy

