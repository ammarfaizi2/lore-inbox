Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUFDUuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUFDUuv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUFDUuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:50:51 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:12038 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265996AbUFDUsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:48:37 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Valdis.Kletnieks@vt.edu
Subject: Re: keyboard problem with 2.6.6
Date: Fri, 4 Jun 2004 23:48:07 +0300
User-Agent: KMail/1.5.4
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
References: <200406041817.i54IHFgZ004530@eeyore.valparaiso.cl> <200406042233.41441.vda@port.imtp.ilyichevsk.odessa.ua> <200406041950.i54JocXW026316@turing-police.cc.vt.edu>
In-Reply-To: <200406041950.i54JocXW026316@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406042348.07011.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 June 2004 22:50, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 04 Jun 2004 22:33:41 +0300, Denis Vlasenko said:
> > Using shell scripts instead of 'standard' init etc is
> > way more configurable. As an example, my current setup
> > at home:
> >
> > My kernel params are:
>
> Yes. Those are *YOUR* config setup parameters, that happen to work with
> *your* specific configuration when everything is operational. Some
> problems:

In *any* setup, kernelspace or userspace, it's typically possible
to find some silly way to break boot sequence. Unplugging
keyboard and removing (unneded for server) videocard are my
favorites ;)

> 1) Not all the world uses initrd....

I stayed away from it too, but I always knew I'll need it sooner
or later.

> 2) I hope your /script/mount_root will Do The Right Thing if the mount
> fails because it needs an fsck, for example.  Answering those 'y' and 'n'
> prompts can be a problem if your keyboard isn't working yet..

My init scripts are (trying to) recover from any failure.
They ignore non-fatal error conditions.
I'll fix your fsck example like this: make script check
FSCK_ACTION env var for N (never do fsck), ASK (ask user
if serious trouble), and AUTO (fix automagically without
user). Set FSCK_ACTION as needed per box via kernel command line.

Fixing/tailoring init written in C is harder (more time-consuming).

Fixing/tailoring kernel bootstrap sequence is harder still.
As an example, NFS boot. How can you force your ethernet into,
say, 100 Mbit FDX _before_ kernel do DHCP thing via ip= kernel
parameter?

That's one of reasons why moving to userspace might be a good idea.

> 3) Bonus points if you can explain how to, *without* a working keyboard, 
> modify that /linuxrc on your initrd to deal with the situation where your
> keyboard setup is wrong (think "booting with borrowed keyboard because your
> usual one just suffered a carbonated caffeine overdose")...

I just did that yesterday when I needed to make USB keyboard to
work on my box, first time ever for me. I let it boot, ssh'ed in,
and built new kernel. I could modify my initrd too, but that wasn't
needed.

> There's a *BASIC* bootstrapping problem here - if you move "initialize and
> handle the keyboard" into userspace, you then *require* that a
> significantly larger chunk of userspace be operational in order to be able
> to even type at the machine.  If you're trying to recover a *broken*
> userspace, it gets a lot harder.

Bootstrapping problem exist no matter how you are bootstrapping.

When something is broken, difficulty of repairs cannot be estimated
that simple. I don't think "you are using intird -> fixing will be hard"
always holds true.

BTW, in my case, booting my box was not just hard, it was impossible.
It had broken PS2 ports. I needed to "only" enter BIOS setup and tell
it to ignore keyboard errors on boot, but I couldn't enter it
without keyboard! But I digress...
--
vda

