Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUIVF6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUIVF6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 01:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUIVF6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 01:58:41 -0400
Received: from [217.111.56.18] ([217.111.56.18]:2691 "EHLO spring.sncag.com")
	by vger.kernel.org with ESMTP id S267904AbUIVF6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 01:58:39 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rainer Weikusat <rweikusat@sncag.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Implementation defined behaviour in read_write.c
In-Reply-To: <1095764243.30748.55.camel@localhost.localdomain> (Alan Cox's
 message of "Tue, 21 Sep 2004 11:57:48 +0100")
References: <878yb5ey11.fsf@farside.sncag.com>
	<1095764243.30748.55.camel@localhost.localdomain>
From: Rainer Weikusat <rainer.weikusat@sncag.com>
Date: Wed, 22 Sep 2004 13:58:06 +0800
Message-ID: <87k6umetg1.fsf@farside.sncag.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> On Llu, 2004-09-20 at 16:54, Rainer Weikusat wrote:
>> The following code is in the function do_readv_writev in the file
>> fs/read_write.c (2.6.8.1):
>
> The 2.4.x kernel has part of this fixed. In particular it does the
> overflow check differently because gcc 3.x in some forms did appear to
> be making use of the undefined nature of the test and that was a
> potential security hole. ("its undefined lets say its always
> false.."). The initial cast and test should be fine.

I assume you mean the cast at the beginning of the loop. According to
the C-standard, both cases are exactly the same (they are both
conversions of potentially nonrepresentable values).

	6.3.1.3 Signed and unsigned integers

	When a value with integer type is converted to another integer
	type other than _Bool, if the value can be represented by the
	new type, it is unchanged.

	[...]

	Otherwise, the new type is signed and the value cannot be
	represented in it; either the result is implementation-defined
	or an implementation-defined signal is raised.

The requirement for implementation defined is that the implementation
documents the behaviour (which gcc at least up to 3.4.4 doesn't). This
not a problem with the current compiler, but I happen to know by
coincedence that some people of unknown relations to the gcc team
(like the person who wrote this advisory:
<URL:http://cert.uni-stuttgart.de/advisories/c-integer-overflow.php>)
would like to turn it into a problem, because they strongly believe it
is "the right thing to do", so it may be unwise to rely on gcc for
treating this sanely, ie so that it doesn't break idioms which are in
rather common use.
