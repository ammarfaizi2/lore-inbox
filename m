Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131466AbRC0SEI>; Tue, 27 Mar 2001 13:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131468AbRC0SD7>; Tue, 27 Mar 2001 13:03:59 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:56844
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S131466AbRC0SDl>; Tue, 27 Mar 2001 13:03:41 -0500
Date: Tue, 27 Mar 2001 13:02:54 -0500
From: Chris Mason <mason@suse.com>
To: Christoph Lameter <christoph@lameter.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS phenomenon with 2.4.2 ac24/ac12
Message-ID: <317470000.985716174@tiny>
In-Reply-To: <Pine.LNX.4.21.0103270948180.6964-100000@home.lameter.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, March 27, 2001 09:50:17 AM -0800 Christoph Lameter
<christoph@lameter.com> wrote:
>> 
>> Ok, notice how entry 2 and 3 are the same file name?  That is a big part
>> of your problem, and it should never happen with the normal kernel code.
>> The two lines that show up as (BROKEN) mean their hash values are
>> incorrect.
>> 
>> So, were there errors present before you ran reiserfsck -x?  Had you run
>> any version of reiserfsck (with -x or --rebuild-tree) before that?
> 
> The problems were present before I ran reiserfsck. I never ran
> --rebuild-tree

Just to make sure I understand, you had the exact same errors before
running fsck?  Same files could not be deleted?

> 
>> I'm guessing these problems were caused by reiserfsck, things caused by
>> kernel bug would tend towards much more random errors.  The solution will
>> probably be an upgrade to the latest fsck version, but I'd like to make
>> sure we've got the problem nailed down.
> 
> I think this is a problem with the reiserfs code in the kernel. I never
> ran reiserfsck before this problem surfaced. The problem arose in the
> netscape cache directory with lots of small files. Guess the tail handling
> is not that stable yet?

I wish I could blame it on the tail code ;-)  None of the bugs fixed there
would have caused this, and they should be completely unrelated.  I'll try
some tests in oom situations to try and reproduce.  It could also be caused
by hashing errors.  If you formatted with r5 hash, was the partition ever
incorrectly detected as tea hash?

> 
> How do I get rid of the /a/yy directory now?

With fsck.  I'll grab the latest today and make sure it can fix this bug.
Until then, mv /a/yy /a/yy.broken and mkdir /a/yy.

-chris

