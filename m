Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTKZAKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 19:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbTKZAKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 19:10:36 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:33037 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263846AbTKZAKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 19:10:35 -0500
Date: Tue, 25 Nov 2003 16:10:29 -0800
From: jw schultz <jw@pegasys.ws>
To: Ondrej Jombik <nepto@pobox.sk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: POSSIBLE BUG: certain writes to pipe block (after select())
Message-ID: <20031126001029.GF10144@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Ondrej Jombik <nepto@pobox.sk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0311251258420.27648-100000@Maxim.Platon.SK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0311251258420.27648-100000@Maxim.Platon.SK>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause confusion and disorientation to persons think they know everything.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 01:20:18PM +0100, Ondrej Jombik wrote:
> [ Please CC me in the answer as I am not in the list. ]
> 
> I discovered that certain writes to filedescriptor created with pipe()
> system call will block even if select() previously returned change on
> that filedescriptor -- of course select() returned change in "write"
> fd_set.
> 
> While doing a deep investigation, I find out, that this write only
> blocks if more than 4096 bytes are written. This is certain for 2.4.20,
> 2.4.21 and 2.6.0-test7 kernels. Other kernels were untested. What is
> more interesting is the fact, that PIPE_BUF kernel constant (defined in
> the file /usr/include/linux/limits.h) has value equal to 4096 bytes.
> 
> So when writting 4097 bytes write() blocks. When writting 4096 bytes it
> does not. However I had never seen during my information hunt an
> information, that only maximum PIPE_BUF bytes can be written into
> filedescriptor created with pipe() system call. I think this is the
> point of the whole thing, but I'm confused why this is not written
> anywhere.
> 
> But anyway, I would like to mention, that expected behaviour is, that
> write() will write 4096 bytes (so return value from write() syscall is
> 4096) and the rest should be up to user. So it has to be userspace deal
> to wait for writing remaining byte(s).

This is correct behavior.  popen opens the file descriptors
with having default flags.  Therefore they have blocking
enabled.  See fcntl(2).
