Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289511AbSAOMVL>; Tue, 15 Jan 2002 07:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289512AbSAOMVC>; Tue, 15 Jan 2002 07:21:02 -0500
Received: from zeus.kernel.org ([204.152.189.113]:38558 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289511AbSAOMUv>;
	Tue, 15 Jan 2002 07:20:51 -0500
Message-Id: <200201151219.g0FCJUD15091@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: SCSI host numbers?
Date: Tue, 15 Jan 2002 14:19:25 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E16LjdE-0003m4-00@the-village.bc.nu> <200201132041.g0DKfeg30866@lmail.actcom.co.il> <200201140636.g0E6a4b16527@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200201140636.g0E6a4b16527@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2002 08:36 am, Richard Gooch wrote:
> So how about in scsi_host_no_init() we call alloc_unique_number() N
> times until we've allocated the required number of host numbers for
> manual control. These will never be freed. Then all other host
> allocations can be done dynamically. We would just need a flag in the
> host structure to disable deallocation of the number if it's one of
> the reserved numbers.

See that dynamic hosts are also added to the list and *never* removed
from it (even when the host is unregistered). With that behaviour your
unique number functions would be an overkill because we must never
free host nubers.

I suggest these changes:
    max_scsi_host initialized in scsi_host_no_init.
    max_scsi_host never decremented.
That would fix the problem that I reported.
Than (cosmetic):
    rename next_scsi_host to count_scsi_hosts (or num_scsi_hosts)
because it actually just counts the number of registered scsi hosts.
The current name for that variable is confusing...

-- Itai

