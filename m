Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135801AbRD0LDD>; Fri, 27 Apr 2001 07:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135804AbRD0LCx>; Fri, 27 Apr 2001 07:02:53 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:18439 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S135801AbRD0LCj>; Fri, 27 Apr 2001 07:02:39 -0400
Date: Fri, 27 Apr 2001 13:02:37 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 NFSv3 client breaks fdopen(3)
Message-ID: <20010427130237.A24894@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010426192632.A18492@maggie.dt.e-technik.uni-dortmund.de> <15080.24119.524229.296133@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15080.24119.524229.296133@charged.uio.no>; from trond.myklebust@fys.uio.no on Don, Apr 26, 2001 at 19:43:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Trond Myklebust wrote:

> --- /mnt/3/linux-2.2.19/fs/nfs/dir.c	Sun Mar 25 08:37:38 2001
> +++ linux-2.2.19/fs/nfs/dir.c	Thu Apr  5 14:37:59 2001
> @@ -454,6 +454,9 @@
>   */
>  static loff_t nfs_dir_llseek(struct file *file, loff_t offset, int origin)
>  {
> +	/* Glibc 2.0 backwards compatibility crap... */
> +	if (origin == 1 && offset == 0)
> +		return file->f_pos;

This fixes my problems with cvs and my test script. Thanks a lot again!
