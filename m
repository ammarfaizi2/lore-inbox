Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTD3TJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTD3TJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:09:43 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:42239 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262362AbTD3TJk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:09:40 -0400
Date: Wed, 30 Apr 2003 15:18:48 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Swap Compression
In-reply-to: <20030430125913.GA21016@wohnheim.fh-wedel.de>
To: =?UNKNOWN?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <200304301518480600.001EC1D7@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
References: <200304292114.h3TLEHBu003733@81-2-122-30.bradfords.org.uk>
 <200304292059150060.002E747A@smtp.comcast.net>
 <200304301248.07777.kernel@kolivas.org>
 <20030430125913.GA21016@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 4/30/2003 at 2:59 PM Jörn Engel wrote:

>On Wed, 30 April 2003 12:48:07 +1000, Con Kolivas wrote:
>> 
>> I don't think a parallel project is a bad idea either. I was just
>suggesting 
>> adding the minilzo algorithm from the linuxcompressed project as one of
>the 
>> compression algorithms available.
>
>Actually, I'd like a central compression library with a large
>assortment of algorithms. That way the really common code is shared
>between both (or more) projects is shared.
>

That's just great, heh.  It will in the future cut kernel code size and matinence
work.

>Also, yet another unused compression algorithm hurts about as bad, as
>yet another unused device driver. It just grows the kernel .tar.bz2.
>

Not to get side tracked, but there is an answer for this.....

Well then let's restructure the kernel's build system soon.  It's 15 seconds
since I read this, and already I'm working out in my head the high-level
workings of a modular build system (what it would look like).

For an example, future kernel releases could be in directories, which contain
the kernel .tar.bz2, then separate sets of drivers and such.  Simply unpacking
these drivers into your kernel source tree could place files that make would
read, i.e. the kernel build system would adapt.  For example:

linux/options/foo.lod <-- Linux Option Definition file.

This file would reference other LO's that it requires, and give configuration
options.  These options would have references to LO's that they require.
They would also reference which version ranges of themselves they are
compatible with.  Thus:

make menuconfig

<M>Foo
----<M>Foo with Bar support

<SELECT> <EXIT> <HELP> <MISSING>

Hit missing on an option, say Foo:

Dependencies for CONFIG_FOO
< >Foo
----< >Bar
----< >Baz [FAILED DEPENDS!]

Hit baz:

Dependencies for CONFIG_FOO_BAZ:

Foo with Baz support needs Baz compatible with Baz v1.32

So you get the Baz option tarball, or the tarball containing it:

linux/options/baz.lod

make menuconfig:

<M>Foo
----<M>Foo with Bar support
----<M>Foo with Baz support


Yes I know this is a hassle, but it's not like Microsoft drivers
where you spend 12 hours all over the net searching for stuff;
the main kernel source distribution tree would contain the
kernel, and the kernel.org mirrors would all have the Linux
Options.  There'd be a tarball for the "default must-have drivers"
separate from the kernel core.

It's just a suggestion for the future.

--Bluefox Icy
>Jörn
>
>-- 
>Time? What's that? Time is only worth what you do with it.
>-- Theo de Raadt
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



