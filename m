Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268244AbTBNIZi>; Fri, 14 Feb 2003 03:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268245AbTBNIZh>; Fri, 14 Feb 2003 03:25:37 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:9744 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S268244AbTBNIZg>; Fri, 14 Feb 2003 03:25:36 -0500
Message-ID: <3E4CAA8E.DE022D1D@aitel.hist.no>
Date: Fri, 14 Feb 2003 09:36:30 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to bypass buffer caches?
References: <1045157351.21195.134.camel@urca.rutgers.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruno Diniz de Paula wrote:
> 
> Hi,
> 
> I've sent some messages about using O_DIRECT to read files, but I
> suppose that is not possible using 2.4 kernel and ext2. So I was
> wondering which other alternatives I have to bypass the buffer cache of
> the kernel.

You don't say why you need this.  I recommend that you
simply don't use a filesystem - use a partition like
/dev/hda5 without a filesystem and read/write diskblocks
to and from it.

Without a filesystem you decide what data goes in what disk block,
and of course no fs cache gets in the way.

Transfering data between a range of blocks on a partition
and a ordinary file is easy - use the dd command.

file->partition
dd if=yourfile of=/dev/hdaX bs=4096 seek=<number of first block you want
to use> 

partition->file
dd if=/dev/hdaX of=yourfile bs=4096 skip=<number of first disk block you
want copied> count=<total number of blocks>


Helge Hafting
