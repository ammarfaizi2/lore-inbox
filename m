Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267942AbUHKFGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267942AbUHKFGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 01:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267937AbUHKFGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 01:06:20 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:10409 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267942AbUHKFGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 01:06:17 -0400
Subject: Re: suspend2 merge [was Re: [RFC] Fix Device Power Management
	States]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, david-b@pacbell.net
In-Reply-To: <20040810233607.GC2287@elf.ucw.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
	 <20040809113829.GB9793@elf.ucw.cz>
	 <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
	 <20040809212949.GA1120@elf.ucw.cz>
	 <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net>
	 <1092130981.2676.1.camel@laptop.cunninghams>
	 <Pine.LNX.4.50.0408100655190.13807-100000@monsoon.he.net>
	 <1092176983.2709.3.camel@laptop.cunninghams>
	 <Pine.LNX.4.50.0408101544470.28789-100000@monsoon.he.net>
	 <1092179384.2711.29.camel@laptop.cunninghams>
	 <20040810233607.GC2287@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092200754.3843.21.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 11 Aug 2004 15:05:54 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-08-11 at 09:36, Pavel Machek wrote:
> At one point I was pretty unhappy with swsusp state (that was just
> before I wrote trivial highmem support), and was willing to merge
> suspend2 pretty much at all costs. (Okay, I was never willing to let
> LZO-suspend2 sneak into 2.6). I'm now way happier with merged
> pmdisk+swsusp works.

The LZF licensing has been corrected so it's not a problem.

> I feared big problems with highmem support, but surprisingly, trivial
> support thats in current code does not cause problems for
> people. People seem to like pmdisk+swsusp, too...

That will be because you're eating most of the memory anyway; there's
not problem finding enough memory to copy the Highmem too. I guess that
once we start seeing people trying to suspend 2GB to disk or you try to
eat less memory, Highmem will become more of a pain.

> Now, people like suspend2 even more, and for good reasons: it is
> extremely fast, it provides nice feedback and its refrigerator is
> superior.
> 
> I also realized that suspend2 is fundamentally more complex than
> swsusp: it introduces additional time period where page cache must not
> be touched. I did not realize this sooner.

Sorry. I said it in so many ways! It's not really an issue though;
processes are stopped and suspend's own I/O doesn't touch page cache.

> I do longer think that "merge at all costs" is good idea now: in
> kernel code is small, simple and nice by now, and I'd like to keep it
> that way.

I want it to be simple and clear too. I'm getting there. As part of the
cleanup, I'd just made suspend modular, which has further untangled some
of the interdependancies between sections of code. I still have more
work to do, but I'm increasingly feeling like removing the debugging
code.

> Now, there are some parts of swsusp that are not quite okay. One of
> them is refrigerator -- it fails (in non-critical way but still) in
> some cases where it should not fail. suspend2 seems to have this
> solved, and I'd like to merge its refrigerator.

I'll submit a patch. I need to look at how you use the refrigerator
first. I refrigerate processes prior to resuming as well, and might need
to adjust things if you don't do that. I also need to check it will work
okay with S3.

> Other parts... I'm not so sure. Incremental patches would certainly
> help a lot here.

Well, if you insist, I'll do what I can. I looked at doing this before,
but was like trying to describe how to transform a mini into a station
wagon while using it every day! It will, of course, make the merge
_much_ slower too.

Nigel
-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

