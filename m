Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280933AbRKYQyR>; Sun, 25 Nov 2001 11:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280932AbRKYQx7>; Sun, 25 Nov 2001 11:53:59 -0500
Received: from web9208.mail.yahoo.com ([216.136.129.41]:3855 "HELO
	web9208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280933AbRKYQxu>; Sun, 25 Nov 2001 11:53:50 -0500
Message-ID: <20011125165349.56392.qmail@web9208.mail.yahoo.com>
Date: Sun, 25 Nov 2001 08:53:49 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: change to fs/proc/inode.c breaks ALSA drivers
To: linux-kernel@vger.kernel.org
In-Reply-To: <20011125165352.A2784@maravillo.q-linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info Mike. But can anyone answer why
inode.c was changed in the first place??

--- Mike Maravillo <mike.maravillo@q-linux.com> wrote:
> On Sat, Nov 24, 2001 at 07:24:47PM -0800, Alex Davis
> wrote:
> > 
> > Somewhere between 2.4.15pre6 and 2.4.15 final,
> fs/proc/inode.c
> > was modified. The change causes all the devices
> files that ALSA
> > creates in /proc/asound/dev to have a major and
> minor number of
> > zero. I'm sending a patch to revert the file back
> to what it
> > was in 2.4.15pre5.
> 
> This change present on alsa-driver cvs fixed the
> problem on mine,
> at least.
> 
> diff -urN --exclude=CVS
> alsa-driver-0.5.12/kernel/info.c
> alsa-driver/kernel/info.c
> --- alsa-driver-0.5.12/kernel/info.c Wed Jun 28
> 02:02:03 2000
> +++ alsa-driver/kernel/info.c Wed Nov 21 23:28:35
> 2001
> @@ -897,7 +897,9 @@
>   if (p) {
>    snd_info_device_entry_prepare(p, entry);
>  #ifdef LINUX_2_3
> -  p->proc_fops = &snd_fops;
> +  /* we should not set this - at least * on 2.4.14
> or later it causes
> +     problems! */
> +  /* p->proc_fops = &snd_fops; */
>  #else
>    p->ops = &snd_info_device_inode_operations;
>  #endif
> 
> -- 
>  .--.  Michael J. Maravillo                  
> office://+63.2.894.3592/
> ( () ) Q Linux Solutions, Inc.             
> mobile://+63.917.897.0919/
>  `--\\ A Philippine Open Source Solutions Co.  http://www.q-linux.com/

__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
