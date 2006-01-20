Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWATU4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWATU4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWATU4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:56:19 -0500
Received: from free.wgops.com ([69.51.116.66]:35857 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S932172AbWATU4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:56:18 -0500
Date: Fri, 20 Jan 2006 13:56:12 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Greg KH <greg@kroah.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <20060120194331.GA8704@kroah.com>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 <20060120155919.GA5873@stiffy.osknowledge.org>
 <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
 <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr>
 <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com>
 <20060120194331.GA8704@kroah.com>
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



--On January 20, 2006 11:43:31 AM -0800 Greg KH <greg@kroah.com> wrote:

> On Fri, Jan 20, 2006 at 10:14:15AM -0700, Michael Loftis wrote:
>> The problem here is I'm spending a lot of my time lately fixing things
>> that  shouldn't need fixing.  Things that are/were developed against
>> what was  supposed to be a stable major version and has been turned into
>> a  development version.
>
> What specifically are you "fixing"?

At this point I'm looking at bugs in the aic7xxx driver, it mostly works in 
2.6.8, occasionally locking up my tape subsystem, it's apparently fixed in 
2.6.15 or 2.6.15.1, I need to look closer into that, and backport it 
because of the devfs issue I don't think I can take 2.6.15/2.6.15.1 whole 
hog.  A decent amount of ARM stuff moving around between even just 2.6.11 
and 2.6.13 (admittedly that's a gripe for ARM) making development for that 
port very painful (there's talk of switching to something else because of 
all of this for those projects) -- no specifics on the ARM stuff as I'm not 
the developer directly involved with most that, I'm just doing some PHY 
code, which will eventually be submitted back to the mainstream ARM (still 
in product development) and he's indisposed today/at the moment, I'll try 
to get him to summarize those issues so I can relay them to the list.

As far as fixing there are modules that have been developped to run various 
embedded peripherals that must be reworked to use the newer kernel 
versions, which wouldn't be a problem if there weren't various other fixes 
that were needed which means moving up point revs.  Most of these other 
bugs are external to my work, but they affect my work.  The modules are 
completely isolated from the rest of the kernel though and they're for very 
particular hardware for different clients.

I'm having really weird serial console issues with 2.6.8, occasionally it 
just seems to 'hang' until one or more software flow control start/stops is 
sent.  This though *might* have something also to do with the blade 
chassis' virtual serial stuff, but however it's been totally fine in 2.4, 
and is fine once getty gets ahold of it, it's just during the initial 
bootup phases where it's being used as the console either by the rc scripts 
or by the kernel that seems to go wonky.  It goes out during the initial 
printk output, or sometimes later...exactly when seems to be a bit of a 
random thing.  Also it either causes, or is inputting NULL's or some other 
(consistent) garbage (CRLF? instead of CR?) on these same blades.  So you 
type root<ENTER> and get something like root<NULL><ENTER> or 
root<ENTER><NULL>  For those interested the interaction is with RLX (now 
bought by HP and no longer manufactured new as of a couple months ago) HPC 
Blade Chassis.  I'm guessing that maybe it's fixed somewhere in between 
2.6.8 and 15 (hoping it is) but until I find and backport fixes to 
something with devfs I won't be able to find out.  Part of the problem here 
is yes I'm running and using distros, and in house things, that are built 
on and using devfs.  A big problem I'm having is (yes an issue for Debian 
maintainers but caused by what by all rights looks/should be maintenance 
release of the kernel) the fact that Deb. Sarge's mkinitrd fails because it 
can't find devfs.  That might be because the current system is using devfs 
and mkinitrd just wants to replicate whats loaded/used now, I have to dig a 
lot deeper into that, yes I agree it's a debian-with-2.6.15.1 bug but the 
lack of bugfixes into/with 2.6.8 (or anywhere apparently now :/ ....).


I think I have more kernel bugs and can go on, but I'll just be told 
'upgrade to 2.6.15' which is not an option in many cases if these are 
indeed development releases, if only 'politically', but there are often 
real costs involved.  And with nowhere to put patches that end up in 
maintenance releases we're forced to maintain our own private forks, and 
likely, because of the GPL, also publish these forks and incur all the 
costs associated with that directly, and hope they don't become 
popular/wanted outside of the customer base they're intended for, or skirt 
the GPL, and only allow customers access to this stuff.

> What version are you finding things that work, and then later, not work?
>
> Are you properly looking at the required version of things in the README
> file?
>
> Again, specifics please, otherwise nothing can have a chance of getting
> better.

The bugs are only the small part of what I see as a larger issue though.  I 
know I can get the bugs fixed, atleast in the latest development releases, 
whatever their version numbers are.  I'm in an odd position of working for 
a web hosting company, *and* doing my own Linux consulting as well, and 
maintaining some 'embedded distros' used in these specific niche 
applications.

But pass that along to the customer/client I hear you say.  At that point 
it quickly starts to become cheaper to use VxWorks or something else and 
abandon Linux altogether.  I don't want to do that because ultimately it's 
the strength of the community that makes Linux the better choice.  There's 
also obviously significant time invested in existing work.  I think that 
also Linux is ultimately a much more well featured, and generally stable 
(operating wise as far as I know we can compile and run it on X platform 
and it runs for 6 months without problems) kernel.

I'm not trying to attack any of the developers here at all.


> thanks,
>
> greg k-h
>



--
"Genius might be described as a supreme capacity for getting its possessors
into trouble of all kinds."
-- Samuel Butler
