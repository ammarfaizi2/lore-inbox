Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbRFUSVg>; Thu, 21 Jun 2001 14:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265086AbRFUSV0>; Thu, 21 Jun 2001 14:21:26 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:42502
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S265085AbRFUSVR>; Thu, 21 Jun 2001 14:21:17 -0400
Date: Thu, 21 Jun 2001 14:20:45 -0400
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>
cc: Stefan.Bader@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: correction: fs/buffer.c underlocking async pages
Message-ID: <555590000.993147645@tiny>
In-Reply-To: <20010621191522.B28327@athlon.random>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, June 21, 2001 07:15:22 PM +0200 Andrea Arcangeli
<andrea@suse.de> wrote:

> On Thu, Jun 21, 2001 at 09:56:04AM -0700, Linus Torvalds wrote:
>  What's the problem with the existing code, and why do people want to add
> a
>> (unnecessary) new bit?
> 
> there's no problem with the existing code, what I understood is that
> they cannot overwrite the ->b_end_io callback in the lowlevel blkdev
> layer or the page will be unlocked too early.

Just to be more explicit, the big problem is mixing different async
callbacks on the same page.  The patch would also allow things like this:

fs_specific_end_io() {
    do something special
    end_buffer_io_async()
}

-chris


