Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWFIQVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWFIQVl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWFIQVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:21:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:11343 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750721AbWFIQVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:21:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iozTVcYFVEJfkZplgSkf8ZAH8KcFgDAFHNhI5kdFgpdkkb3PRcNACCllva85W1vZwRbE4YfC2HCDOvdqmpOOHn0OwJMfimzDMCDl/b193kbW4hYddT+pGIFn94wvf0/ie/tekCEoX7SVop5FKy61kQa4PiKG6AJ1Dakj6VdtuAQ=
Message-ID: <170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com>
Date: Fri, 9 Jun 2006 12:21:39 -0400
From: "Mike Snitzer" <snitzer@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Cc: "Alex Tomas" <alex@clusterfs.com>, "Christoph Hellwig" <hch@infradead.org>,
       "Mingming Cao" <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <44899113.3070509@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	 <20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net>
	 <44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net>
	 <4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net>
	 <44899113.3070509@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/06, Jeff Garzik <jeff@garzik.org> wrote:
> Alex Tomas wrote:
> > PS. in the end this is just ext3 with one more feature ...
>
> Incorrect.  You have to look at ext3 development over time.  This is a
> PATTERN with ext3 development:  mutating the metadata over time in a
> progressively incompatible manner.
>
> You have this thing called "ext3", which fools an admin into thinking
> they can use their filesystem with any kernel that has "ext3" support.
> That's somewhat true today, but with extents it will become false.
> Having a mutating definition of "ext3" is a convenience for developers,
> and for users WHO ONLY MOVE FORWARD in kernel versions.
>
> A 48bit ext3 filesystem with extents is completely unusable in 2.4.30's
> "ext3" or 2.6.10's "ext3".  Users are forced to hunt down the specific
> kernel version when an incompatible feature was added to ext3.  How can
> that possibly be described as "user friendly"?
>
> "Which ext3 am I talking to, today?"
> "And which kernels am I locked into, in order to talk to my filesystem?"
>
> Not all users are big production houses that plan their filesystem
> metadata migration months in advance!  I _guarantee_ some users will
> boot into ext3-with-extents, use it for a while, and then try to
> downgrade for whatever reason...  only to find they have been LOCKED
> OUT.  That is a very real world situation, guys.

Jeff,

I think all of us do understand what you're saying and on some level
are willing to accept that ext3-with-extents is in fact worthy of
branching to ext4, hence the url that has hosted the development of
extents (mballoc, delalloc, 48bit etc):
http://www.bullopensource.org/ext4/

But it _seems_ you're trying to paint ALL the ext3-developers as a
narrow minded lot.  If and when users decide to enable ext3 extents on
their filesystems they will presumably understand that doing so
precludes their ability to boot older kernels (steps can be taken to
make them well aware of this). The "real world situation" you refer
to, while hypothetically valid, isn't something informed
ext3-with-extents users will _ever_ elect to do.

Once a compelling feature is introduced Linux users embrace it and
never look back (provided it is stable!).  The real risk is the
(in)stability of all these ext3 improvements.  Stability is obviously
a requirement for merging these changes but I for one find it
refreshing that the current desire is to merge extents with ext3
(implicitly speaks to its stability when you couple that desire with
the fact that so many ext3 stakeholders are onboard!).

And as an aside, merging extents with ext3 forces ext3-developers to
be somewhat conservative about what bells and whistles they'd be
introducing moving forward.  The worst thing would be for these ext3
improvements to get merged into a new ext4 that becomes wildly known
as "the experimental ext3++".  I suppose developer discipline would
prevent such an unfortunate distinction but a new ext4 sandbox _could_
open the flood gates.

Developers never _want_ to branch (maintenance-hell), the question
becomes: do the risks associated with ext3-with-extents' backword
incompatibility _really_ justify the branch?

Mike
