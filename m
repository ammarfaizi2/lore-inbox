Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTKNFY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 00:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264570AbTKNFY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 00:24:26 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:59637 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264569AbTKNFYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 00:24:25 -0500
Date: Fri, 14 Nov 2003 00:13:00 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Davide Libenzi <davidel@xmailserver.org>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031114051300.GA3466@pimlott.net>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FAFD1E5.5070309@zytor.com> <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com> <20031110183722.GE6834@x30.random> <3FAFE22B.3030108@zytor.com> <20031110193101.GF6834@x30.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031110193101.GF6834@x30.random>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 08:31:01PM +0100, Andrea Arcangeli wrote:
> It maybe also cleaner to use a slightly more complicated but more
> compact algorithm, this would make a potential new rsync command line
> option cleaner since only 1 sequence file would need to be specified:
> 
> 	do {
> 		seq = fetch(sequence-file);
> 		if (seq & 1)
> 			break;
> 		rsync
> 		if (seq != fetch(sequence-file))
> 			seq = 1;
> 	} while (seq & 1 && sleep 10 /* ideally exponential backoff */)
> 
> this way only 1 sequence-file is needed for each repository that we want
> to checkout. the server side only has to increase twice the same file
> before and after each update of the repository, so the server side is
> even simpler (with the only additional requirement that the sequence
> number has to start "even"), only the client side is a bit more complicated.

For transparency, I would change the file contents to "updating"
during an update, instead of the even-odd thing.  I think this will
make it more obvious to people how to use it properly.

Andrew
