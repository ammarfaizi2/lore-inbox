Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130767AbQKZXfa>; Sun, 26 Nov 2000 18:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132969AbQKZXfU>; Sun, 26 Nov 2000 18:35:20 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:31248 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S130767AbQKZXfH>; Sun, 26 Nov 2000 18:35:07 -0500
Date: Sun, 26 Nov 2000 17:01:35 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: initdata for modules?
Message-ID: <20001126170135.A1787@vger.timpanogas.org>
In-Reply-To: <200011261530.HAA09799@baldur.yggdrasil.com> <1175.975279297@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1175.975279297@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, Nov 27, 2000 at 09:54:57AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 09:54:57AM +1100, Keith Owens wrote:
> On Sun, 26 Nov 2000 07:30:44 -0800, 
> "Adam J. Richter" <adam@yggdrasil.com> wrote:
> >	In reading include/linux/init.h, I was surprised to discover
> >that __init{,data} expands to nothing when compiling a module.
> >I was wondering if anyone is contemplating adding support for
> >__init{,data} in module loading, to reduce the memory footprints
> >of modules after they have been loaded.
> 
> It has been discussed a few times but nothing was ever done about it.
> AFAIK the savings were not seen to be that important because modules
> occupy complete pages.  __init would have to be stored in a separate
> page which was then discarded.  It would complicate insmod, rmmod,
> ksymoops and gdb.  gdb against the kernel already gets confused by
> vmlinux data that is discarded and gdb has problems with modules at the
> best of times.  Definitely 2.5 material, if at all.


One really nice addition to the modutils would be to allow module 
dependencies to be stored in the headers of modules.  i.e. NetWare
NLMs have a "module depends" field where you can list modules you
have dependencies on, and so does NT with DLL's, and the loader auto
loads these modules when you load any module.  What's troublesome
about modutils in their current form is if you don't have a 
modules.dep file, insmod isn't smart enough to read the depenency
modules from a binary header, and load them without doing a lot 
of needless checking with modprobe.  Having to depend on an external
text file for this looks tacky to customers and is error prone.

I understand that it's nice to be able to change modules around 
and have the flexibilty to do this dynamically, but since modules
that use this are complied from the kernel, and the kernel 
build always knows "who owns the APIs" there's no reason it could
or should not be done this way.  i.e.

when loading ppp and it's modules:

slhc
ppp
ppp_deflate
bsd_comp

There's no reason that ppp could not have in it's binary header the 
name "slhc" and any other modules it is dependent on so insmod 
will load all of them if someone types

insmod ppp_deflate (should trigger load of all these modules).  I 
know it's works this way if there's a modules.dep file laying 
around, but it would be nice for it to work this way without 
needing the external text file.

Jeff



> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
