Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268004AbUHKJNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268004AbUHKJNc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 05:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268007AbUHKJNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 05:13:32 -0400
Received: from gprs214-4.eurotel.cz ([160.218.214.4]:11392 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268004AbUHKJN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 05:13:29 -0400
Date: Wed, 11 Aug 2004 11:13:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, david-b@pacbell.net
Subject: Re: suspend2 merge [was Re: [RFC] Fix Device Power Management States]
Message-ID: <20040811091304.GD674@elf.ucw.cz>
References: <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net> <20040809212949.GA1120@elf.ucw.cz> <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net> <1092130981.2676.1.camel@laptop.cunninghams> <Pine.LNX.4.50.0408100655190.13807-100000@monsoon.he.net> <1092176983.2709.3.camel@laptop.cunninghams> <Pine.LNX.4.50.0408101544470.28789-100000@monsoon.he.net> <1092179384.2711.29.camel@laptop.cunninghams> <20040810233607.GC2287@elf.ucw.cz> <1092200754.3843.21.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092200754.3843.21.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I feared big problems with highmem support, but surprisingly, trivial
> > support thats in current code does not cause problems for
> > people. People seem to like pmdisk+swsusp, too...
> 
> That will be because you're eating most of the memory anyway; there's
> not problem finding enough memory to copy the Highmem too. I guess that
> once we start seeing people trying to suspend 2GB to disk or you try to
> eat less memory, Highmem will become more of a pain.

Yes, I know. I was just pleased that people do not complain as much as
I expected them to.

> > Now, people like suspend2 even more, and for good reasons: it is
> > extremely fast, it provides nice feedback and its refrigerator is
> > superior.
> > 
> > I also realized that suspend2 is fundamentally more complex than
> > swsusp: it introduces additional time period where page cache must not
> > be touched. I did not realize this sooner.
> 
> Sorry. I said it in so many ways! It's not really an issue though;
> processes are stopped and suspend's own I/O doesn't touch page
> cache.

Yes, I know it should work, it is just more things that need to be
verified.

> > Now, there are some parts of swsusp that are not quite okay. One of
> > them is refrigerator -- it fails (in non-critical way but still) in
> > some cases where it should not fail. suspend2 seems to have this
> > solved, and I'd like to merge its refrigerator.
> 
> I'll submit a patch. I need to look at how you use the refrigerator
> first. I refrigerate processes prior to resuming as well, and might need
> to adjust things if you don't do that. I also need to check it will work
> okay with S3.

Actually, we are not stopping processes prior to resuming, but I'd
call it a bug to be fixed.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
