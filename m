Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131135AbQKUXC0>; Tue, 21 Nov 2000 18:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131102AbQKUXCI>; Tue, 21 Nov 2000 18:02:08 -0500
Received: from 7-ZARA-X12.libre.retevision.es ([62.82.225.7]:17924 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S129708AbQKUXBy>;
	Tue, 21 Nov 2000 18:01:54 -0500
Message-ID: <3A1AD460.AC55923B@zaralinux.com>
Date: Tue, 21 Nov 2000 21:00:32 +0100
From: Jorge Nerin <comandante@zaralinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: es-ES, es, en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext2 compression: How about using the Netware principle?
In-Reply-To: <3A193A12.9B384B61@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> Hi
> 
> With some years of practice with Novell NetWare, I've been wandering why
> the (unused?) file system compression mechanism in ext2 is based on
> doing realtime compression. To make compression efficient, it can't be
> made this simple. Let's look at the type of volume (file system)
> compression introduced with Novell NetWare 4.0 around '94:
> 
> - A file is saved to disk
> - If the file isn't touched (read or written to) within <n> days
> (default 14), the file is compressed.
> - If the file isn't compressed more than <n> percent (default 20), the
> file is flagged "can't compress".
> - All file compression is done on low traffic times (default between
> 00:00 and 06:00 hours)
> - The first time a file is read or written to within the <n> days
> interval mentioned above, the file is addressed using realtime
> compression. The second time, the file is decompressed and commited to
> disk (uncompressed).
> 
> Results:
> A minimum of CPU time is wasted compressing/decompressing files.
> The average server I've been out working with have an effective
> compression of somewhere between 30 and 100 per cent.
> 
> PS: This functionality was even scheduled for Win2k, but was somewhere
> lost... I don't know where...
> 
> Questions:
> I'm really not a kernel hacker, but really...
> - The daily (or nightly) compression job can run as a cron job. This can
> be a normal user process running as root. Am I right?
> - The decompress-and-perhaps-commit-decompressed-to-disk process should
> be done by a kernel process within (or beside) the file system.
> - The M$ folks will get even more problems braging about a less useful
> product.
> 
> Please CC: to me, as I'm not on the list
> 
> Regards
> 
> Roy Sigurd Karlsbakk
> 

Well, filesystem compresion is in NT since 4.0, in fact you can compress
a file, a directory, or the whole partition, but only under NTFS. I
believe that it's [un]compressed on the fly, but I'm not sure about this
fact.

The [un]compression mechanism could be a kernel thread calling a
userspace program (gzip, bzip2, definable) doing the actual
decompresion.

Don't know, just thoughts.

-- 
Jorge Nerin
<comandante@zaralinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
