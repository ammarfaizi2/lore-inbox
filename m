Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUAaCT0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 21:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUAaCT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 21:19:26 -0500
Received: from hera.kernel.org ([63.209.29.2]:11663 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263679AbUAaCTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 21:19:25 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PATCH to access old-style FAT fs
Date: Sat, 31 Jan 2004 02:19:16 +0000 (UTC)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <bvf3b3$6pr$2@terminus.zytor.com>
References: <20040126173949.GA788@frodo.local> <20040128202443.GA9246@frodo.local> <87bron7ppd.fsf@devron.myhome.or.jp> <20040129105624.GA1072@frodo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1075515556 6971 66.80.2.163 (31 Jan 2004 02:19:16 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 31 Jan 2004 02:19:16 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: hpa@smyrno.(none) (H. Peter Anvin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040129105624.GA1072@frodo.local>
By author:    Frodo Looijaard <frodol@dds.nl>
In newsgroup: linux.dev.kernel
> 
> I have run a small test in MS-DOS 5.00:
> 
>   1) Create a new directory
>   2) Create five files in it
>   3) Change the first character of the second filename to 0x00 with an editor
>   4) Do a DIR listing: only one file is seen
>      Linux shows four files!
>   5) Create a new file
>   6) Do a DIR listing: there are five files
> 
> So MS-DOS 5.00 at least does stop when a 0x00 marker is found, but does
> not write new 0x00 markers when a 0x00 marker is overwritten. 
> 

This is of course dangerous, since it could create conflicts.

Thus, I suggest we do write new 0x00 markers; even though it's not
required (it only matters if the filesystem is out of spec and
therefore by definition corrupt), it would help the Psion, and
wouldn't cause any problems for in-spec filesystems.

	-hpa
