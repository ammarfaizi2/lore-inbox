Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278428AbRJVJXa>; Mon, 22 Oct 2001 05:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275078AbRJVJXU>; Mon, 22 Oct 2001 05:23:20 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:17167 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278428AbRJVJXB>;
	Mon, 22 Oct 2001 05:23:01 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
In-Reply-To: Your message of "Mon, 22 Oct 2001 04:33:27 -0400."
             <Pine.GSO.4.21.0110220423230.2294-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Oct 2001 19:19:55 +1000
Message-ID: <24947.1003742395@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 04:33:27 -0400 (EDT), 
Alexander Viro <viro@math.psu.edu> wrote:
>On Mon, 22 Oct 2001, Keith Owens wrote:
>> If I can get an iron clad guarantee that binfmt_misc will never, ever
>> change again then I might consider hard coding the entries in modprobe.
>> BTW, I will need a signature in blood that says I can kill you if
>> binfmt_misc is ever changed :).
>
>Wait a second.  Who says anything about hardcoding that into modprobe?
>There is such thing as skeleton stuff for modules.conf, right?

Same thing.  The preset entries in modutils util/alias.h are added to
whatever the user has in modules.conf.  In some cases the preset
entries cannot be removed, they are cumulative so the hard coded entry
cannot be removed.

The preset entries already causes problems, why should modutils insist
on options sb io=0x220 irq=7 dma=1 dma16=5 mpu_io=0x330?

>Erm... Keith, I might be misreading the source, but... Shouldn't the
>information like "block major $FOO is in module $BAR" live in
>/lib/modules/*/* ?

Historically the mapping of device majors to module or binary format
type to module was coded into modutils, via util/alias.h.  That was a
mistake, it should have used the same technique as pci, isapnp, parport
etc., each module has a table that defines what it handles and modutils
extracts the data directly from the modules.  Developers have changed
the names of their modules and now we have hard coded module names in
modutils that do not match the names used by some kernels.  Hindsight
is wonderful!

In modutils 2.5 I will get rid of all the hard coded entries in
util/alias.h.  Instead each module will define what it supports,
including any special commands to be run when the module is loaded or
unloaded.  Much easier for everyone and far more flexible.

