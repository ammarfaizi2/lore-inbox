Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281891AbRLCIvr>; Mon, 3 Dec 2001 03:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284378AbRLCItv>; Mon, 3 Dec 2001 03:49:51 -0500
Received: from smtp-abo-3.wanadoo.fr ([193.252.19.152]:1708 "EHLO
	andira.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S284761AbRLCEwL>; Sun, 2 Dec 2001 23:52:11 -0500
Message-ID: <3C0B0489.55482719@wanadoo.fr>
Date: Mon, 03 Dec 2001 05:50:17 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-debug i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Alexander Viro <viro@math.psu.edu>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <29283.1007333866@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the point is to force CONFIG_DEBUG_KERNEL CONFIG_DEBUG_SLAB ...

DEVFS_DEBUG is quite verbose when enabled by devfs=dall : dmesg shows
15kb of devfs messages with no room for anything else.


Keith Owens wrote:
> 
> On Sun, 2 Dec 2001 11:59:34 -0500 (EST),
> Alexander Viro <viro@math.psu.edu> wrote:
> >On Sun, 2 Dec 2001, Pierre Rousselet wrote:
> >
> >> Here is the final (i hope) verdict of my devfs testbox :
> >>
> >> 2.4.16 with devfsd-1.3.18/1.3.20 : OK
> >> 2.4.17-pre1         "            : Broken
> >> 2.5.1-pre1          "            : OK
> >> 2.5.1-pre2 with or without v200  : Broken
> >> 2.5.1-pre5          "            : Broken
> >
> >IOW, merge of new devfs code (2.4.17-pre1 in -STABLE, 2.5.1-pre2 in -CURRENT).
> >
> >We really need CONFIG_DEBUG_* forced if CONFIG_DEVFS_FS is set.  Otherwise
> >we'll be getting tons of bug reports due to silent memory corruption.
> >
> >Keith, is there a decent way to do that?  For 2.4.17 it would help a lot...
> 
> Against 2.4.17-pre2, untested.  Revert before 2.4.17.
> 
> Index: 17-pre2.1/fs/Config.in
> --- 17-pre2.1/fs/Config.in Tue, 13 Nov 2001 08:45:38 +1100 kaos (linux-2.4/m/b/39_Config.in 1.2.1.2.1.7 644)
> +++ 17-pre2.1(w)/fs/Config.in Mon, 03 Dec 2001 09:54:58 +1100 kaos (linux-2.4/m/b/39_Config.in 1.2.1.2.1.7 644)
> @@ -63,7 +63,10 @@ bool '/proc file system support' CONFIG_
> 
>  dep_bool '/dev file system support (EXPERIMENTAL)' CONFIG_DEVFS_FS $CONFIG_EXPERIMENTAL
>  dep_bool '  Automatically mount at boot' CONFIG_DEVFS_MOUNT $CONFIG_DEVFS_FS
> -dep_bool '  Debug devfs' CONFIG_DEVFS_DEBUG $CONFIG_DEVFS_FS
> +if [ "$CONFIG_DEVFS_FS" = "y" ] ; then \
> +   define_bool CONFIG_DEVFS_DEBUG y
> +fi
> +# dep_bool '  Debug devfs' CONFIG_DEVFS_DEBUG $CONFIG_DEVFS_FS
> 
>  # It compiles as a module for testing only.  It should not be used
>  # as a module in general.  If we make this "tristate", a bunch of people

-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
