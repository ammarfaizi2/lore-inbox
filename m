Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265193AbRGLOYA>; Thu, 12 Jul 2001 10:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265443AbRGLOXu>; Thu, 12 Jul 2001 10:23:50 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:20238
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S265193AbRGLOXf>; Thu, 12 Jul 2001 10:23:35 -0400
Date: Thu, 12 Jul 2001 10:22:58 -0400
From: Chris Mason <mason@suse.com>
To: Andi Kleen <freitag@alancoxonachip.com>, llarsh@oracle.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <418410000.994947778@tiny>
In-Reply-To: <oup8zhue9on.fsf@pigdrop.muc.suse.de>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, July 12, 2001 12:14:16 PM +0200 Andi Kleen <freitag@alancoxonachip.com> wrote:

> Lance Larsh <llarsh@oracle.com> writes:
>> 
>> I ran lots of iozone tests which illustrated a huge difference in write
>> throughput between reiser and ext2.  Chris Mason sent me a patch which
>> improved the reiser case (removing an unnecessary commit), but it was
>> still noticeably slower than ext2.  Therefore I would recommend that
>> at this time reiser should not be used for Oracle database files.
> 
> When I read the 2.4.6 reiserfs code correctly reiserfs does not cause
> any transactions for reads/writes to allocated blocks; i.e. you're not extending
> the file, you're not filling holes and you're not updating atimes.
> My understanding is that this is normally true for Oracle, but probably
> not for iozone so it would be better if you benchmarked random writes
> to an already allocated file. 
> The 2.4 page cache is more or less direct write through in this case.
>

In general, yes.  But, atime updates trigger transactions, as
and O_SYNC/fsync writes (in 2.4.x reiserfs) always force a commit of
the current tranasction.  The two patches I just posted should fix
that...

-chris





