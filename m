Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136007AbRD0LJo>; Fri, 27 Apr 2001 07:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136003AbRD0LJZ>; Fri, 27 Apr 2001 07:09:25 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:44299 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135942AbRD0LJN>; Fri, 27 Apr 2001 07:09:13 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
In-Reply-To: <3A959BFD.B18F833@netcomuk.co.uk> <20000101020213.D28@(none)>
From: Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>
Date: 08 Mar 2001 13:42:16 +0100
In-Reply-To: Pavel Machek's message of "Sat, 1 Jan 2000 02:02:13 +0000"
Message-ID: <87ofvcv3dj.fsf@mose.informatik.uni-tuebingen.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Crater Lake)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Pavel Machek <pavel@suse.cz> writes:

     > Hi!
    >> I was hoping to point out that in real life, most systems that
    >> need to access large numbers of files are already designed to
    >> do some kind of hashing, or at least to divide-and-conquer by
    >> using multi-level directory structures.

     > Yes -- because their workaround kernel slowness.

     > I had to do this kind of hashing because kernel disliked 70000
     > html files (copy of train time tables).

     > BTW try rm * with 70000 files in directory -- command line will
     > overflow.

There are filesystems that use btrees (reiserfs) or hashing (affs) for
directories.

That way you get a O(log(n)) or even O(1) access time for
files. Saddly the hashtable for affs depends on the blocksize and
linux AFAIK only allows far too small block sizes (512 byte) for affs.
It was designed for floppies, so the lack of dynamically resizing hash
tables is excused.

What also could be done is to keed directories sorted. Creating of
files would cost O(N) time but a lookup could be done in
O(log(log(n))) most of the time with reasonable name distribution.
This could be done with ext2 without breaking any compatibility. One
would need to convert (sort all directories) every time the FS was
mounted RW by an older ext2, but otherwise nothing changes.

Would you like to write support for this?

MfG
        Goswin
