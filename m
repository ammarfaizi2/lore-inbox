Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVAYAEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVAYAEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVAXXWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:22:11 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:52675 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261606AbVAXXC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:02:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ErjumNq9vu+YRlAn35FIDTiLmn/q1B8sJ6mIP8tO300jK/AJSy2un3nUlMKNpHpiYBmcY9A8hTy4bocZFVlva5PzTFRtY+Ob5jNUtnUnaiv9OFdXfI8zanDAQ4ZUgRiwMj4iAm2RqvJpu3mCJFNwJ0RuwcFwM3nyVYbYzuCt18Q=
Message-ID: <5a4c581d0501241502750214ff@mail.gmail.com>
Date: Tue, 25 Jan 2005 00:02:54 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: DVD burning still have problems
Cc: Jens Axboe <axboe@suse.de>,
       Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1106598811.6154.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
	 <5a4c581d050123125967a65cd7@mail.gmail.com>
	 <20050124150755.GH2707@suse.de>
	 <1106594023.6154.89.camel@localhost.localdomain>
	 <20050124204529.GA19242@suse.de>
	 <1106598811.6154.93.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 21:44:06 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2005-01-24 at 20:45, Jens Axboe wrote:
> > > I've got several reports like this that only happen with ACPI, and one
> > > user whose burns report fine but are corrupted if ACPI is allowed to do
> > > power manglement.
> >
> > Really weird, I cannot begin to explain that. Perhaps the two reporters
> > in this thread can try it as well?
> 
> I can sort of guess - the CPU frequency changes (either from ACPI or
> perhaps also from cpuspeed if in use ?) involve the CPU disconnecting
> from the bus and reconnecting. There is much magic involved in this and
> there are certainly chipset and CPU errata in this area.

Well, booted into 2.6.11-rc2-bk2 (ACPI config'd out) and my
 first growisofs session decided to die at 60% with the usual EIO :/

The fun thing is that retrying now shows growisofs calling a
 HUGE amount of these babies...

[root@donkey tmpburn]# strace -p 2337
...
ioctl(5, SG_IO, 0xbffff7d8)             = 0
ioctl(5, SG_IO, 0xbffff7d8)             = 0
ioctl(5, SG_IO <unfinished ...>
Process 2337 detached
[root@donkey tmpburn]# strace -c -p 2337
Process 2337 attached - interrupt to quit
Process 2337 detached
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
100.00    7.762805         239     32445           ioctl
------ ----------- ----------- --------- --------- ----------------
100.00    7.762805                 32445           total

 while sitting in its initial prompt:

[root@donkey tmpburn]# growisofs -Z /dev/hdc=myfile.iso
WARNING: /dev/hdc already carries isofs!
About to execute 'builtin_dd if=myfile.iso of=/dev/hdc obs=32k seek=0'
Sleeping for 0 sec...

It looks like every kernel has its own :(

--alessandro
 
 "And every dream, every, is just a dream after all"
  
    (Heather Nova, "Paper Cup")
