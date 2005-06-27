Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVF0Pdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVF0Pdv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVF0PbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:31:11 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:11017 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261257AbVF0PTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 11:19:05 -0400
Message-ID: <42C018E5.8030805@slaphack.com>
Date: Mon, 27 Jun 2005 10:19:01 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Markus T?rnqvist <mjt@nysv.org>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org>
In-Reply-To: <20050627124255.GB6280@thunk.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Theodore Ts'o wrote:
> On Mon, Jun 27, 2005 at 12:21:38PM +0300, Markus   T?rnqvist wrote:
> 
>>On Thu, Jun 23, 2005 at 11:34:50PM -0400, Horst von Brand wrote:
>>
>>>David Masover <ninja@slaphack.com> wrote:
>>
>>>>I think Hans (or someone) decided that when hardware stops working, it's
>>>>not the job of the FS to compensate, it's the job of lower layers, or
>>>>better, the job of the admin to replace the disk and restore from
>>>>backups.
>>>
>>>Handling other people's data this way is just reckless irresponsibility.
>>>Sure, you can get high performance if you just forego some of your basic
>>>responsibilities.
>>
>>Your honest-to-bog opinion is that the FS vendor is responsible for
>>the admin not taking backups or the hardware vendor shipping crap?
>>
>>*still trying to understand how that can be*
> 
> 
> Most Linux users are using PC-class hardware.  And Ted's First Law of
> PC-Class Hardware is: "Most of it is crap".  And then there's Ted's
> Second Law, "Too many system administrators don't do backups".

Not our problem anymore.  This is like saying that we should run all
filesystems in synchronous mode because some users will grab stuff out
of the computer without unmounting it -- even more a problem now that we
have SATA, which supports hot-swapping.

Too many system administrators don't do backups?  Some day the building
will burn down and they will wish they had.

> So it's a matter of matching the filesystem to the needs of the user.

My needs are a filesystem which doesn't assume I'm an idiot who can't
make backups.

> If you have a filesystem which is blazingly fast, but which at the
> slightest sign of trouble, trashes your data, versus one which is fast
> but perhaps not-so-fast as the other filesystem, but which is much
> more reliable, which would you choose?  

Hypothetically?  I choose the faster one.  Failures happen only rarely,
and when they happen, there's no telling how small or large they will
be, therefore I keep regular backups, and as soon as I see my hardware
starts to fail, I grab what I can off of it, merge that with the latest
backup, and buy new hardware.

> XFS has similar issues where it assumes that hardware has powerfail
> interrupts, and that the OS can use said powerfail interrupt to stop
> DMA's in its tracks on an power failure, so that you don't have
> garbage written to key filesystem data structures when the memory
> starts suffering from the dropping voltage on the power bus faster
> than the DMA engine or the disk drives.  So XFS is a great filesystem
> --- but you'd better be running it on a UPS, or on a system which has
> power fail interrupts and an OS that knows what to do.

XFS, Reiser3, and Reiser4 all pass the pull-the-plug test.  Maybe I just
haven't pushed them hard enough?

> Ext3, because
> it does physical block journalling, does not suffer from this problem.
> (Yes, Resierfs uses logical journalling as well, so it suffers from
> the same problem.)

I don't actually understand the difference here.  Are we talking about
metadata journalling vs. data journalling?

> So perhaps it's not the job of the FS vendor to be responsible for
> crap hardware or lazy sysadmins that don't do backups.

Good!  Glad we agree!

> But a system
> administrator who knows that he doesn't do backups frequently enough,
> or is running on cheap, crap hardware, would be wise to consider
> carefully which filesystem he/she wants to use given the systems
> configuration and his backup habits.  

Given a choice between changing filesystems or getting a Streamload
account, I choose Streamload.  (streamload.com)

Given a choice between reformatting or editing cron, I'd edit cron.

> Me, I'll go for the robust filesystem, just on general principles.  As
> a friend from the large-scale enterprise storage world once put it,
> "Performance is Job 2.  Robustness is Job #1."  (Of course, if you
> want to put your fragile filesystem on a multi-million dollar
> enterprise storage system such as an IBM Shark or an EMC Symmetrix
> box, I'm sure IBM or EMC will be happy to sell you one.  :-)

Job 1 is done by either that system or by good backups.  Don't overkill
Job 1 at the expense of Job 2.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsAY5XgHNmZLgCUhAQJq6g/9G2GEK0R1kujoqn3tjsTIbgC23iu8byYV
d6NHSrmmDV8035oo5iCgjSXbaTlIEyOQQqSB78fBC27eHbGctEZJIpSQfHrWlJu6
UJvvaEyl+sR/Mzq8sButKeSUv/T8RMCBKyhdfSgm28lDM/kt9OGZcrf1P1ChUSeK
ZnaToh4SAReRhGzq247o+qa2rW5IuIlpKeYGMZhiOB/tXGC3IDMtUOE9IBkn8KVd
TtDN4f74PuDJ9VX8K/tZ9DDtKebOJ1wKvIQ/BwyNXt5g36vwj2UwK6GkT2ZJ3bd6
2XLL24LpIBcVU16bk5WPkADRKe0W7S6AseUj7ggjAK0OL8z889vQ3NWJ/rmT/Wx7
OQi58QBwL89OZGSM2qZFJ09CLEH42GXD5jjTrKt4URudYzoIa45VZxD9YYhzeu5e
Gxxj4r2BM8bf/AHczCU/tEQwb6hfqxrq+SImWd1uIsozjeiwInHBC56x2qUDjFB/
kiyO1LVmVzrq+6frjPAg6n/i0zuPfF24SeeHX02UOx0jlNLkq2D4Qu1wDB5XlVTK
4xrN83Uy+dHSuDBvnf2tWTqmBju2YG6zmOl1xWKzi3/AVV6mfg1ur0gX0Q6GiZVa
5Nqp618Cs00ZtSk759eAPQRu7Ico0vTHhA0+rTUhApLYMboGaRN5W8OtQu2utHz8
ALX7pD3DrfE=
=wdYo
-----END PGP SIGNATURE-----
