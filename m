Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271042AbRHTDJ4>; Sun, 19 Aug 2001 23:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271044AbRHTDJq>; Sun, 19 Aug 2001 23:09:46 -0400
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:62377 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S271042AbRHTDJd>; Sun, 19 Aug 2001 23:09:33 -0400
Date: Sun, 19 Aug 2001 22:09:40 -0500
From: Peter Fales <psfales@lucent.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UMSDOS problems in 2.4.9?
Message-ID: <20010819220940.A1464@lucent.com>
In-Reply-To: <20010818212401.A1814@lucent.com> <874rr3rgyv.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <874rr3rgyv.fsf@devron.myhome.or.jp>; from hirofumi@mail.parknet.co.jp on Mon, Aug 20, 2001 at 04:24:08AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes.  It works!  Thanks!  Will that change go into the official kernel??
-- 
Peter Fales			  Lucent Technologies, Room 5B-408
N9IYJ            		  2000 N Naperville Rd PO Box 3033
				  Naperville, IL 60566-7033
internet: psfales@lucent.com  	  work:	(630) 979-8031

On Mon, Aug 20, 2001 at 04:24:08AM +0900, OGAWA Hirofumi wrote:
> Hi,
> 
> Peter Fales <psfales@lucent.com> writes:
> 
> > My UMSDOS file system stopped working when I switch from 2.4.8 to 
> > 2.4.9.  I can mount the partition as "msdos" or even "vfat" but if
> > I use "umsdos" there are no files visible.  Has anyone else seen this?
> 
> Probably I think it related to change of filldir_t.
> This problem fixed with the following patch?
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
> diff -urN linux-2.4.9/fs/umsdos/dir.c umsdos_off_t-2.4.9/fs/umsdos/dir.c
> --- linux-2.4.9/fs/umsdos/dir.c	Sat Feb 10 04:29:44 2001
> +++ umsdos_off_t-2.4.9/fs/umsdos/dir.c	Sun Aug 19 16:13:25 2001
> @@ -67,7 +67,7 @@
>  static int umsdos_dir_once (	void *buf,
>  				const char *name,
>  				int len,
> -				off_t offset,
> +				loff_t offset,
>  				ino_t ino,
>  				unsigned type)
>  {
> diff -urN linux-2.4.9/fs/umsdos/ioctl.c umsdos_off_t-2.4.9/fs/umsdos/ioctl.c
> --- linux-2.4.9/fs/umsdos/ioctl.c	Thu Apr 19 03:49:13 2001
> +++ umsdos_off_t-2.4.9/fs/umsdos/ioctl.c	Sun Aug 19 16:16:36 2001
> @@ -28,7 +28,7 @@
>  				     void *buf,
>  				     const char *name,
>  				     int name_len,
> -				     off_t offset,
> +				     loff_t offset,
>  				     ino_t ino,
>  				     unsigned type)
>  {
> diff -urN linux-2.4.9/fs/umsdos/rdir.c umsdos_off_t-2.4.9/fs/umsdos/rdir.c
> --- linux-2.4.9/fs/umsdos/rdir.c	Sat Feb 10 04:29:44 2001
> +++ umsdos_off_t-2.4.9/fs/umsdos/rdir.c	Sun Aug 19 16:16:34 2001
> @@ -32,7 +32,7 @@
>  static int rdir_filldir (	void *buf,
>  				const char *name,
>  				int name_len,
> -				off_t offset,
> +				loff_t offset,
>  				ino_t ino,
>  				unsigned int d_type)
>  {
