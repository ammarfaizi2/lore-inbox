Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269613AbUJFXTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269613AbUJFXTS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269617AbUJFXRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:17:04 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:52241 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S269531AbUJFXLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:11:25 -0400
Date: Thu, 7 Oct 2004 01:11:14 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martijn Sipkema <martijn@entmoot.nl>, Andries Brouwer <aebr@win.tue.nl>,
       Joris van Rantwijk <joris@eljakim.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041006231114.GC19761@alpha.home.local>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> <1097080873.29204.57.camel@localhost.localdomain> <Pine.LNX.4.58.0410061955230.7057@eljakim.netsystem.nl> <20041006193053.GC4523@pclin040.win.tue.nl> <1097090625.29707.9.camel@localhost.localdomain> <00f201c4abf1$0444c3e0$161b14ac@boromir> <1097094326.29871.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097094326.29871.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 06, 2004 at 09:25:28PM +0100, Alan Cox wrote:
 
> The current setup has so far been found to break one app, after what
> three years. It can almost double performance. In this case it is very
> much POSIX_ME_HARDER, and perhaps longer term suggests the posix/sus
> people should revisit their API design.

Couldn't we simply make recvfrom() return 0 (no data) or -1 (whatever error)
in a case where select() had a reason to believe that there were data, but
that the copy function discovered that it was corrupted data ?

This should not impact performance and would let recvfrom() behave in a
smarter way. After all, I don't see a problem receiving 0 bytes.

Anyway, I'm all for non-blocking I/O, but I can understand the stupidity
of the situation.

Just a few thoughts, of course.
Willy

