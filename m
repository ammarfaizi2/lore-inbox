Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269409AbUJFWRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269409AbUJFWRE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269494AbUJFWQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:16:51 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:59405 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S269409AbUJFWPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:15:15 -0400
Date: Thu, 7 Oct 2004 00:15:12 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davem@davemloft.net, Martijn Sipkema <martijn@entmoot.nl>,
       Andries Brouwer <aebr@win.tue.nl>,
       Joris van Rantwijk <joris@eljakim.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041006221512.GE4523@pclin040.win.tue.nl>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> <1097080873.29204.57.camel@localhost.localdomain> <Pine.LNX.4.58.0410061955230.7057@eljakim.netsystem.nl> <20041006193053.GC4523@pclin040.win.tue.nl> <1097090625.29707.9.camel@localhost.localdomain> <00f201c4abf1$0444c3e0$161b14ac@boromir> <1097094326.29871.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097094326.29871.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 09:25:28PM +0100, Alan Cox wrote:

> The current setup has so far been found to break one app, after what
> three years. It can almost double performance. In this case it is very
> much POSIX_ME_HARDER, and perhaps longer term suggests the posix/sus
> people should revisit their API design.

Maybe. Have we really investigated and concluded that there is no
reasonable way to follow POSIX and not harm performance?

I would hope that checksum failure is not the fast path,
so at zeroth sight, not having looked at the code, it seems
that we could do rather elaborate things on checksum failure
if we wanted to.

One such thing might be to raise a flag "I/O error seen since last read"
where the flag is cleared by read and causes an EIO when there is no
other input.

(There may be many objections - maybe such a setup would break
more user space programs. Or maybe there are more ways select
is broken than just the "discarded because of bad checksum" way.
But it seems too early to just say "too bad, our select is not
the POSIX one".)

Andries
