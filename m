Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbULHDEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbULHDEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 22:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbULHDDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 22:03:16 -0500
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:38786 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262026AbULHDCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 22:02:55 -0500
Subject: Re: Time sliced CFQ io scheduler
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20041208025127.GL16322@dualathlon.random>
References: <20041202134801.GE10458@suse.de>
	 <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de>
	 <20041208003736.GD16322@dualathlon.random>
	 <1102467253.8095.10.camel@npiggin-nld.site>
	 <20041208013732.GF16322@dualathlon.random>
	 <20041207180033.6699425b.akpm@osdl.org>
	 <20041208022020.GH16322@dualathlon.random>
	 <20041207182557.23eed970.akpm@osdl.org>
	 <1102473213.8095.34.camel@npiggin-nld.site>
	 <20041208025127.GL16322@dualathlon.random>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 14:02:51 +1100
Message-Id: <1102474971.8095.51.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 03:51 +0100, Andrea Arcangeli wrote:
> On Wed, Dec 08, 2004 at 01:33:33PM +1100, Nick Piggin wrote:
> > I think we could detect when a disk asks for more than, say, 4
> > concurrent requests, and in that case turn off read anticipation
> > and all the anti-starvation for TCQ by default (with the option
> > to force it back on).
> 
> What do you mean with "disk asks for more than 4 concurrent requests?"
> You mean checking the TCQ capability of the hardware storage?
> 

Yeah. Just check if there are more than 4 outstanding requests at once.

> > I think this would be a decent "it works" solution that would make
> > AS acceptable as a default.
> 
> Perhaps the code would be the same but if you disable it completely on
> certain hardware that's not AS anymore...
> 

Which is what we want on those system ;)

> Then I believe it would be better to switch to cfq for storage capable
> of more than 4 concurrent tagged queued requests instead of sticking
> with a "disabled AS". What's the point of AS if the features of AS are
> disabled?
> 

For everyone else, who do want the AS features (ie. not databases).

> One relevant feature of cfq is the fairness property of pid against pid
> or user against user. You don't get that fairness with the other I/O
> schedulers. It was designed for fairness since the first place. Fariness
> of writes against writes and reads against reads and write against reads
> and read against writes.

That is something, I'll grant you that.


