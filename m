Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266169AbRGGNus>; Sat, 7 Jul 2001 09:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266176AbRGGNui>; Sat, 7 Jul 2001 09:50:38 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:21960 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266169AbRGGNuS>;
	Sat, 7 Jul 2001 09:50:18 -0400
Message-ID: <3B471399.1D6BBED6@mandrakesoft.com>
Date: Sat, 07 Jul 2001 09:50:17 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eugene Crosser <crosser@average.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <Pine.GSO.4.21.0107070727030.24836-100000@weyl.math.psu.edu> <9i73bg$psv$1@pccross.average.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Crosser wrote:
> 
> In article <Pine.GSO.4.21.0107070727030.24836-100000@weyl.math.psu.edu>,
>         Alexander Viro <viro@math.psu.edu> writes:
> 
> >> Doesn't the approach "treat a chunk of data built into bzImage as
> >> populated ramfs" look cleaner?  No need to fiddle with tar format,
> >> no copying data from place to place.
> >
> > What the hell _is_ "populated ramfs"? The thing doesn't live in array
> > of blocks. Its directory structure consists of a bunch of dentries.
> 
> I am stupid.  But the point still stays: having an image of pre-populated
> filesystem (some other than ramfs) that you only need to load into
> RAM seems more sutable than parsing tar format.  Maybe (probably) I am
> missing something.

Yeah -- we build all this stuff dynamically.  struct file, struct inode,
etc.  You could store them on disk as they would be represented in
memory, but this would be incredibly inefficient because of all the
runtime structures unnecessary on disk, and because of all the fixups
and checks you would have to perform on the data in the images after
they magically appear in memory.

Reading a tarball is the distillation of what you describe into
efficient form :)

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
