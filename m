Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUAOOoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 09:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUAOOoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 09:44:18 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:36759 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261575AbUAOOoQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 09:44:16 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: Andy Lutomirski <luto@myrealbox.com>
Subject: Re: BUG: loop device not work in 2.6.1-mm2 an 2.6.1-mm3
Date: Thu, 15 Jan 2004 11:43:53 +0000
User-Agent: KMail/1.5.94
References: <fa.l6gqnit.t52ubp@ifi.uio.no> <40063A20.9000406@myrealbox.com>
In-Reply-To: <40063A20.9000406@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401151143.53425.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Loop work with 2.6.1, but not work with 2.6.1-mm{1,2,3}
I try apply your patch in 2.6.1-mm3

11:41:50 [root@murilo:/MRX/drivers/linux-2.6.1]#patch -p0 -i /root/download/loop-mm3.diff
patching file drivers/block/loop.c
patch: **** malformed patch at line 4:                 blk_queue_merge_bvec(lo->lo_queue, q->merge_bvec_fn);


Em Qui 15 Jan 2004 06:58, Andy Lutomirski escreveu:
> Murilo Pontes wrote:
>  > 21:44:56 [root@murilo:~]#mount -V
>  > mount: mount-2.12
>  >
>  > umount: /tmp/ramdisk_mountdir: não montado
>  > ioctl: LOOP_CLR_FD: No such device or address
>  > mount: será usado o dispositivo de laço /dev/loop/0
>  > ioctl: LOOP_SET_FD: Argumento inválido
>  >
>  >
>  > -
>  > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
>  >  in
>  > the body of a message to majordomo@vger.kernel.org
>  > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  > Please read the FAQ at  http://www.tux.org/lkml/
>
> Are you running reiserfs?  If so, this patch (from Ben Slusky) fixed it:
>
> --- drivers/block/loop.c.old	2004-01-11 13:05:05.000000000 -0500
> +++ drivers/block/loop.c	2004-01-14 07:49:24.795161024 -0500
> @@ -853,9 +853,7 @@
>   		blk_queue_merge_bvec(lo->lo_queue, q->merge_bvec_fn);
>   	}
>
> -	error = set_blocksize(bdev, lo_blocksize);
> -	if (error)
> -		goto out_putf;
> +	set_blocksize(bdev, lo_blocksize);
>
>   	kernel_thread(loop_thread, lo, CLONE_KERNEL);
>   	down(&lo->lo_sem);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
