Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289487AbSBNCd5>; Wed, 13 Feb 2002 21:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289556AbSBNCds>; Wed, 13 Feb 2002 21:33:48 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:64486 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S289487AbSBNCdf>; Wed, 13 Feb 2002 21:33:35 -0500
Message-ID: <3C6B20FD.1070601@drugphish.ch>
Date: Thu, 14 Feb 2002 03:29:17 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Ford <david+cert@blue-labs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ver_linux script updates
In-Reply-To: <3C6ADCAA.6080600@blue-labs.org> <3C6B0DF8.10209@drugphish.ch> <3C6B144C.4020904@blue-labs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> printf can be changed, declare can be changed. Ideas for agnostic 
> functions would be appreciated.

Not in sh, you need an ugly 'awk|sed' call to do the printf with 
formatstrings. And for the declare, you just drop it. Anyway, it is 
incomplete. Or you can decide to do it in bash, and leave the nice 
printf functionality and other gadgets.

>> o the script hangs when calling loadkeys, because loadkeys without
>>   arguments waits forever. A fix is to pass "loadkeys -V" as third
>>   argument to pv(). 
> 
> 
> Not acceptable, perhaps --junkoption will suffice

Well it does, but since this stupid loadkeys writes everything to stderr 
you need to parse the output again as follows (on my machine):

loadkeys --junkoption 2>&1 | head -2 | tail -1

This is so gross you could as well do a strings on all those broken 
binaries and maintain a table of offsets where to find the version string.

>> o if you assume bash why don't you try to convert all of the code into
>>   bash (inline functions) instead of using awk and sed like the old code
>>   did? 
> 
> 
> Because I'm not a bash guru and I'm trying to keep it as simple.

Well, I could help you (not a bash guru either) but the more I think 
about this the more I think it's like the attempt of ESR to make an 
autoconfigurator. Let's see if I get this correctly:

o I read ../Documentation/Changes and read that
   "This document is designed to provide a list of the minimum levels of
    software necessary to run the 2.4 kernels, ..."
   Why the hell do I need pppd to get a running 2.4.x kernel? I also do
   not need reiserfs tools because I decided to run ext3. Well and on my
   firewall I definitely don't need any pcmcia-cs package which isn't
   even completely merged into the main kernel.
o I ask myself: What exactly does this file want to tell people. I
   might be dumb but to run a kernel you need to be able to compile it,
   link it an install it (noone asks for lilo).
o OTOH, the original author mentions that this software list should be
   checked before one even considers a bug to be a real bug an not just
   some incompatibility with a wrong user space tool.
o I ask myself: How define the set of tools then? Shouldn't we for
   example include LVM or raid tools (as actually mentioned further
   down in the same file)?
o Why is this script still in the kernel tree? It is not mentioned
   anywhere and it doesn't work reliably.

The whole concept looks pretty broken to me, but then again I'm just a 
little fart that doesn't see the big picture.

> This is one of the two big problems with this script.  'kbd' and 
> 'console-tools'  are developed in parallel.  console-tools was forked 
> from kbd when the console-tools author felt the kbd author wasn't being 
> responsive or accepting updates to the kbd package.  Both kbd and 

I see, very intelligent.

> console-tools vary significantly even within themselves as to version 
> reporting.  I would like to get a large number of responses on this one 
> to develop a more accurate reporting of both  kbd and console-tools.

Mine is further up in this email.

> Because it doesn't work as well as I want it to.  The previous writers 
> of this script wrote it based on their choice of distribution and 
> installed packages.  There has always been one or more strange outputs 
> or breakage when I run it .  All of my software is compiled from 
> original tarballs or cvs from the original author.  That means if the 

I have such a distro too, I might run your version of the script on it 
as soon as I got some sleep.

> script doesn't detect it correctly, then the script is trying to detect 
> a mutation of the original source, i.e. a package from a distribution.

What if it hangs like in my example? I suggest you switch over to perl 
or if you want I can give you my bash-exec-alarm-signal handler I once 
wrote. But it's an extreme overkill to have such a thing built-in in 
your script.

> This means that the script needs to evolve because different 
> distributions are going to have differing results.

Good luck. I agree that certain information is important to have, such as:

o  Gnu C                  2.95.3                  # gcc --version
o  Gnu make               3.77                    # make --version
o  binutils               2.9.1.0.25              # ld -v
o  util-linux             2.10o                   # fdformat --version
o  modutils               2.4.2                   # insmod -V

I fail to see why I need more information from that script. But don't 
let yourself stop by my comments.

> I strongly agree that "--version" woud make life pretty simple here, but 
> unfortunately (i.e. kbd and console-tools).

I don't know how many tools I've already patched exactly because of this 
bloody annoyance. If one wants to build a stable, reliable, reproducable 
and secure box, where information can be get with simple scripts without 
thousands of lines of code for every little funny thing a programmer out 
there thought might be better than all other existing tools.

> In a side note, if anybody has a reliable way of getting pppd to 
> -always- report the version number, please tell me.  To get it to fail, 
> put some junk in /etc/ppp/options, i.e. a not currently existing modem 
> device such as /dev/usb/acm/0.

Couldn't resist:

laphish:~ # pppd
(null): This system lacks kernel support for PPP.  This could be because
the PPP kernel module could not be loaded, or because PPP was not
included in the kernel configuration.  If PPP was included as a
module, try `/sbin/modprobe -v ppp'.  If that fails, check t
laphish:~ #

Excellent output, isn't it?

Best regards,
Roberto Nibali, ratz




