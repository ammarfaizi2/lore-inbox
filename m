Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263404AbREXHxZ>; Thu, 24 May 2001 03:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263407AbREXHxP>; Thu, 24 May 2001 03:53:15 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:61872 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263404AbREXHw7>;
	Thu, 24 May 2001 03:52:59 -0400
Message-ID: <3B0CBDB3.3E062D3A@mandrakesoft.com>
Date: Thu, 24 May 2001 03:52:19 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Praveen Srinivasan <praveens@stanford.edu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, mingo@redhat.com
Subject: Re: [PATCH] md.c - null ptr fixes for 2.4.4
In-Reply-To: <200105240732.f4O7WLH23332@smtp2.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Praveen Srinivasan wrote:
> @@ -3773,7 +3774,12 @@
>                         ainfo.spare_disks = 0;
>                         ainfo.layout = 0;
>                         ainfo.chunk_size = md_setup_args.chunk[minor];
> -                       err = set_array_info(mddev, &ainfo);
> +                       if(mddev==NULL){
> +                           err=1;
> +                         }
> +                       else {
> +                         err = set_array_info(mddev, &ainfo);
> +                       }
>                         for (i = 0; !err && (dev = md_setup_args.devices[minor][i]); i++) {
>                                 dinfo.number = i;
>                                 dinfo.raid_disk = i;
> @@ -3797,9 +3803,12 @@
>                 if (!err)
>                         err = do_md_run(mddev);
>                 if (err) {
> -                       mddev->sb_dirty = 0;
> -                       do_md_stop(mddev, 0);
> -                       printk("md: starting md%d failed\n", minor);
> +                 if(mddev !=NULL){
> +                   mddev->sb_dirty = 0;
> +                   do_md_stop(mddev, 0);
> +                 }
> +
> +                 printk("md: starting md%d failed\n", minor);

coding style of changes totally different from surrounding code, and
Documentation/CodingStyle

ditto for other patches... i didn't check all, only several

-- 
Jeff Garzik      | "Are you the police?"
Building 1024    | "No, ma'am.  We're musicians."
MandrakeSoft     |
