Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319023AbSIJAJZ>; Mon, 9 Sep 2002 20:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319024AbSIJAJZ>; Mon, 9 Sep 2002 20:09:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58898 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319023AbSIJAJY>; Mon, 9 Sep 2002 20:09:24 -0400
Date: Mon, 9 Sep 2002 17:17:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <20020909221727.GF7433@kroah.com>
Message-ID: <Pine.LNX.4.33.0209091714330.2069-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg, please don't do this

> ChangeSet@1.614, 2002-09-05 08:33:20-07:00, greg@kroah.com
>   USB: storage driver: replace show_trace() with BUG()

that BUG() thing is _way_ out of line, and has killed a few of my machines 
several times for no good reason. It actively hurts debuggability, because 
the machine is totally dead after it, and the whole and ONLY point of 
BUG() messages is to help debugging and make it clear that we can't handle 
something.

In this case, we _can_ handle it, and we're much better off with a machine 
that works and that you can look up the messages with than killing it.

Rule of thumb: BUG() is only good for something that never happens and 
that we really have no other option for (ie state is so corrupt that 
continuing is deadly).

		Linus

