Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286170AbRLJKjY>; Mon, 10 Dec 2001 05:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284627AbRLJKi4>; Mon, 10 Dec 2001 05:38:56 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:39946 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S286216AbRLJKhw>; Mon, 10 Dec 2001 05:37:52 -0500
Date: Sun, 9 Dec 2001 23:56:22 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for idiocy in mount_root cleanups.
Message-ID: <20011209235621.C117@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0112080957530.16918-100000@athlon.transmeta.com> <Pine.GSO.4.21.0112081604060.7302-100000@binet.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0112081604060.7302-100000@binet.math.psu.edu>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	OK, for the time being we can simply go with
> 
> diff -urN C1-pre7/init/do_mounts.c C1-pre7-fix/init/do_mounts.c
> --- C1-pre7/init/do_mounts.c	Fri Dec  7 20:48:43 2001
> +++ C1-pre7-fix/init/do_mounts.c	Sat Dec  8 15:54:46 2001
> @@ -351,7 +351,8 @@
>  		mount("devfs", ".", "devfs", 0, NULL);
		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  retry:
>  	for (p = fs_names; *p; p += strlen(p)+1) {
> -		err = mount(name,"/root",p,root_mountflags,root_mount_data);
> +		int err;
> +		err = sys_mount(name,"/root",p,root_mountflags,root_mount_data);
>  		switch (err) {
>  			case 0:
>  				goto done;
> 
> Is that OK with you?

Why do you *need* to declare err, when you did not need it before?

[Calling sys_mount is indeed right way to do this. Ouch, and look 4
lines above that. Do I see "mount()" without checking error return?]

								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
