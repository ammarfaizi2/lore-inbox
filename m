Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269841AbUJHLq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269841AbUJHLq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269866AbUJHLq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:46:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:26780 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S269861AbUJHLqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:46:03 -0400
Date: Fri, 8 Oct 2004 13:45:49 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: linux@horizon.com
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       cfriesen@nortelnetworks.com
Subject: Re: [PATCH] Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041008114549.GD7561@apps.cwi.nl>
References: <20041007124909.12995.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007124909.12995.qmail@science.horizon.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 12:49:09PM -0000, linux@horizon.com wrote:

> How about the following?

> +.B pselect
> +is currently emulated with a user-space wrapper that has a race condition.
> +For reliable (and more portable) signal trapping, use the self-pipe trick.
> +(Where a signal handler writes to a pipe whose other end is read by the
> +main loop.)

Thanks, added.

> +.B select
> +and
> +.B pselect
> +permit blocking file descritprs in the fd_sets, even though
> +there is no valid reason for a program to do this.

Hmm.

> +When
> +.B select
> +indicates that a file descriptor is ready, this is only a strong hint,
> +not a guarantee, that a read or write is possible without blocking.

Yes, perhaps.
It was easy to decide not to take your text, since it is far too long.

Presently I have

       Under Linux, select may report a socket file descriptor as
       "ready  for reading", while nevertheless a subsequent read
       blocks. This  could  for  example  happen  when  data  has
       arrived  but  upon  examination  has wrong checksum and is
       discarded. There may be other circumstances.  Thus it  may
       be  safer  to  use  O_NONBLOCK  on sockets that should not
       block.


Your above few lines on the self-pipe trick suffice for select.2,
but I wouldnt mind if you (or anybody else) wrote something a bit
more explicit in select_tut.2.

Andries

