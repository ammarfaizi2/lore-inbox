Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288821AbSANGfT>; Mon, 14 Jan 2002 01:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288835AbSANGfL>; Mon, 14 Jan 2002 01:35:11 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:64184 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288821AbSANGfC>; Mon, 14 Jan 2002 01:35:02 -0500
Date: Sun, 13 Jan 2002 23:36:04 -0700
Message-Id: <200201140636.g0E6a4b16527@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: nahshon@actcom.co.il
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: SCSI host numbers?
In-Reply-To: <200201132041.g0DKfeg30866@lmail.actcom.co.il>
In-Reply-To: <E16LjdE-0003m4-00@the-village.bc.nu>
	<200201022335.g02NZaj10253@lmail.actcom.co.il>
	<200201060144.g061i9E09115@vindaloo.ras.ucalgary.ca>
	<200201132041.g0DKfeg30866@lmail.actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itai Nahshon writes:
> On Sunday 06 January 2002 03:44 am, Richard Gooch wrote:
> > Where exactly is the host_id for an unregistered host being
> > remembered?
> 
> Sorry for the late reply. I was away from Email for the whole week.
> 
> Scsi host numbers (for both regstered and unregistered hosts)
> are preserved in scsi_host_no_list.
> 
> The list is used in the function scsi_register (in drivers/scsi/hosts.c).
> Same function also adds new hosts to the list.
> 
> The list can be initialized (from boot parameters ?) by 
> the function scsi_host_no_init (drivers/scsi/scsi.c).

Ah, yes. That was a patch someone sent to me years ago, and got
included in the jumbo devfs patch. There's a boot parameter which
allows you to control the allocation of host numbers.

So how about in scsi_host_no_init() we call alloc_unique_number() N
times until we've allocated the required number of host numbers for
manual control. These will never be freed. Then all other host
allocations can be done dynamically. We would just need a flag in the
host structure to disable deallocation of the number if it's one of
the reserved numbers.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
