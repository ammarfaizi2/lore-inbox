Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUFDJL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUFDJL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUFDJL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:11:27 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:17057 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S264238AbUFDJLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:11:21 -0400
Date: Fri, 4 Jun 2004 12:11:08 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Bill Davidsen <davidsen@tmr.com>
cc: Con Kolivas <kernel@kolivas.org>, FabF <fabian.frederick@skynet.be>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
In-Reply-To: <40BF3250.9040901@tmr.com>
Message-ID: <Pine.LNX.4.60.0406041201230.25783@hosting.rdsbv.ro>
References: <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net>
 <1086154721.2275.2.camel@localhost.localdomain> <200406022142.52854.kernel@kolivas.org>
 <40BF3250.9040901@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> But swap behaviour kills performance even when memory is more than adequate. 
> Consider building a DVD image in a 4GB system. The i/o forces all of the 
> unused programs out, in spite of the fact that an extra 100MB doesn't make a 
> measurable difference in performance. But when I click Mozilla paging most of 
> it in from disk make a big difference in performance to the user.

I think that kernel cannot know that you need some data once or more.
This is fadvise for.
With my wrapper (http://kernel.umbrella.ro) for fadvise you can do this:
NOCA_SIZE=128 NOCA_READ=1 NOCA_WRITE=1 NOCA_RA=1 \
 	noca mkisofs -R -o /tmp/1.iso /tmp/data

This means:
NOCA_SIZE: Call fadvise only after 128KiB was read/wrote.
NOCA_RA: call fadvise with POSIX_FADV_SEQUENTIAL
NOCA_READ: use fadvise(POSIX_FADV_DONTNEED) for reads (because you don't 
need anymore the source files)
NOCA_WRITE: use fadvise(POSIX_FADV_DONTNEED) for writes (because it's 
useless to cache the end of the ISO)

Do this program resolve your problem?

> The problems with small memory are different in kind, when not even the 
> programs will fit in memory at the same time, or will leave next to nothing 
> for i/o, swap is required for performance. But on a large memory system I 
> believe the gain to pain ratio is way too low with the current VM. The 
> solution at the moment is to turn off swap, which as you note has other 
> problems (can't move between zones without swap?) which in theory could 
> really hang a system.
>
> -- 
>   -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off until the
> last possible moment - but no longer"  -me
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
