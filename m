Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSFDDk4>; Mon, 3 Jun 2002 23:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSFDDkz>; Mon, 3 Jun 2002 23:40:55 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53512
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S316199AbSFDDkz>; Mon, 3 Jun 2002 23:40:55 -0400
Date: Mon, 3 Jun 2002 20:40:50 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Philippe De Muyter <phdm@macqel.be>
Cc: urban@teststation.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: smbfs and >2Gb files
Message-ID: <20020604034050.GB448@matchmail.com>
Mail-Followup-To: Philippe De Muyter <phdm@macqel.be>,
	urban@teststation.com, linux-kernel@vger.kernel.org
In-Reply-To: <200206031318.g53DIpS08552@mail.macqel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 03:18:51PM +0200, Philippe De Muyter wrote:
> Hello,
> 
> One of my workmates created a >2Gb file on a MS-Windows server. That works
> perfectly.  He exported the partition and looked at it from another
> MS-Windows machine, where he can see the right size.  But when we look
> at the file from a linux machine, the reported size is plain wrong (it
> is actually the real size on 32-bit, extended to 64 bit as a signed 32 bit
> value, thus prefixed with 0xffffffff, and then printed as an unsigned 64 bit
> value.).  Not only does `ls -l' not work, but other accesses to the file are
> also impossible.
> 
> Here is a fix (tested on 2.2.16 and 2.4.18) :
> 
> --- include/linux/smb.hbk	Fri May 31 16:43:54 2002
> +++ include/linux/smb.h	Fri May 31 17:55:49 2002
> @@ -85,7 +85,7 @@
>  	uid_t		f_uid;
>  	gid_t		f_gid;
>  	kdev_t		f_rdev;
> -	off_t		f_size;
> +	size_t		f_size;
>  	time_t		f_atime;
>  	time_t		f_mtime;
>  	time_t		f_ctime;
> 
> Is it possible to incorporate that in the official linux kernel tree ?
> 

You should ask Urban (CCed).  He's the one that made the patch for 2.5, and
ye'll probably have something for 2.4 and maybe 2.2.
