Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270774AbRIWPYQ>; Sun, 23 Sep 2001 11:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270992AbRIWPYG>; Sun, 23 Sep 2001 11:24:06 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:40900
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S270774AbRIWPX4>; Sun, 23 Sep 2001 11:23:56 -0400
Date: Sun, 23 Sep 2001 11:24:00 -0400
From: Chris Mason <mason@suse.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Significant performace improvements on reiserfs
 systems, kupdated bugfixes
Message-ID: <1903280000.1001258640@tiny>
In-Reply-To: <20010922213218.D31000@emma1.emma.line.org>
In-Reply-To: <20010921152627.C13862@emma1.emma.line.org>
 <Pine.LNX.4.30.0109230226210.25332-100000@gamma.student.ljbc>
 <20010922213218.D31000@emma1.emma.line.org>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, September 22, 2001 09:32:18 PM +0200 Matthias Andree
<matthias.andree@stud.uni-dortmund.de> wrote:
> On Sun, 23 Sep 2001, Beau Kuiper wrote:
>
>> This code change does not affect the functionality of fsync(), only
>> kupdated. kupdated is responsible for flushing buffers that have been
>> sitting around too long to disk.

Correct, fsync is unchanged, but sync() does rely on the super dirty bit.
If the super isn't dirty, then sync doesn't try to force metadata to disk
at all.

> 
> Sorry, I didn't grok that when writing my previous mail in this thread.
> I thought kupdate was the one that writes ReiserFS transactions, but
> that's kreiserfsd, I think.

Well, kreiserfsd usually writes the log blocks, when a transaction ends on
its own (full, or too old).  If someone requests a synchronous commit
(fsync, any caller of write_super), that process writes the log blocks
themselves.  So, kupdated ends up writing log blocks too.

Plus, reiserfs uses write_super as a trigger for metadata writeback, so
kupdate writes those blocks as well.

-chris

