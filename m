Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269474AbUJFUth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269474AbUJFUth (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269470AbUJFUri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:47:38 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:59920 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S269474AbUJFUiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:38:22 -0400
Date: Wed, 6 Oct 2004 22:38:18 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: "David S. Miller" <davem@davemloft.net>, hzhong@cisco.com, aebr@win.tue.nl,
       joris@eljakim.nl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041006203818.GD4523@pclin040.win.tue.nl>
References: <003301c4abdc$c043f350$b83147ab@amer.cisco.com> <41644D86.4010500@nortelnetworks.com> <20041006130615.4f65a920.davem@davemloft.net> <4164530F.7020605@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4164530F.7020605@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 02:18:23PM -0600, Chris Friesen wrote:

> In any case, the current behaviour is not compliant with the POSIX text 
> that Andries posted.  Perhaps this should be documented somewhere?

For the time being I wrote (in select.2)

BUGS
       It has been reported (Linux 2.6) that select may report  a
       socket  file descriptor as "ready for reading", while nev-
       ertheless a subsequent read  blocks.  This  could  perhaps
       happen  when  data  has  arrived  but upon examination has
       wrong checksum and is discarded. Thus it may be  safer  to
       use non-blocking I/O.

(I have not yet investigated, just read the lk posts. Does this
really happen? All kernel versions? Is this the explanation for
the reported behaviour?)

> Alternately, how about having the recvmsg() call return a zero, and (if 
> appropriate) the length of the name set to zero?  This appears to comply 
> with the man page for recvmsg().

Returning 0 for a read signifies end-of-file. Not what you want.

Andries
