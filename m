Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266126AbUG0QDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUG0QDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUG0QDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:03:12 -0400
Received: from holomorphy.com ([207.189.100.168]:21124 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266203AbUG0QBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:01:02 -0400
Date: Tue, 27 Jul 2004 09:00:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: raul@pleyades.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: The dreadful CLOSE_WAIT
Message-ID: <20040727160057.GE2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	raul@pleyades.net, linux-kernel@vger.kernel.org
References: <20040727083947.GB31766@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727083947.GB31766@DervishD>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 10:39:47AM +0200, DervishD wrote:
>     Seems under Linux that, when a connection is in the CLOSE_WAIT
> state, the only wait to go to LAST_ACK is the application doing the
> 'shutdown()' or 'close()'. Doesn't seem to be a timeout for that.
>     Well, I think this is dangerous because a bad application (and a
> couple of widely used servers have this problem) can exhaust system
> network resources (difficult, but possible). For example, a
> concurrent FTP server with a race condition that doesn't do the
> shutdown when the remote end aborts. Writing such a 'bad app' is very
> easy, just do the socket->bind->listen->accept and after accepting
> the connection forget the connected socket and keeps on listening. If
> the remote end aborts, the server leaves the connection in
> CLOSE_WAIT. Sometimes it has a associated timer, when data remains in
> the tx queue, it seems that the kernel tries to retransmit all that
> data, which makes no sense: in CLOSE_WAIT state the other end is not
> there... Surely I'm missing a lot :((

Probably best to implement timeouts by hand in your network daemon.


-- wli
