Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314264AbSDVQS6>; Mon, 22 Apr 2002 12:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314266AbSDVQS5>; Mon, 22 Apr 2002 12:18:57 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:62968 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S314264AbSDVQS4>; Mon, 22 Apr 2002 12:18:56 -0400
Date: Mon, 22 Apr 2002 10:17:06 -0600
From: Andreas Dilger <adilger@turbolinux.com>
To: "Ph. Marek" <marek@bmlv.gv.at>
Cc: sct@redhat.com, akpm@zip.com.au, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: [PATCH] open files in kjounald
Message-ID: <20020422161706.GC3017@turbolinux.com>
Mail-Followup-To: "Ph. Marek" <marek@bmlv.gv.at>, sct@redhat.com,
	akpm@zip.com.au, linux-kernel@vger.kernel.org,
	ext3-users@redhat.com
In-Reply-To: <3.0.6.32.20020422065639.0090cd10@pop3.bmlv.gv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 22, 2002  06:56 +0200, Ph. Marek wrote:
> On every mount of ext3 (and I suppose all journaling filesystems which use
> jbd, although I didn't test this) a new kjournald is created. All kjournald
> share the same file-information.
> 
> Before this patch it would accumulativly fetch open files from the calling
> process (normally mount); I verified this via (in bash)
> 	exec 30< /etc/services
> 	mount <partition> /mnt/tmp
> 	ps -aux | grep kjournald
> 	ls -la <pid of any kjournald>
> gives, among 0, 1 and 2
> 	30 -> /etc/services
> 
> This is really awful as you can't umount devfs (normally /dev/console is
> opened as from the start-scripts) and so / can't be umounted.
> 
> After applying this patch the open files were gone.

It looks OK to me, except that the patch is reversed.

> diff -ru linux/fs/jbd/journal.c linux.ori/fs/jbd/journal.c
> --- linux/fs/jbd/journal.c      Mon Apr 22 06:29:16 2002
> +++ linux.ori/fs/jbd/journal.c  Mon Apr 22 06:28:54 2002
> @@ -204,7 +204,6 @@
> 
>         lock_kernel();
>         daemonize();
> -       exit_files(current);
>         spin_lock_irq(&current->sigmask_lock);
>         sigfillset(&current->blocked);
>         recalc_sigpending(current);

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

