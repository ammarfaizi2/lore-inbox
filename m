Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267080AbTAKGMM>; Sat, 11 Jan 2003 01:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbTAKGMM>; Sat, 11 Jan 2003 01:12:12 -0500
Received: from packet.digeo.com ([12.110.80.53]:60050 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267080AbTAKGML> convert rfc822-to-8bit;
	Sat, 11 Jan 2003 01:12:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux v2.5.56
Date: Fri, 10 Jan 2003 22:20:59 -0800
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20030111064727.0e494512.us15@os.inf.tu-dresden.de>
In-Reply-To: <20030111064727.0e494512.us15@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301102220.59153.akpm@digeo.com>
X-OriginalArrivalTime: 11 Jan 2003 06:20:50.0645 (UTC) FILETIME=[96587850:01C2B939]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri January 10 2003 21:47, Udo A. Steinberg wrote:
>
> On Fri, 10 Jan 2003 12:26:56 -0800 (PST) Linus Torvalds (LT) wrote:
>
> LT> Summary of changes from v2.5.55 to v2.5.56
> LT> ============================================
>
> Hello,
>
> I just got the following bug with 2.5.56 pretty much out of the blue:
>
> VFS: brelse: Trying to free free buffer
> buffer layer error at fs/buffer.c:1182
> Call Trace:
>  [<c0147105>] __brelse+0x35/0x40

Presumably one of your filesystems is using htree (indexed directories).
It's a bug - nobody has found it yet.

The modestly good news is that I have found a workload which triggers it in
ten minutes, but I have not looked into it at all.

The modestly bad news is that e2fsprogs-1.32's mke2fs enables htree by
default.  It really shouldn't be doing that - htree isn't ready yet.

Use

	dumpe2fs -h /dev/hda1 | grep dir_index

to see if htree is enabled.

Use

	tune2fs -O '^dir_index' /dev/hda1

to disable it.


There are no trmendously bad bugs in htree.  Mainly this one (which _could_
cause crashes and scribbled directories) and a small memory leak on each
unlink.


