Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWEVUK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWEVUK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 16:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWEVUK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 16:10:29 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:27339 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751076AbWEVUK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 16:10:29 -0400
Message-ID: <44721994.9000402@comcast.net>
Date: Mon, 22 May 2006 16:05:40 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
References: <20060522010606.GC25434@elf.ucw.cz> <44712605.4000001@comcast.net> <20060522083352.GA11923@elf.ucw.cz> <4471E77F.1010704@comcast.net> <20060522170036.GD1893@elf.ucw.cz> <4471FAD0.9060403@comcast.net> <20060522184003.GD2979@elf.ucw.cz> <44720ACB.7040808@comcast.net> <20060522191230.GE2979@elf.ucw.cz> <447210B3.10401@comcast.net> <20060522194108.GF2979@elf.ucw.cz>
In-Reply-To: <20060522194108.GF2979@elf.ucw.cz>
X-Enigmail-Version: 0.94.0.0
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Pavel Machek wrote:
> Hi!
> 
>>>>> Good. So fix emacs/oracle/pine, and year or so and some time after it
>>>>> is fixed, we can change kernel defaults. That's still less bad than
>>>>> having
>>>>>
>>>>> [ ] Break emacs
>>>>>
>>>>> in kernel config.
>>>> Nobody is going to fix emacs/oracle/pine, they don't have to.  Nothing
>>>> is making them.  The kernel will wait for them so who cares.
>>> No, _you_ have to fix emacs/oracle/pine. You claimed your patch is
>>> interesting for secure distros, so you obviously have manpower for
>>> that, right?
>> RHAT probably fixed Emacs already since it broke on them.  Adamantix and
>> Hardened Gentoo are most likely to put manpower into things like pine..
>> they put a lot of work into removing textrels on i386.
>>
>> Oracle we can't do anything about.  It's commercial.  If we break it,
>> they will recommend running it on Solaris or Windows 2003.
> 
> Well, if RedHat ships randomization, it will make Oracle fix it quite
> quickly :-).

RHAT ships the same mmap() and stack randomization mainline does; plus
heap randomization.  paxtest claims RHAT does something like 1 or 2 more
bits of mmap() randomization than mainline does on i386 as of FC5; but
that regression test in paxtest is a bit flakey.  It nails the stack
randomization dead on.

I think if RHAT did break Oracle, Oracle would just ship with
PT_GNU_STACK, which enables an executable stack (!) and disables stack
and mmap() randomization (!!).  Who would notice anyway?  Maybe auditors
looking at every flag set on every binary on the system.

Now, if RHAT had to write SELinux policy, and upped randomization to
better protect Apache, but had to explicitly keep it low for Oracle,
that would be very transparent to the RHAT developers and to policy
auditors.  Would anyone notice?  Probably not.

If RHAT FORCED Oracle to use higher randomization, it would break.
Oracle Inc. would then recommend against using RHAT, instead advising
the use of Solaris or Win2k3.  Why?  It's easier to advise migration
than fix code, especially when you can point out exactly what the
platform you broke on changed and prove that it's not really your fault.

> 
>>> As you may have noticed, I'm at receiving end of those bug
>>> reports. And what you propose is actually *worse* than IDE, because at
>>> least you get relatively clear error message when misconfiguring IDE.
>> Yes but when you misconfigure IDE the system doesn't boot.  When you
>> turn up randomization too high, everything works but 1 or 2
>> programs.
> 
> Yes, you'll very quickly realize you misconfigured IDE... while stack
> randomization is going to break 2 apps and you'll not know why.

It's a command line option.  It happens as soon as you change menu.lst
or lilo.conf or screw with the command line at boot time.  Do you want
me to write some kind of Documentation/address-randomization.txt
explaining it?

Remember in the future I want to buff out the command line option (two
short functions, just delete them outright along with the __setup()
below them) for SELinux policy controls.  The impacts and possible
problems could be documented right in the SELinux policy controls.

At the very least a user has to do some digging to find out these are
there; then he has to determine what they do and figure out if this is a
good thing.  Writing right in the documents, "Turning entropy up too
high may cause certain programs to segfault," will place the more timid
users in a "Let's not touch this" state most of the time; if it doesn't,
they're the ones that break something we warned them would break and
then ask us about it anyway.

> 
>>> For x86-64... why not?
>> On x86-64 he may, if you can convince him it's useful (asserting that
> 
> I do not care much about randomization, sorry. I see it may be useful
> on x86-64, but I do not think configurability helps. Sorry.
> 								Pavel

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRHIZkws1xW0HCTEFAQL2wQ//cskwzR3MsjHB+roSCnrTX+aisLqSu4Cp
c5LzEz3blmD3ETszWXdVLQLu8UBH/U6FXv7mR63ugxcRTnfEHrR3/qRWgTlCRRnE
AT+qJvud9hAWaToIUHRn5MX9uLHc/iXGkR5XCeadNK+liR9EQZP2R0V52HjUoag7
2JfL1+4xRQ7A7gRDLzR6P7JgQq2rZ0fUWtSoxsnZtBE8ZSbkSjobBUxDhTHW1x5z
1c4ChuGV4LJgbGdL8RNgpC1fjrkhGrhH6avTLV49rsvweAf5+ABKsIrHXo1eT3FO
aO5R8F8RigHjdNhWtvia6ehAo0IL836x3duxSPOqUawxGUa9RycyC6URAwePDJK4
kQ8xJ/fWs6DmSEEnijPnN+qfObX7sjA3U1fXy74DN3DnS+8SvM3I/N8Ay3sUvVBh
IGKl8hBfa2WNex+KEWWNdu608z7gyRiMnIOq433B2YezHpT3PhtsBdL83zcZ8IqG
VTPo/rA5aCxgzD0jaSqBWq1skaVxyk3RsOd/ddPpDIbZ5FPaSYRD2NzkRHTasTMv
08gv/pjNxPHQb6YSszjX+yCrr1eiAkBDtSO5egCC47LGWKyPv2Cw8+2j47B34BVQ
5X6GhBHlm1Tm+wV0eYhpaw1+8ZJEKLdEM8llrUiTfYtrsvuIyu8+aVUyteF8nwCl
N3iYliYUDNw=
=zNfh
-----END PGP SIGNATURE-----
