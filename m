Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUAAXJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 18:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUAAXJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 18:09:28 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:16329 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S261681AbUAAXJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 18:09:26 -0500
Date: Fri, 2 Jan 2004 00:09:12 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jens Axboe <axboe@suse.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20040101230911.GA28438@k3.hellgate.ch>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <20031230012551.GA6226@k3.hellgate.ch> <Pine.LNX.4.58.0312292031450.6227@localhost.localdomain> <20031230132145.B32120@hexapodia.org> <20031230194051.GD22443@holomorphy.com> <20031230222403.GA8412@k3.hellgate.ch> <Pine.LNX.4.58.0312301921510.3193@localhost.localdomain> <20031231101741.GA4378@k3.hellgate.ch> <20031231112119.GB3089@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231112119.GB3089@suse.de>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003 12:21:19 +0100, Jens Axboe wrote:
> the qsbench suckiness? Do you have numbers for 2.4.x and 2.6.1-rc with
> the various io schedulers (it would be interesting to see stock,
> elevator=deadline, and elevator=noop).

For 2.6 AS comes out on top. It seems though that AS may be at least
partially responsible for the exploding variance of run times for
qsbench.

I don't think we can compare 2.4 and 2.6 I/O schedulers for these
loads. The io scheduler can do only so much if the VM evicts the
wrong pages.

Average, times for ten runs (in seconds, ordered).

efax		avg
2.4.23		228.8 227 227 228 229 229 229 229 230 230 230
2.6.0 noop	861.8 833 855 860 865 866 866 867 867 869 870
2.6.0 deadline	846.1 813 827 830 845 850 854 856 859 861 866
2.6.0 as	850.8 827 834 839 840 840 841 864 864 874 885

kbuild		avg
2.4.23		140.4 116 118 124 125 132 150 153 157 161 168
2.6.0 noop	638.2 552 569 596 600 608 631 634 658 712 822
2.6.0 deadline	570.0 494 495 517 529 532 545 596 619 670 703
2.6.0 as	486.1 406 429 453 468 473 477 510 536 542 567

qsbench		avg
2.4.23		223.8 219 220 221 223 223 223 223 225 230 231
2.6.0 noop	380.0 333 343 374 377 382 389 391 391 403 417
2.6.0 deadline	368.8 339 361 361 372 372 373 375 377 377 381
2.6.0 as	329.3 253 279 281 286 300 355 371 374 388 406

Roger
