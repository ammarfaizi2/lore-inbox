Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291908AbSBNVWN>; Thu, 14 Feb 2002 16:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291913AbSBNVWE>; Thu, 14 Feb 2002 16:22:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62480 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291908AbSBNVVz>;
	Thu, 14 Feb 2002 16:21:55 -0500
Message-ID: <3C6C2A39.38ED19B1@zip.com.au>
Date: Thu, 14 Feb 2002 13:20:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Alexander Moibenko <moibenko@fnal.gov>, linux-kernel@vger.kernel.org
Subject: Re: fsync delays for a long time.
In-Reply-To: <3C6C2342.5044B738@zip.com.au> from "Andrew Morton" at Feb 14, 2002 12:51:14 PM <E16bT7y-00017B-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > fsync on a very large file is very slow on the 2.2 kernels
> >
> > This could very well be due to request allocation starvation.
> > fsync is sleeping in __get_request_wait() while bonnie keeps
> > on stealing all the requests.
> 
> That may amplify it but in the 2.2 case fsync on any sensible sized file
> is already horribly performing. It hits databases like solid quite badly

I'm surprised.  ext2's fsync in 2.2 is in fact quite optimal: a single
pass across the block tree, in probable-LBA-order.  No livelock potential
there.  Optimal.  Note that it implements "only sync the stuff which was
dirty on entry" semantics.

But msync() is a different kettle of fish.  It calls file_fsync(), which
syncs the entire device, livelockably.  Are you sure `solid' is not
using msync?

-
