Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130656AbQKTC1S>; Sun, 19 Nov 2000 21:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130448AbQKTC1J>; Sun, 19 Nov 2000 21:27:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:5126 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130147AbQKTC06>; Sun, 19 Nov 2000 21:26:58 -0500
Date: Mon, 20 Nov 2000 02:56:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H . J . Lu" <hjl@valinux.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek/llseek allows the negative offset
Message-ID: <20001120025625.A21625@athlon.random>
In-Reply-To: <20001117155913.A26622@valinux.com> <20001117160900.A27010@valinux.com> <20001118192542.B24555@athlon.random> <20001119014512.G26779@athlon.random> <20001118172034.A22523@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001118172034.A22523@valinux.com>; from hjl@valinux.com on Sat, Nov 18, 2000 at 05:20:34PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 05:20:34PM -0800, H . J . Lu wrote:
> --- linux/fs/proc/mem.c.lseek	Tue Jan  4 10:12:23 2000
> +++ linux/fs/proc/mem.c	Sat Nov 18 17:19:28 2000
> @@ -196,14 +196,17 @@ static long long mem_lseek(struct file *
>  {
>  	switch (orig) {
>  		case 0:
> -			file->f_pos = offset;
> -			return file->f_pos;
> +			break;
>  		case 1:
> -			file->f_pos += offset;
> -			return file->f_pos;
> +			offset += file->f_pos;
> +			break;
>  		default:
>  			return -EINVAL;
>  	}
> +	if (offset < 0)
> +			return -EINVAL;
> +	file->f_pos = offset;
> +	return offset;
>  }

This looks fine to me.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
