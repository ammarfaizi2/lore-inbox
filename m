Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUJ1LT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUJ1LT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUJ1LT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:19:26 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:33036 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262972AbUJ1LTS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:19:18 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Swap strangeness: total VIRT ~23mb for all processes, swap 91156k used - impossible?
Date: Thu, 28 Oct 2004 14:19:03 +0300
User-Agent: KMail/1.5.4
References: <200410281333.53976.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.53.0410281257340.19784@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0410281257340.19784@yvahk01.tjqt.qr>
Cc: linux-kernel@vger.kernel.org, uclibc@uclibc.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200410281419.03100.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 14:01, Jan Engelhardt wrote:
> I have removed Cc: for I don't know how useful this reply is for the others.
> 
> >I ran oom_trigger soon after boot and took
> >"top b n 1" snapshot after OOM kill.
> >
> >Output puzzles me: total virtual space taken by *all*
> >processes is ~23mb yet swap usage is ~90mb.
> 
> Well, if you allocate more and more space (and actually use it), other
> applications must be swapped out. Even in a very calm system, the RSS(RES)
> field can drop to 4 (usual value) or even 0, which means they're
> almost/completely swapped out, and swap usage is "high".
> 
> And if VIRT is so small, well then I guess, that's it. The VIRT values for the
> processes listed below all seem normal. Also, because you use µclibc and
> busybox, as you say.

I think VIRT is a total virtual space taken by process, part of
which may be swapped. VIRT can't be reduced by swapping out -
correct me if I'm wrong.

But I believe even if I'm wrong on that, I simply do not have
90 mbytes to be swapped out here!

Look again at top output - most processes are below 1mb,
many are below 50k thanks to dietlibc.

> Exception is "supervise", but I do not know that one and how much RAM it takes
> when run in a normal production environment.

It's a rather nifty utility from daemontools package.
It my case, it is built with dietlibs. Yes, it is
really takes only 20k of virtual memory when running!

# ldd supervise
        not a dynamic executable
# ls -l supervise
-rwxr-xr-x  1 root root  9668 Oct 19 06:48 supervise

More info at:

http://cr.yp.to/daemontools.html

If you don't like it's license, then look here
for alternative implementation:

http://smarden.org/runit/

> >How that can be? *What* is there? Surely it can't
> >be a filesystem cache because OOM condition reduces that
> >to nearly zero.
> >
> >top output
> >(note: some of them are busybox'ed, others are compiled
> >against uclibc, some are statically built with dietlibc,
> >rest is plain old shared binaries built against glibc):
> 
> What if you do the oom with a pure glibc?

I think I will lose "it's impossible" argument,
because all processes will be more than 1 mbyte in VIRT.

I will try nevertheless.
--
vda

