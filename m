Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWATVsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWATVsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWATVsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:48:31 -0500
Received: from free.wgops.com ([69.51.116.66]:46095 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1751172AbWATVsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:48:30 -0500
Date: Fri, 20 Jan 2006 14:48:22 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <0FA349BF620394796EB40A3A@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <9a8748490601201220h2d85fa4au780715ff287cf1eb@mail.gmail.com>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>	
 <43D10FF8.8090805@superbug.co.uk>	
 <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>	
 <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com>	
 <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
 <9a8748490601201220h2d85fa4au780715ff287cf1eb@mail.gmail.com>
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



--On January 20, 2006 9:20:19 PM +0100 Jesper Juhl <jesper.juhl@gmail.com> 
wrote:

> On 1/20/06, Michael Loftis <mloftis@wgops.com> wrote:
>>
> [snip]
>> I'm trying to think of a way to relate this better but I just can't.
>> What's needed is a 'target' for incremental updates, things like minor
>> changes, bugfixes, etc.  I feel like supporting entirely new hardware
>
> That's called a vendor kernel.
> You pay the vendor money, the vendor maintains a stable (as in feature
> frozen) kernel, backports bugfixes for you etc.
> Take a look at the RedHat and SuSE enterprise kernels, they seem to be
> what you want.

RedHat's kernel is, I'm sorry, a car wreck of too many patches.  We tried 
that in the hosting environment, had many many gremlins as a result.  Most 
of which are still unresolved.  I've got httpd's and mysqld's that the 
root/listener process uses up almost all of the CPU.  And they're not doing 
anything.

Even without that I'm all for cleaner kernels, hopefully with pretty well 
documented reasons behind changes or clear reasons.  RH is trying to be 
everything, which is fine for them and their intended audience.  I've never 
really been happy with their kernels, nor with their base os.  Many are 
though.

Why can't a community do this though?  I guess the answer is there's no 
reason a community cant, jsut the mainline developers are not going to, 
because it's too much work.

> In my book 'stable' means 'doesn't crash' and 'doesn't break userspace
> without long advance notice', it doesn't mean 'does not evolve/goes
> stale'.
> And in my oppinion the current 2.6 tree succeeds in being a stable kernel.

I think stable should also include bugfixes and updates without having to 
take (potentially, if not certainly) incompatible changes along with that. 
Which yes, is closer to many distro's models.

>
> Besides, I don't agree with your view that we break userspace all the
> time as you seem to be saying in several of your mails, quite the
> opposite - a lot of work goes into *not* breaking userspace.
> Just take a look at how syscalls are maintained, even old obsolete
> ones stay in place since removing them would break userspace. Stuff in
> /proc does not get changed since that would potentially break
> userspace. Look at the fact that you can still run ancient a.out
> binaries on a recent 2.6.x kernel.
> Even internal kernel APIs usually stay around with __deprecated or as
> wrappers around new APIs for extensive periods of time.
> And when stuff is removed it's announced for ages in advance. That
> devfs would be removed was announced several *years* before it
> actually happened. That old OSS drivers will be removed (but only for
> hardware that has ALSA equivalents) has been announced months ago and
> the removal won't happen for several months (at least) yet.
>
> I'd say the kernel tries damn hard at maintaining backwards
> compatibility for userspace.
> It tries less hard, but still makes a pretty good effort, for internal
> APIs, but the real solution to the internal API churn is to get your
> code merged as it'll then get updated automagically whenever something
> changes - people who remove or change internals try very hard to also
> update all (in-tree) users of the old stuff - take a look at when I
> removed a small thing like verify_area() if you want an example.

The only argument I have is one that won't fly at all here on LKML and 
that's about all the corporate sponsors the LK has that are also doing 
custom closed source modules that are only useful for their particular 
hardware.  I'm working with more than one such company now, if they want to 
step forward and name themselves they can, but I can't name them.  Without 
these companies paying various salaries and developing using Linux and 
pushing bugfixes back/etc on the open source portions of their products it 
would be a different landscape.

>> It's horrificly expensive to maintain large numbers of machines (even if
>> it's automated) as it is.  If you're doing embedded development too or
>> instead, it gets even harder when you need certain bugfixes or minor
>> changes, but end up having to redevelop things or start maintaining your
>> own kernel fork.
>>
> The solution here is to get your code merged in mainline.

Most of it can't.  Or simply won't be accepted.  Noone else has use for a 
PPC where the GPIO is driving a custom data acquisition FPGA, or things of 
that nature.  Some of it is the same old problem of proprietary firmware 
and IP.  Some of it isn't.  Most of it is just simply useless to everyone 
but the device's manufacturer, and thus wouldn't be maintained anyway, much 
less accepted.  I guess for those cases that it *might* be accepted and can 
be exported I'll have to decide where the tradeoff occurs between answering 
external questions about hardware that doesn't exist outside of these 
devices and apps.

There again, this is still just one part of the problem as a whole 
discussed in this thread.





