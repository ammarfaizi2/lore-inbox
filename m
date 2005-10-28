Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbVJ1QKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbVJ1QKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbVJ1QKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:10:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50849 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030371AbVJ1QKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:10:21 -0400
To: "Alejandro Bonilla" <abonilla@linuxwireless.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	<20051027204923.M89071@linuxwireless.org>
	<1130446667.5416.14.camel@blade>
	<20051027205921.M81949@linuxwireless.org>
	<1130447261.5416.20.camel@blade>
	<20051027211203.M33358@linuxwireless.org>
	<m1mzktbqxt.fsf@ebiederm.dsl.xmission.com>
	<20051028154109.M9269@linuxwireless.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 28 Oct 2005 10:09:59 -0600
In-Reply-To: <20051028154109.M9269@linuxwireless.org> (Alejandro Bonilla's
 message of "Fri, 28 Oct 2005 11:45:54 -0400")
Message-ID: <m1ek65bp2g.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alejandro Bonilla" <abonilla@linuxwireless.org> writes:

> On Fri, 28 Oct 2005 09:29:34 -0600, Eric W. Biederman wrote
>> "Alejandro Bonilla" <abonilla@linuxwireless.org> writes:
>> 
>> >> so there is no way to give me back the "lost" memory. Is it possible
>> >> that another motherboard might help?
>> >
>> > AFAIK, No. AMD and Intel will always do the same thing until we all move to
>> > real IA64.
>> 
>> IA64 inherits this part of the architecture from x86, so no magic 
>> fix. This is a fundamentally a chipset limitation, not an 
>> architectural bug.
>
> Probably, but if they add a function to support this, then is a Fix, else it
> would have been there all the time.

It is an optimization.  Most chipsets have a hole from XXX-4GB where
you can't put memory.  In most configurations the hole is only a couple
of megabytes.  Although with PCI-E I think it is now typically about 512M
because of the memory mapped PCI-E config space.

If you put in more that 4G the memory usually shows up at 4G and keeps going.

With memory hoisting that many recent chipsets implement you can see the
memory that would normally be covered by the mmio hole someplace about
4G, so you don't loose any memory in that situation.

Now that I think about it that explains why memory was missing on the
system with PCI-E the memory mapped PCI-E config space was out there
covering it up.

>> rev-E amd64 cpus from AMD all have memory hoisting support,
>> as do all server chipsets from Intel for the last several years.
>
> Not according to the link I provided since we started the conversation. But
> they have done tweaks to start "supporting" all this memory.

I have been writing BIOS's for the last 5 years, on Intel and on AMD boards.
I know exactly what the situation is for the boards and chipsets I
have been dealing with.  I actually find it mildly surprising that
desktop boards don't handle this yet.

>> To avoid this you just need a good chipset and a good BIOS implementation.
>> Any recent server board should be fine.  Hopefully the desktop boards
>> will catch up soon.
>
> I doubt it, Intel is slowly moving to 64bit so applications and OS can catch
> up in the future to leave 32bit behind. (Probably)

???
What has this to do with 32bit and 64bit.  x86_64 (aka amd64+em64t) is
the 64bit desktop architecture, and that is what I am talking about.

Basically everything is 64bit now, the only question is how well does
the chipset and BIOS support your memory configuration.

Eric


