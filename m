Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131155AbRAAWvy>; Mon, 1 Jan 2001 17:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131226AbRAAWvp>; Mon, 1 Jan 2001 17:51:45 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:32495 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S131155AbRAAWve>;
	Mon, 1 Jan 2001 17:51:34 -0500
Date: Mon, 1 Jan 2001 23:19:58 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>, Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts....
Message-ID: <20010101231958.A1942@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <20010101175005.B1650@suse.de> <E14D8qR-00015A-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14D8qR-00015A-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 01, 2001 at 05:34:01PM +0000
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-prerelease-fijiji2 (i686)
X-APM: 100% 200 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2001 at 05:34:01PM +0000, Alan Cox wrote:
> > for FAT etc when reading. Writing is a bit more difficult, as that
> > then turns out to generate a read before we can commit a dirty
> > block. IMO, this type of thing does not belong in the drivers --
> > we should _never_ receive request for < hard block size.
> 
> Unfortunately someone ripped the support out from 2.2 to do this, then didnt
> fix it. So right now 2.4 is useless to anyone with an M/O drive.

"ripped the support" is a bit nice for a thing that causes here
a hard freeze.

Famous last word:

Jan  1 19:34:52 xterm kernel: MSDOS: Hardware sector size is 2048

ext2 works, but it's extremely slow (compared to linear write using
dd)

"Don't do it then" is a bit hard, because I use "-t auto" on mount
and both 2048 && 512 byte medias  (yes, the girl that leaves my bed
when I enter it uses msdos on 512b/sect medias).

I don't know how hard a fix would be, I don't need it but I only want
to avoid crashes.


--- linux/fs/fat/inode.c.orig	Mon Jan  1 20:06:17 2001
+++ linux/fs/fat/inode.c	Mon Jan  1 20:06:51 2001
@@ -460,7 +460,7 @@
 	opts.isvfat = sbi->options.isvfat;
 	if (!parse_options((char *) data, &fat, &blksize, &debug, &opts, 
 			   cvf_format, cvf_options)
-	    || (blksize != 512 && blksize != 1024 && blksize != 2048))
+	    || (blksize != 512 && blksize != 1024))
 		goto out_fail;
 	/* N.B. we should parse directly into the sb structure */
 	memcpy(&(sbi->options), &opts, sizeof(struct fat_mount_options));

-- 

  ciao - 
    Stefan

"     ( cd /lib ; ln -s libBrokenLocale-2.2.so libNiedersachsen.so )     "
    
Stefan Traby                Linux/ia32               fax:  +43-3133-6107-9
Mitterlasznitzstr. 13       Linux/alpha            phone:  +43-3133-6107-2
8302 Nestelbach             Linux/sparc       http://www.hello-penguin.com
Austria                                    mailto://st.traby@opengroup.org
Europe                                   mailto://stefan@hello-penguin.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
