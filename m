Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWATXw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWATXw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWATXw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:52:26 -0500
Received: from free.wgops.com ([69.51.116.66]:54020 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1750708AbWATXwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:52:25 -0500
Date: Fri, 20 Jan 2006 16:52:00 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Greg KH <greg@kroah.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <EB336A2509046CFEBF52A9E2@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <20060120232703.GB20949@kroah.com>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 <20060120155919.GA5873@stiffy.osknowledge.org>
 <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
 <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr>
 <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com>
 <20060120194331.GA8704@kroah.com>
 <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com>
 <20060120232703.GB20949@kroah.com>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 3:27:03 PM -0800 Greg KH <greg@kroah.com> wrote:

> devfs is long dead and gone.  It's going to be much easier for you to
> probably just change your userspace config to handle this.
>
> If you need any help doing this, please ask on the linux-hotplug-devel
> mailing list, where lots of people can help you out.
>
> Or, just add the CONFIG_DEVFS config option to your .config, and build
> devfs into the 2.6.15 release.  The code is still there...

That's going to be more or less what will happen for the cases I need to go 
to 2.6.15 and can't just apply a short patch or cp of new source.  I have 
to patch up Kconfig's though too since make-kpkg will run a make oldconfig 
which will remove options it doesn't see, normally a good thing.  For other 
problems it looks like I'll begin to maintain my own kernel forks atleast 
in the short run.

> There's nothing we can do about out-of-the-tree kernel versions, see
> Documentation/stable_api_nonsense.txt about why you should get those
> modules into the main kernel tree.

I know, and I don't expect the LK people to maintain any of my code in any 
way, nor any member outside of the teams it was developed in and for.

> And before you say, "but they are only for some very odd and not popular
> devices, no one would want them in the kernel tree!", remember that we
> have whole arches that are only run by about 2 users.  I know
> specifically about a few drivers that only work on 1 device in the whole
> world.  So this isn't a good excuse :)

OK well, this I hadn't realised, my impression was that the case was mostly 
or entirely opposite of this.  That a new bit had to have really good buy 
in before it could get anywhere near any mainline development, much less 
release cycles.  I'll have to get really snuggly with the whole release 
policy again, I was under the (now I see very wrong, I'm sorry gents) 
impression there wasn't this major of a shift going on.  I simply don't 
have the bandwidth to follow l-k most of the time.

> Your other issues sound like they will be fixed with the latest kernel
> version, if not, please let us know.

Except for any new ones I might find ;)  Which is where this whole thread 
got started in my mind anyway.

>
>> I think I have more kernel bugs and can go on, but I'll just be told
>> 'upgrade to 2.6.15' which is not an option in many cases if these are
>> indeed development releases, if only 'politically', but there are often
>> real costs involved.
>
> Then what do you expect us to do?  And what are those costs?

Any idea how much work it takes to re load test a kernel, do all the 
required research to make sure you're not introducing new bugs, etc? 
Usually, per arch, for me, it takes about a week, sometimes two.  This last 
round I rushed myself and decided not to test the NFS portion and got bit 
by that see some related NFS posts on that that I made if you're interested 
in that saga, sounds like 2.6.8.1 might fix this...I need to figure out 
what debian policy is in getting these new fourth dot changes applied and 
mainstreamed but that's a separate issue altogether.

Yes part of it is internal distribution policy, but it's also just plain 
good sense.  When all the new development and radical changes are happening 
in the same place you have to look for bug fixes it actually becomes more 
expensive to deploy because you ultimately end up with a lot more change 
between kernel upgrades.

It sounds like I'll atleast be trying to provide such a 'stable patched 
kernel' tree fork area for people to point at, and see if there's enough 
interest to keep it up.  I'm not certain about being able to publicly 
maintain such a beast myself.

> I hear sf.net hosts patches for free :)  I know of a specific big distro
> vendor that likes to burry their patches there to apease the letter of
> the GPL, and make it hard for others to figure out where the code is...

Now now, leave the skeletons alone. ;)  They seem perfectly happy where 
they're at.  Not sure if SF's system has improved any, but it used to be 
pretty clunky to attempt to publish and maintain patch sets and releases, 
or it felt like it to me.  Then again, I have a severe aversion to web UIs 
in that regard.

Thanks for the assistance guys.  Atleast I've got a direction instead of 
being backed completely into a wall and have a lot deeper understanding of 
some of the feelings of the group on all of this.


