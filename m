Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130028AbRBEXHa>; Mon, 5 Feb 2001 18:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135937AbRBEXHU>; Mon, 5 Feb 2001 18:07:20 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57863 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130028AbRBEXHF>; Mon, 5 Feb 2001 18:07:05 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
To: sct@redhat.com (Stephen C. Tweedie)
Date: Mon, 5 Feb 2001 23:06:48 +0000 (GMT)
Cc: mingo@elte.hu (Ingo Molnar), sct@redhat.com (Stephen C. Tweedie),
        lord@sgi.com (Steve Lord), linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net,
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <20010205225804.Z1167@redhat.com> from "Stephen C. Tweedie" at Feb 05, 2001 10:58:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Puih-0004Rk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> do you then tell the application _above_ raid0 if one of the
> underlying IOs succeeds and the other fails halfway through?

struct 
{
	u32 flags;	/* because everything needs flags */
	struct io_completion *completions;
	kiovec_t sglist[0];
} thingy;

now kmalloc one object of the header the sglist of the right size and the
completion list. Shove the completion list on the end of it as another
array of objects and what is the problem.

> In other words, even if we expand the kiobuf into a sg vector list,
> when it comes to merging requests in ll_rw_blk.c we still need to
> track the callbacks on each independent source kiobufs.  

But that can be two arrays

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
