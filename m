Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285226AbSAUMPG>; Mon, 21 Jan 2002 07:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285273AbSAUMO4>; Mon, 21 Jan 2002 07:14:56 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:8453 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S285226AbSAUMOh>;
	Mon, 21 Jan 2002 07:14:37 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15436.4720.895209.146124@laputa.namesys.com>
Date: Mon, 21 Jan 2002 16:06:56 +0300
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: ls command is slow..... (reiserfs, VM)?
In-Reply-To: <200201191630.RAA14567@cave.bitwizard.nl>
In-Reply-To: <200201191630.RAA14567@cave.bitwizard.nl>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff writes:
 > 
 > Hi,
 > 
 > the "ls" command is horribly slow on my system....
 > 
 > I'm doing some stuff with large files. From the old days when files
 > couldn't be larger than 2G, I'm manipulating 1G files.
 > 
 > There is currently a program runnning that will make a file sparse if
 > it finds only zeroes in a block. It's reading between 20 and 30Mb per
 > second off the disks, and currently finding only zeros, so there is no
 > writing going on.

Reiserfs puts on-disk inode (stat-data) near file "body" which is an
array of pointers to actual blocks of the file. This optimizes the case
of short files, because inode and file "body" can be read in one io. But
when there are many large files in the same directory, this results in
inodes of the files from the same directory being far from each other on
the disk, making readdir() or sequential stat() slower. Reiser4 uses
(will use, that is) different allocation policy that tries to address
this.

 > 
 > Linux version 2.4.16 (root@cave) (gcc version egcs-2.91.66
 >   19990314/Linux (egcs-1.1.2 release)) #15 Fri Jan 18 13:00:57 MET 2002
 > 
 > There are 4 maxtor 160G IDE disks raided to something that looks more
 > like 600G....
 > 
 > # df .
 > Filesystem            Size  Used Avail Use% Mounted on
 > /dev/md0              603G  133G  470G  23% /recover5
 > 
 > The format is "reiserfs". 
 > 
 > Is this an odd situation for "VM", Is this related to the reiserfs?
 > The raid?
 > 
 >  From the strace below, you can see that most of the time is spent in
 > simple "stat" calls.
 > 
 > Before the trace below, I did the same "ls" which could have cached
 > all info some 10 seconds before. If I repeat the command, within a few
 > seconds, things are fast.
 > 
 > I can live with the current situation. I'm reporting this as a
 > data-point, so that Linux can become better. If someone wants me to do
 > some quick tests, 
 > 
 > 
 > 				Roger. 
 > 

Nikita.

