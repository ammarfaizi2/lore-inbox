Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbTCKJFF>; Tue, 11 Mar 2003 04:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbTCKJFF>; Tue, 11 Mar 2003 04:05:05 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:43677 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S262875AbTCKJFE>; Tue, 11 Mar 2003 04:05:04 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 11 Mar 2003 10:19:34 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: reducing stack usage in v4l?
Message-ID: <20030311091934.GB20721@bytesex.org>
References: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org> <87u1eigomv.fsf@bytesex.org> <20030305093534.A8883@flint.arm.linux.org.uk> <20030305073437.0673458e.rddunlap@osdl.org> <33000.4.64.238.61.1047356833.squirrel@www.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33000.4.64.238.61.1047356833.squirrel@www.osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That's an idea.  Or make separate called functions for each ioctl and
> > declare the structures inside them?
> 
> and this method looks like a possibility.
> 
> Gerd, Andrew says that the kmalloc() time will be small compared to
> the memset()'s that the function is already doing.

That is wrong, at least the 2k memset/call mentioned by Andrew.  There
are lots of memset() calls, but they all are within the case switches
for the ioctls and zero out only the structs which are used in that code
path, so it is actually much smaller (~50 -> ~300 bytes maybe, depending
on the ioctl).

> Do you want to do anything about this, or want me to, or want me
> to drop it?

It is on my todo list, just havn't found yet the time to do that.
Probably I'll split it into smaller functions, this looks like the
best way to me.

  Gerd

