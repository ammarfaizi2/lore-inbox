Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129385AbQLMSA6>; Wed, 13 Dec 2000 13:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLMSAs>; Wed, 13 Dec 2000 13:00:48 -0500
Received: from [10.2.1.7] ([10.2.1.7]:11767 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S129314AbQLMSAk>; Wed, 13 Dec 2000 13:00:40 -0500
From: David Howells <dhowells@redhat.com>
To: Christoph Rohland <cr@sap.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,preliminary] cleanup shm handling 
In-Reply-To: Your message of "13 Dec 2000 18:15:02 +0100."
             <qwwn1e0i6p5.fsf@sap.com> 
Date: Wed, 13 Dec 2000 17:29:45 +0000
Message-ID: <23895.976728585@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you want to change the vma ops table you can replace the f_ops
> table with your own one. SYSV ipc uses this also to be able to catch
> unmaps.

I'd thought of that, but that means I need to concoct an f_ops table of my own
for every f_ops table I might have to override. All I want to do is provide a
single VMA ops table (or maybe two), possibly with only a few ops in.

Also, I can't actually go through do_mmap()... PE Image sections in files do
not have to be page aligned. If they are, I can call do_mmap() a number of
times (once per section), but mostly they're not (they have to be at least
512b aligned though - DOS floppy alignment, I suspect).

Plus if I change the f_ops table, then I affect normal Linuxy processes doing
mmap().

> > I'm not sure how shared sections in PE Images are handled on all
> ...
> Oh, that's too much Windows for me ;-)

*grin*

David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
