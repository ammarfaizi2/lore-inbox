Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbULRDJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbULRDJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 22:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbULRDJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 22:09:34 -0500
Received: from hera.kernel.org ([209.128.68.125]:38098 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262827AbULRDJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 22:09:24 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: 3TB disk hassles
Date: Sat, 18 Dec 2004 03:08:42 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cq06vq$1t2$1@terminus.zytor.com>
References: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com> <Pine.LNX.4.61.0412161703290.30336@yvahk01.tjqt.qr> <1103212832.21920.7.camel@localhost.localdomain> <20041218001254.GA8886@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1103339322 1955 127.0.0.1 (18 Dec 2004 03:08:42 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 18 Dec 2004 03:08:42 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20041218001254.GA8886@pclin040.win.tue.nl>
By author:    Andries Brouwer <aebr@win.tue.nl>
In newsgroup: linux.dev.kernel
> 
> Yes, indeed.
> 
> One can use a standard DOS-type partition table, and pick a new type -
> I reserved 88 for this purpose today - where type 88 indicates a
> plaintext partition table found elsewhere on the disk.
> Where is elsewhere? In the starting sector of the type 88 partition
> (that can have length 1).
> This allows one to have the initial part of the disk (at most 2 TB)
> partitioned in old-fashioned manner.
> 
> The plaintext partition table is just a table with lines
> 	<start> <size>
> that one can edit with emacs or vi.
> 
> There is magic to recognize it, namely the line
> 	"# Plaintext partition table"
> and magic to indicate the end of the table, namely "# end".
> 
> That is all. If anybody wants it I can send the trivial code.
> (Am using it now, but unfortunately I do not have 3 TB disks.)
> 

First, what's wrong with the GUID partition table format?  Let's stick
to standards as long as they work; especially for things that
potentially affect multiple operating systems.

Second, several problems with this.  Sector 0 is the boot sector, so
using it is a really bad choice.  (I'd reserve several sector for
master boot code.)  In fact, rather than having a separate partition,
why don't we just specify that a sector starting with "# Plaintext partition
table" has to start within the first 64 sectors of the disk (it's
common for DOS partition tables to have the first partition start at
offset 63.)

Third, it ought to be possible to put more information than this,
e.g. for raid detect.

	-hpa
