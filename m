Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314330AbSEHOCc>; Wed, 8 May 2002 10:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314339AbSEHOCb>; Wed, 8 May 2002 10:02:31 -0400
Received: from eispost12.serverdienst.de ([212.168.16.111]:524 "EHLO imail")
	by vger.kernel.org with ESMTP id <S314330AbSEHOC1>;
	Wed, 8 May 2002 10:02:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
To: Dan Chen <crimsun@email.unc.edu>
Subject: Re: 48 bit ATA support in Linux 2.4
Date: Wed, 8 May 2002 16:02:11 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200205071726724.SM00162@there> <20020507163230.GF32518@opeth.ath.cx>
Cc: linux-kernel@vger.kernel.org, Steve Lord <lord@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205081607249.SM00162@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 7. May 2002 18:32, Dan Chen wrote:
> On Tue, May 07, 2002 at 05:21:55PM +0200, Robert Szentmihalyi wrote:
> > can you tell me please when your patch to support the 160 GB
> > Matrox HDs got into the 2.4 tree (which version)? It was
> > 2.4.14, right?
>
> It will be available in 2.4.19 final (was merged early in the
> 19-pres).
>
> [snip]
>
> > Also, could you please send me a copy of the patch?
> > Google didn't find it...
>
> See http://linuxdiskcert.org
>
> > I have a machine running 2.4.10-pre2-xfs with XFS support.
> > Would the patch apply cleanly or will I have to update the
> > kernel in order to support the drive?
>
> If you're handy w/ diff and patch, you can look at *.rej after
> patching and manually apply the diffs.
>
> The easiest route is probably to upgrade to a newer kernel (say,
> 2.4.18), and deal w/ the fewer rejects there since you'll also be
> applying a diff for XFS.

I have applied Andre's patch from http://linuxdiskcert.org on top of 
linux-2.4.19-pre7. Then I applied the XFS patches for 2.4.18
(unfortunately, the XFS-enabled kernel from the SGI-CVS is at 2.4.18
also, so it doesn't contain Ande's patch).

There is one reject in include/linux/sysctl.h I don't know how to fix:

***************
*** 140,145 ****
  	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
  	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
  	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
         VM_MIN_READAHEAD=12,    /* Min file readahead */
         VM_MAX_READAHEAD=13     /* Max file readahead */
  };
--- 140,148 ----
  	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
  	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
  	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
+ #if defined(CONFIG_XFS_FS) || defined(CONFIG_XFS_FS_MODULE)
+ 	VM_PAGEBUF=11,		/* struct: Control pagebuf parameters */
+ #endif
         VM_MIN_READAHEAD=12,    /* Min file readahead */
         VM_MAX_READAHEAD=13     /* Max file readahead */
  };

Can anybody who knows the XFS code please tell what the alias VM_PAGEBUF
in this enumeration is used for and how I could fix this?

The original 2.4.49-pre7 code seems to define another alias for 11 in this enum:
 
/* CTL_VM names: */
enum
{
	VM_SWAPCTL=1,		/* struct: Set vm swapping control */
	VM_SWAPOUT=2,		/* int: Linear or sqrt() swapout for hogs */
	VM_FREEPG=3,		/* struct: Set free page thresholds */
	VM_BDFLUSH=4,		/* struct: Control buffer cache flushing */
	VM_OVERCOMMIT_MEMORY=5,	/* Turn off the virtual memory safety limit */
	VM_BUFFERMEM=6,		/* struct: Set buffer memory thresholds */
	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
	VM_MAX_MAP_COUNT=11,	/* int: Maximum number of active map areas */
	VM_MIN_READAHEAD=12,    /* Min file readahead */
	VM_MAX_READAHEAD=13,    /* Max file readahead */
};

Any hints?

Thanks for your help,
 Robert

>
> Alternately, -aa has XFS in his branch, but Andre's patches will
> clash. You'll need to rip out Jens's highmem-i/o patches from -aa
> if you want Andre's patch to apply cleanly on top of
> 2.4.X-pre-aaY. (They can still be applied manually, however.)

-- 
Where do you want to be tomorrow?

Entracom. Building Linux systems.
http://www.entracom.de
