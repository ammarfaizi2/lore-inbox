Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266177AbRGDUXh>; Wed, 4 Jul 2001 16:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266176AbRGDUXR>; Wed, 4 Jul 2001 16:23:17 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:4873 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S266175AbRGDUXL>; Wed, 4 Jul 2001 16:23:11 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: O_DIRECT! or O_DIRECT?
Date: Wed, 4 Jul 2001 20:23:10 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9hvtvd$9o2$1@ncc1701.cistron.net>
In-Reply-To: <E15HWsV-0000lM-00@f12.port.ru> <20010704185230.F28793@redhat.com> <9hvn61$rkb$1@ncc1701.cistron.net> <20010704193402.A6403@redhat.com>
X-Trace: ncc1701.cistron.net 994278190 9986 195.64.65.67 (4 Jul 2001 20:23:10 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010704193402.A6403@redhat.com>,
Stephen C. Tweedie <sct@redhat.com> wrote:
>Hi,
>
>On Wed, Jul 04, 2001 at 06:27:13PM +0000, Miquel van Smoorenburg wrote:
>> 
>> Any chance of something like O_SEQUENTIAL (like madvise(MADV_SEQUENTIAL))
>
>What for?  The kernel already optimises readahead and writebehind for
>sequential files.

Yes, but I really do mean like in madvise().

>If you want to provide specific extra hints to the kernel, then things
>like O_UNCACHE might be more appropriate to instruct the kernel to
>explicitly remove the cached page after IO completes (to avoid the VM
>overhead of maintaining useless cache).  That would provide a definite
>improvement over normal IO for large multimedia-style files or for
>huge copies.  But what part of the normal handling of sequential files
>would O_SEQUENTIAL change?  Good handling of sequential files should
>be the default, not an explicitly-requested feature.

exactly what I meant, since that is what MADV_SEQUENTIAL seems to do:

linux/mm/filemap.c:

 *  MADV_SEQUENTIAL - pages in the given range will probably be accessed
 *              once, so they can be aggressively read ahead, and
 *              can be freed soon after they are accessed.

/*
 * Read-ahead and flush behind for MADV_SEQUENTIAL areas.  Since we are
 * sure this is sequential access, we don't need a flexible read-ahead
 * window size -- we can always use a large fixed size window.
 */
static void nopage_sequential_readahead(struct vm_area_struct * vma,

O_SEQUENTIAL perhaps is the wrong name.

I'd like to see this so I can run tar to backup a machine during the
day (if tar used this flag, ofcourse) without performance going
down the drain because of cache pollution.

Mike.

