Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUJOWKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUJOWKh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUJOWKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:10:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261426AbUJOWK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:10:27 -0400
Date: Fri, 15 Oct 2004 18:08:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Greg KH <greg@kroah.com>, Lee Revell <rlrevell@joe-job.com>,
       David Woodhouse <dwmw2@infradead.org>, Josh Boyer <jdub@us.ibm.com>,
       gene.heskett@verizon.net, Linux kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <4170426E.5070108@nortelnetworks.com>
Message-ID: <Pine.LNX.4.61.0410151744220.3651@chaos.analogic.com>
References: <27277.1097702318@redhat.com> <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com>
 <1097843492.29988.6.camel@weaponx.rchland.ibm.com> <200410151153.08527.gene.heskett@verizon.net>
 <1097857049.29988.29.camel@weaponx.rchland.ibm.com>
 <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com>
 <1097860121.13633.358.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.61.0410151319460.6877@chaos.analogic.com>
 <1097873791.5119.10.camel@krustophenia.net> <20041015211809.GA27783@kroah.com>
 <4170426E.5070108@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Chris Friesen wrote:

> Greg KH wrote:
>
>> If you have a BSD licensed module, you do not have to provide the source
>> code for it.
>
> Maybe we need a "BSD with source" module string that doesn't taint?  Or is 
> that getting too ridiculous?
>
> Chris
>

Like I said, once you put policy in the kernel it can't be right:

module: module license 'Public domain' taints kernel.

And, of course, one can always do:

echo "0" >/proc/sys/kernel/tainted

... to make everything "better" after you've loaded a module
from Hell.

Any time somebody puts some "deny" hooks in readable source-code
(the kernel) somebody can either remove them or make a corresponding
countermeasure, usually in user-mode. It is entirely counter-productive
to bloat the kernel with this kind of stuff.

The moving of module load/unload code from user-mode code to the
kernel is a prime example. Time would have been better spent
removing the races in the hot-swap and module-removal code.

One can make a 'certified' kernel with 'certified' modules
for some hush-hush project. Adding this kind of junk isn't
how it's done. You just take your favorite kernel with the
modules you require, you verify that it meets your security
requirements, then you CRC the kernel and its modules. You
keep the CRCs somewhere safe, available from a read-only
source like a CD/ROM or a network file-server. You automatically
check these CRCs occasionally using a read-only program on
read-only source like the network or a CD/ROM. If the checks
fail, you call the "super" and shut down the system.

It's done all the time and it works. Putting more strings
and other junk in the kernel with all the checking-code
just tries to hide from the real elements of security.

But, it's not __really__ security everybody's after. It's
sucking up to GNU. For 15 years, before there was a GNU, I
was the SYSOP of the "Program Exchange". I know what free
software really is. And, it has nothing to do with FSF and
Richard Stallman. That's where M$ got their first version
of Flight Simulator from. The source was in Turbo Pascal
and MASM assembly. I wrote the assembly. So I know how
these things go. Been there, done that.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

