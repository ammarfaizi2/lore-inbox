Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWDBLRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWDBLRA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 07:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWDBLRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 07:17:00 -0400
Received: from smtpout.mac.com ([17.250.248.84]:46823 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932329AbWDBLRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 07:17:00 -0400
In-Reply-To: <20060402103223.GD13503@elf.ucw.cz>
References: <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <1143376351.3064.9.camel@laptopd505.fenrus.org> <A6491D09-3BCF-4742-A367-DCE717898446@mac.com> <20060329222640.GA2755@ucw.cz> <20060401162213.dc68d120.rdunlap@xenotime.net> <EB70C0D0-4961-4F78-B245-69C962F8B52E@mac.com> <20060402103223.GD13503@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B87D3713-61A4-4C8F-9DEB-01EE2E728787@mac.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header infrastructure
Date: Sun, 2 Apr 2006 07:16:15 -0400
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 2, 2006, at 06:32:23, Pavel Machek wrote:
>> So my question to the list is this:
>> Can you come up with any way other than using a "__kabi_" prefix  
>> to reasonably avoid namespace collisions with that large list of  
>> compilers?  If you have some way, I'd be interested to hear it,  
>> but as a number of those compilers are commercial I'd have no way  
>> to test on them (and I suspect most people on this list would not  
>> either).
>
> No, you should just not care about anything but gcc. intel-cc- 
> version-0.3.2.1.2.5 could use __kabi_struct_dirent or whatever, and  
> collide anyway. By adding __kabi you just make it less likely.

At worst it would just go from "struct dirent" to "struct  
__kabi_dirent".  One reason for this distinction as I believe was  
highlighted in another email was so that eventually if necessary libc  
could export a "struct dirent" not the same as the kernel one, and  
translate between them internally.  That would be difficult or  
impossible now, given the way the kernel exports "struct dirent"  
directly.  I don't remember the specific case where this would have  
been convenient, but I seem to recall it was mentioned in one of the  
earlier iterations of this thread.

> I believe __ is enough. If there's one conflict with some obscure  
> compiler, we can simply fix the conflict (or even fix the  
> compiler :-).
>
> If you feel __ is too dangerous, you may go __k ... It will not  
> look as ugly as __kabi_ , and should be very safe.

I still disagree with you on this point, but I'll save the arguments  
for when I have some submittable patches I'd like to get feedback  
on.  I'm also fairly positive that in comparison to the ugliness in  
some of the necessary C89-compatibility macros, the __kabi_ prefix  
would be insignificant, but let's leave that discussion for another  
time as well.

Cheers,
Kyle Moffett

In any case, for reference, here are a few of the specific arguments  
for support for other compilers:

On Mar 28, 2006, at 12:28:47, Daniel Jacobowitz wrote:
> If you want glibc to ever include these things, they had better be  
> portable C and work without GCC.  Otherwise it's a non-starter.   
> Only GCC may be used to build glibc, but it deliberately supports  
> any conforming C compiler to build userspace code.

On Mar 28, 2006, at 12:56:27, Jesper Juhl wrote:
> Other compilers do exist.
>
> Over the years I've personally used a few to compile userspace apps
> for different projects (though never for compiling the kernel).
>
> Some of the compilers I have personally used for userspace apps on  
> Linux include: gcc, icc, lcc, tcc
> Others that I know of but have never used include: sdcc, Compaq C  
> for Linux, Open Watcom, vacpp, XL C/C++
>
> and I'm sure many more exist...

