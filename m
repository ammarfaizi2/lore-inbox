Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWGYSZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWGYSZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWGYSZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:25:52 -0400
Received: from [212.76.91.144] ([212.76.91.144]:56328 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750832AbWGYSZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:25:52 -0400
From: Al Boldi <a1426z@gawab.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: CFQ will be the new default IO scheduler - why?
Date: Tue, 25 Jul 2006 21:27:09 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <200607241857.43399.a1426z@gawab.com> <200607250756.49071.a1426z@gawab.com> <44C5A529.9060306@linux.intel.com>
In-Reply-To: <44C5A529.9060306@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607252127.09402.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Al Boldi wrote:
> > Arjan van de Ven wrote:
> >>>> Should there be a default scheduler per filesystem?  As some
> >>>> filesystems may perform better/worse with one over another?
> >>>
> >>> It's currently perDevice, and should probably be extended to perMount.
> >>
> >> Hi,
> >
> > Hi!
> >
> >> per mount is going to be "not funny". I assume the situation you are
> >> aiming for is the "3 partitions on a disk, each wants its own
> >> elevator". The way the kernel currently works is that IO requests the
> >> filesystem does are first flattened into an IO for the entire device
> >> (eg the partition mapping is done) and THEN the IO scheduler gets
> >> involved to schedule the IO on a per disk basis.
> >
> > IC.  That probably explains why concurrent io-procs have such a hard
> > time getting through to the disk.  They probably just hang in the
> > flatting phase, waiting for something to take care of their requests.
>
> flattening is just an addition in the cpu, that's just really boring and
> shouldn't be visible anywhere performance wise

Try this on 2.6 and 2.4 respectively:
# cat /dev/hda > /dev/null
< switch to another vt >
< login >
< start timing >
< wait for shell >
< stop timing >
< wait for dcache to be gobbled by cat and repeat login as necessary >

On my system 2.4.31 (2sec) is at least twice as fast as 2.6.17 (4-10sec) 
depending on io-scheduler, with noop/deadline performing best, albeit a lot 
of noise (scrubbing the disk), and anti/cfq performing worst, albeit quieter 
(just hanging around).

Thanks!

--
Al

