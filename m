Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWAUG7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWAUG7S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 01:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWAUG7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 01:59:18 -0500
Received: from free.wgops.com ([69.51.116.66]:26379 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1750974AbWAUG7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 01:59:17 -0500
Date: Fri, 20 Jan 2006 23:58:53 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <68C3222B770D473165308229@dhcp-2-206.wgops.com>
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



--On January 21, 2006 1:38:46 AM +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> 
wrote:

> On Gwe, 2006-01-20 at 13:56 -0700, Michael Loftis wrote:
>> and is fine once getty gets ahold of it, it's just during the initial
>> bootup phases where it's being used as the console either by the rc
>> scripts  or by the kernel that seems to go wonky.  It goes out during
>> the initial
>
> A bug where the serial console could get stuck on SMP IFF a kernel and a
> non kernel message were output at the same time did get fixed
> (yesterday) other than that I'm not aware of any problems in this area
> but the maintainer may have more ideas.
>
> Diff is tiny if you want to see if that is what you hit, although it
> would be remarkable co-incidence and luck if it was ;)

Coincidence I'm full of, and (bad) luck this week as well it seems.  I want 
to know who's black cat has been crossing my path.  This gives me a better 
direction to test it in.  The machines I have the problem with are all 
running SMP preemptible 2.6.8 on an HT machine with a single physical core, 
I'll try putting or booting them into a non-SMP kernel...if it's suddenly 
good, well....we found our rat.  That would though explain it pretty well 
since thinking about it, it doesn't happen in the debian installer nor... i 
think it's one of the gentoo installers or something...and those are 386 
non-SMP kernels.

Might've found some sort of wacky edge-case that can reproduce that bug 
reliably.  I'd be much appreciative if you pass a link or the diff itself 
along to me (or a specific bit to look for in archives/etc).  It might, or 
might not, be my little gremlin.  In the meantime I just leave off 
console=ttyS1,38400 and hold my breath while they boot.

>
>> printk output, or sometimes later...exactly when seems to be a bit of a
>> random thing.  Also it either causes, or is inputting NULL's or some
>> other  (consistent) garbage (CRLF? instead of CR?) on these same blades.
>> So you
>
> Never seen CR, nul reported. Would the blades happen to use rlogin to
> manage this remote serial do you know ?

No...telnet...though...I just realised I haven't verified that on anything 
but the BSD based telnet program on Mac OS X, and FreeBSD 4.11(ish), so 
really, it might be something there too, but again, 2.4 never sees these 
issues, and I'm really not sure what's getting into the stream, I think nul 
because I get a '^@' translated back at me, which IIRC is the 
representation for nul but lord knows if that's from the telnet client 
after it echos or what, I haven't done a packet dump of this gremlin, yet.

>
>> I think I have more kernel bugs and can go on, but I'll just be told
>> 'upgrade to 2.6.15' which is not an option in many cases if these are
>> indeed development releases, if only 'politically', but there are often
>> real costs involved.  And with nowhere to put patches that end up in
>
> Its hard to maintain an old release and just merge all the fixes into it
> backporting when neccessary. At the kernel summit before 2.6 this was
> discussed a lot. There are a small number of groups of people who wanted
> this for the long term. Said groups either maintain such trees and sell
> support/services for money, or rebuild the output of the former as a
> community project.
>
> It therefore seemed reasonable that those who want it should bear the
> cost, or figure out how to maintain such backports between themselves.

OK atleast I'm not total net.kook here.

>> maintenance releases we're forced to maintain our own private forks, and
>> likely, because of the GPL, also publish these forks and incur all the
>> costs associated with that directly, and hope they don't become
>> popular/wanted outside of the customer base they're intended for, or
>> skirt  the GPL, and only allow customers access to this stuff.
>
> The GPL is very careful about this. If you ship the sources to your
> customers then you have done your duty. If your customers choose to give
> it to others so be it. If the others ask you for changes then I believe
> the phrase is "business opportunity".
>
>> whatever their version numbers are.  I'm in an odd position of working
>> for  a web hosting company, *and* doing my own Linux consulting as well,
>> and  maintaining some 'embedded distros' used in these specific niche
>> applications.
>
> Embedded can be more problematic because it is harder to spread the
> load, but there are communities of people who looked at things like Red
> Hat Enterprise Linux and decided that they could use the code but didn't
> currently need/want the training, support and services that are what
> really makes it. One obvious example is Centos which is a community tree
> derived from the RHEL work, rebuilt, rebranded without
> support/services/etc and downloadable for free.

Yeah, embedded certainly is its own special little corner of heaven or hell 
depending on your view, or whims.
