Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268333AbUIBOJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268333AbUIBOJC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268331AbUIBOJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:09:01 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:62080 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268327AbUIBOIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:08:54 -0400
Message-Id: <200409021407.i82E70hx004899@laptop11.inf.utfsm.cl>
To: Jamie Lokier <jamie@shareable.org>
cc: Adrian Bunk <bunk@fs.tum.de>, Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4) 
In-Reply-To: Message from Jamie Lokier <jamie@shareable.org> 
   of "Wed, 01 Sep 2004 21:08:06 +0100." <20040901200806.GC31934@mail.shareable.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 02 Sep 2004 10:06:59 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> said:
> I'm going to explain why filesystem support for .tar.gz or other
> "document container"-like formats is useful.

Nobody disagrees there (I think), the disagreement is on whether the
usefullness is worth the hassle.

>                                               This does _not_ mean tar
> in the kernel (I know someone who can't read will think that if I
> don't say it isn't); it does mean hooks in the kernel for maintaining
> coherency between different views and filesystem support for cacheing.

"Coherency" and "different views" implies atomic transactions, and being
able to tell that an access to the file requieres updating random junk
about it. It requires being able to guess if it is worth updating now
(given that the file might be modified a dozen times more before the junk
being checked).

> The vision I'm going for here is:
> 
>   1. OpenOffice and similar programs store compound documents in
>      standard file formats, such as .tar.gz, compressed XML and such.

And they are doing fine AFAICS. Besides, they won't exactly jump on the
possibility of leaving behind all other OSes on which they run to become a
Linux-only format.

>      Fs support can reduce CPU time handling these sorts of files, as
>      I explain below, while still working with the standard file formats.

I don't buy this one. A tar.gz must be uncompressed and unpacked, and
whatever you could save is surely dwarfed by those costs.

>      With appropriate userspace support, programs can be written which
>      have access to the capabilities on all platforms, but reduced CPU
>      time occurs only on platforms with the fs support.

Userspace support isn't there on any of the platforms right now, if ever it
will be a strange-Linux-installation thing for quite some time to come. Not
exactly attractive for application writers.

>   2. Real-time indexing and local search engine tools.

Sure! Gimme the CPU power and disk throughput for that, pretty please. [No,
I won't tell I have better use for those right now...]

>                                                         This isn't
>      just things like local Google; it's also your MP3 player scanning
>      for titles & artists, your email program scanning for subject
>      lines to display the summary fast, your blog server caching built
>      pages, your programming environment scanning for tags, and your
>      file transfer program scanning for shared deltas to reduce bandwidth.

With no description on how this is supposed to work, this is pure science
fiction/wet dreams.

>      I won't explain how these work as it would make this mail too
>      long.  It should be clear to anyone who thinks about it why the
>      coherency mechanism is essential for real-time, and a consistent
>      interface to container internals helps with performance.

Coherency is essential, but it isn't free. Far from it. The easiest way of
getting coherency is having _one_ authoritative source. That way you don't
need coherency, and don't pay for it. Anything in this class must by force
be just hints, to be recomputed at a moment's notice. I.e., let the
application who might use it check and recompute as needed.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
