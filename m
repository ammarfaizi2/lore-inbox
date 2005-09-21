Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVIUEzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVIUEzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 00:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVIUEzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 00:55:33 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:18999 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751015AbVIUEzd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 00:55:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iR8fyVeFQPZM11tbED4wxcq18NySeZMMZWt+04cZx4H6DuZbcL4oOXAOY2lY3X27VsZJy1m2GQ2CNcBmxDRn7UrquJ+bNntiSX06MF0b5IGnrGSpA+rg0T01navLLd/4eku8oAi9ofPp83k61wZkkk34rd3wm9fdZh9p08utcLM=
Message-ID: <e692861c05092021552d39cecc@mail.gmail.com>
Date: Wed, 21 Sep 2005 00:55:32 -0400
From: Gregory Maxwell <gmaxwell@gmail.com>
Reply-To: gmaxwell@gmail.com
To: Hans Reiser <reiser@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Cc: Ric Wheeler <ric@emc.com>, vitaly@thebsh.namesys.com,
       "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@suse.cz>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <4330CDF1.4050902@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>
	 <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz>
	 <20050921000425.GF6179@thunk.org> <4330A8F2.7010903@emc.com>
	 <4330ACE2.8000909@namesys.com> <4330B388.8010307@emc.com>
	 <4330CDF1.4050902@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/05, Hans Reiser <reiser@namesys.com> wrote:
> > I am not a big fan of formal committees, but would be happy to take
> > part in any effort to standardize, code and test the result...
> The committee could simply exchange a set of emails, and agree on
> things.  I doubt it needs to get all complicated.  I suggest you contact
> all the folks you want to be consistent with each other, send us an
> email asking us to all try to work together, and then ask for proposals
> on what we should all conform to.  Distill the proposals, and then
> suggest a common solution.  With luck, we will all just say yes.:)

Another goal of the group should be to formulate a requested set of
changes or extensions to the makers of drives and other storage
systems.  For example, it might be advantageous to be able to disable
bad block relocation and allow the filesystem to perform the action. 
The reason for this is because relocates slaughter streaming read
performance, but the filesystem could still contiguously allocate
around them...

Perhaps a more implementable alternative is just a method to find out
which sectors have been relocated so the data can be moved off of them
and they be avoided. (and potentially they be 'derelocated' to
preserve the relocation space)

Ditto for other layers.. if a filesystem has some internal integrity
function and a raid sweep has found that the parity doesn't agree, it
would be nice if the FS could check all possible decodings and see if
there is one that is more sane than all the others... This is even
more useful when you have raid-6 and there is a lot more potential
decoding.

Also things like bubbling up to userspace.. If there is an
unrecoverable read error in a file found during operation or an
automated scan, it should show up in syslog with some working complete
path to the file (as canonical as the fs can provide), and hopefully
an offset to the error. Then my package manager could see if this is a
file replaceable out of a package or if it's user data... If it's user
data, my backup scripts can check the access time on the file and
silently restore it from backup if the file hasn't changed. ... only
leaving me an email "Dear operator, I saved your butt yet again
--love, mr computer"

And finally operator policy.. I'd like corrupted user files to become
permission denied until I run some command to make the accessible,
don't let me hang my apps trying to access them..
