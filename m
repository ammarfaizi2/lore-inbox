Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262743AbSJ0XKS>; Sun, 27 Oct 2002 18:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbSJ0XKS>; Sun, 27 Oct 2002 18:10:18 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:58636 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S262743AbSJ0XKR>; Sun, 27 Oct 2002 18:10:17 -0500
Message-Id: <200210272316.g9RNGQxd011519@pincoya.inf.utfsm.cl>
To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44 
In-Reply-To: Message from Andreas Dilger <adilger@clusterfs.com> 
   of "Sun, 27 Oct 2002 14:49:13 PDT." <20021027214913.GA17533@clusterfs.com> 
Date: Sun, 27 Oct 2002 20:16:26 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> said:
> On Oct 27, 2002  13:13 +0100, Andi Kleen wrote:
> > Move time_t members in struct stat to struct timespec and allow subsecond
> > timestamps for files.  Too big to post on the list, because it edits
> > a lot of file systems and drivers in a straight forward way.
> > 
> > This is required for reliable "make" on fast computers.
> > 
> > File systems that support nsec storage are currently: XFS, JFS, NFSv3
> > (if the filesystem on the server supports it), VFAT (not quite nanosecond),
> > CIFS (unit in 100ns which is above what linux supports), SMBFS (for 
> > newer servers)
> 
> Two notes I might make about this:
> 1) It would be good if it were possible to select this with a config
>    option (I don't care which way the default goes), so that people who
>    don't need/care about the increased resolution don't need the extra
>    space in their inodes and minor extra overhead.  To make this a lot
>    easier to code, having something akin to the inode_update_time()
>    which does all of the i_[acm]time updates as appropriate.

Please don't. Do not create incompatible versions of the same filesystem
just because they were written on kernels compiled with different
configurations. Superblock flags might be OK, but what is the point then?
Better mount flags (mount with/without finegrained timestamps)?

[....]

> 3) The fields you are usurping in struct stat are actually there for the
>    Y2038 problem (when time_t wraps).  At least that's what Ted said when
>    we were looking into nsec times for ext2/3.  Granted, we may all be
>    using 64-bit systems by 2038...  I've always thought 64 bits is much
>    to large for time_t, so we could always use 20 or 30 bits for sub-second
>    times, and the remaining bits for extending time_t at the high end,
>    and mask those off for now, but that is a separate issue...

IMVHO, keeping fields in filesystems' inodes for 36 years in the future is
daydreaming. Not even the filesystems in the just 11 year old Linux have
survived unscathed... and by '38 we'll probably be by ext8 or so, under
64-bit CPUs.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
