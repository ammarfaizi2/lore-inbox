Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269850AbRHIQJa>; Thu, 9 Aug 2001 12:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269851AbRHIQJU>; Thu, 9 Aug 2001 12:09:20 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:51205
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S269850AbRHIQJP>; Thu, 9 Aug 2001 12:09:15 -0400
Date: Thu, 09 Aug 2001 12:09:11 -0400
From: Chris Mason <mason@suse.com>
To: marc heckmann <heckmann@hbesoftware.com>, linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: Re: 2.4.8-pre7: still buffer cache problems
Message-ID: <382140000.997373351@tiny>
In-Reply-To: <32774.213.7.60.90.997365391.squirrel@webmail.hbesoftware.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, August 09, 2001 09:56:31 AM -0400 marc heckmann
<heckmann@hbesoftware.com> wrote:

> Hi.
> 
> While 2.4.8-pre7 definitely fixes the "dd if=/dev/zero of=bigfile bs=1000k
> count=bignumber" case. The "dd if=/dev/hda of=/dev/null" is still quite
> broken for me. while I appreciate that it is a case of "root" doing
> something stupid, it shouldn't mess up the system so badly. On 2.2.19 the
> system is completely useable. on 2.4.8-pre7 it's thrashing swap like mad
> and the buffercache is huge. this is all on a PPC [G3] w/ 192Mb's of RAM
> and 200MB's of swap. so no highmem is involved. vmstat outputs:
>

Hmmm, perhaps its because the buffer cache doesn't have any use-once or
drop behind optimizations?

What happens when you do this instead (assuming your dd supports large
files, otherwise use 1000 instead of 9000)

dd if=/dev/zero of=some_file seek=9000 bs=1MB count=1

Then, run your test again:

dd if=some_file of=/dev/null

-chris

