Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSHaAJY>; Fri, 30 Aug 2002 20:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSHaAJX>; Fri, 30 Aug 2002 20:09:23 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:22770 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S313190AbSHaAJX>; Fri, 30 Aug 2002 20:09:23 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020830192254.GA32468@clusterfs.com> 
References: <20020830192254.GA32468@clusterfs.com>  <180577A42806D61189D30008C7E632E8793A25@boca213a.boca.ssc.siemens.com> 
To: Andreas Dilger <adilger@clusterfs.com>
Cc: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>, linux-kernel@vger.kernel.org
Subject: Re: your mail 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Sat, 31 Aug 2002 01:12:56 +0100
Message-ID: <16211.1030752776@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



adilger@clusterfs.com said:
>  I would instead suggest using a filesystem like JFFS2 for flash
> devices. This is journaled like ext3, but it also has the benefit of
> doing wear levelling on the device, which otherwise will probably wear
> out the superblock part of the flash rather quickly. 

He said he's using CompactFlash. CompactFlash is not flash, as far as we're
concerned: it is an IDE drive. You may think it has flash inside it; we
couldn't possibly comment.

In fact, it generally has a kind of pseudo-filesystem internally which it 
uses to emulate a block device with 512-byte sectors. It may do its own 
wear-levelling; the manufacturers are often quite cagey about whether it 
actually does or not. Draw your own conclusions about that if you will.

It's quite common to find that this internal pseudo-filesystem _itself_ gets
screwed on power failures. This tends to manifest itself as unrecoverable 
I/O errors.

There is no fundamental reason why every CF card should have these 
problems, in the same way as there is no fundamental reason why all PC 
BIOSes should be crap. But the same expectations apply.

If you want to pass power-fail testing, I would recommend you switch to
using real flash. JFFS2 on real flash has survived days of stress testing
whilst being power cycled randomly every ~5 minutes. The same tests were 
observed to destroy CF cards¹.

CF is bog-roll technology. It's disposable storage designed for temporary
use in stuff like cameras -- not for real computing. Think of it like a
floppy disc and you won't go far wrong.

--
dwmw2
¹ http://www.embeddedlinuxworks.com/articles/jffs_guide.html²
² Constant reboots no longer screw the wear levelling, as reported there.

