Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVAXXsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVAXXsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVAXXqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:46:40 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:26823 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261748AbVAXXo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:44:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Ee6M8hFoYJRVjl0IqJjG9hNw+g978EdDg/cT2Wc8d5jmMlf0df4ahD1fQW/WtFpVFxmuuCZb6nsh8OF6GERgTkpG7h+zVk7KNNrIysgJrwRuQK3h5oJ6SUCQ/1wAn+gepGKWYej78N1/XffLFQCd8UqlYUudwPtc724wG6vrzCc=
Message-ID: <5a4c581d0501241544224405b2@mail.gmail.com>
Date: Tue, 25 Jan 2005 00:44:56 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: DVD burning still have problems
Cc: Jens Axboe <axboe@suse.de>,
       Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0501241502750214ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
	 <5a4c581d050123125967a65cd7@mail.gmail.com>
	 <20050124150755.GH2707@suse.de>
	 <1106594023.6154.89.camel@localhost.localdomain>
	 <20050124204529.GA19242@suse.de>
	 <1106598811.6154.93.camel@localhost.localdomain>
	 <5a4c581d0501241502750214ff@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 00:02:54 +0100, Alessandro Suardi
<alessandro.suardi@gmail.com> wrote:
> On Mon, 24 Jan 2005 21:44:06 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Llu, 2005-01-24 at 20:45, Jens Axboe wrote:
> > > > I've got several reports like this that only happen with ACPI, and one
> > > > user whose burns report fine but are corrupted if ACPI is allowed to do
> > > > power manglement.
> > >
> > > Really weird, I cannot begin to explain that. Perhaps the two reporters
> > > in this thread can try it as well?
> >
> > I can sort of guess - the CPU frequency changes (either from ACPI or
> > perhaps also from cpuspeed if in use ?) involve the CPU disconnecting
> > from the bus and reconnecting. There is much magic involved in this and
> > there are certainly chipset and CPU errata in this area.
> 
> Well, booted into 2.6.11-rc2-bk2 (ACPI config'd out) and my
>  first growisofs session decided to die at 60% with the usual EIO :/
> 
> The fun thing is that retrying now shows growisofs calling a
>  HUGE amount of these babies...
> 
> [root@donkey tmpburn]# strace -p 2337
> ...
> ioctl(5, SG_IO, 0xbffff7d8)             = 0
> ioctl(5, SG_IO, 0xbffff7d8)             = 0
> ioctl(5, SG_IO <unfinished ...>
> Process 2337 detached
> [root@donkey tmpburn]# strace -c -p 2337
> Process 2337 attached - interrupt to quit
> Process 2337 detached
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
> 100.00    7.762805         239     32445           ioctl
> ------ ----------- ----------- --------- --------- ----------------
> 100.00    7.762805                 32445           total
> 
>  while sitting in its initial prompt:
> 
> [root@donkey tmpburn]# growisofs -Z /dev/hdc=myfile.iso
> WARNING: /dev/hdc already carries isofs!
> About to execute 'builtin_dd if=myfile.iso of=/dev/hdc obs=32k seek=0'
> Sleeping for 0 sec...
> 
> It looks like every kernel has its own :(

Now of course, after Ctrl-C'ing the growisofs session, a new
 attempt yielded this

[root@donkey tmpburn]# growisofs -Z /dev/hdc=myfile.iso
WARNING: /dev/hdc already carries isofs!
About to execute 'builtin_dd if=myfile.iso of=/dev/hdc obs=32k seek=0'
/dev/hdc: "Current Write Speed" is 2.0x1385KBps.
   1409024/4608387072 ( 0.0%) @0.0x, remaining 326:57
   1409024/4608387072 ( 0.0%) @0.0x, remaining 544:56
   1409024/4608387072 ( 0.0%) @0.0x, remaining 708:25
   1409024/4608387072 ( 0.0%) @0.0x, remaining 871:53
   1409024/4608387072 ( 0.0%) @0.0x, remaining 1089:52
:-[ WRITE@LBA=2b0h failed with SK=3h/ASC=0Ch/ACQ=00h]: Input/output error
builtin_dd: 688*2KB out @ average 0.0x1385KBps
:-( write failed: Input/output error
/dev/hdc: flushing cache
/dev/hdc: stopping de-icing
/dev/hdc: writing lead-out
[root@donkey tmpburn]# 

Then, ejecting the disc and trying again, it went through.

[root@donkey tmpburn]# growisofs -Z /dev/hdc=myfile.iso
Executing 'builtin_dd if=myfile.iso of=/dev/hdc obs=32k seek=0'
/dev/hdc: "Current Write Speed" is 2.0x1385KBps.
  13107200/4608387072 ( 0.3%) @2.4x, remaining 40:54
  24412160/4608387072 ( 0.5%) @2.4x, remaining 31:17
  35717120/4608387072 ( 0.8%) @2.4x, remaining 29:52
  47022080/4608387072 ( 1.0%) @2.4x, remaining 27:29
...
4592205824/4608387072 (99.6%) @2.4x, remaining 0:04
4603510784/4608387072 (99.9%) @2.4x, remaining 0:01
builtin_dd: 2250192*2KB out @ average 2.4x1385KBps
/dev/hdc: flushing cache
/dev/hdc: stopping de-icing
/dev/hdc: writing lead-out


Only thing I note is that after reloading, the WARNING about
 disc already carrying isofs disappeared.


I guess my next move will be borrowing a Windows CD and
 installing it on my former RedHat 9 partition, then trying
 to burn DVDs from there...

--alessandro
 
 "And every dream, every, is just a dream after all"
  
    (Heather Nova, "Paper Cup")
