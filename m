Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUEVM4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUEVM4n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 08:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUEVM4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 08:56:43 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50923 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261210AbUEVM4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 08:56:40 -0400
Date: Sat, 22 May 2004 14:56:33 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
Subject: Re: rfc: test whether a device has a partition table
Message-ID: <20040522125633.GA4777@apps.cwi.nl>
References: <16559.14090.6623.563810@hertz.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16559.14090.6623.563810@hertz.ikp.physik.tu-darmstadt.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 01:18:34PM +0200, Uwe Bonnes wrote:

> around last september there was a discussion about the linux kernel
> recognizing "supperfloppys" as disks with bogus partition tables.

Yes - already had forgotten about that - thanks for reviving

> Linux Torvalds wrote at one point in the discussion:

> >I don't mind the 0x00/0x80 "boot flag" checks - those look fairly 
> > obvious and look reasonably safe to add to the partitioning code.
> 
> The discussion seemed to fade out with no visible result, and for example my
> USB stick "ID 0d7d:1420 Apacer" with a floppy as second partition gets
> recognized as:
> SCSI device sdc: 2880 512-byte hdwr sectors (1 MB)
> sdc: Write Protect is off
>  sdc: sdc1 sdc2 sdc3 sdc4

What do you mean by "floppy as second partition"?

> Find appended a patch that does the 0x00/0x80 "boot flag" checks. Please
> discuss and consider for inclusion into the kernel.

> +#define BOOT_IND(p)	(get_unaligned(&p->boot_ind))
>  #define SYS_IND(p)	(get_unaligned(&p->sys_ind))

Hmm. get_unaligned() for a single byte?
I see no reason for these two macros.
Also, it is a good habit to parenthesize macro parameters.

> +	/* 
> +	   Some consistancy check for a valid partition table

consistency

> +	   Boot indicator must either be 0x80 or 0x0 on all primary partitions
> +	   Only one partition may be marked bootable (0x80)
> +	*/
> + 	p = (struct partition *) (data + 0x1be);
> +	for (slot = 1 ; slot <= 4 ; slot++, p++) {
> +	  if ((BOOT_IND(p) != 0x80) && (BOOT_IND(p) != 0x0))
> +	    return 0;
> +	  if (BOOT_IND(p) == 0x80) 
> +	    nr_bootable++;
> +	}
> +	if (nr_bootable > 1) 
> +	  return 0;

I have no objections.

Does it in your case suffice to check for 0 / 0x80 only
(without testing nr_bootable)?

I would prefer to omit that test, until there is at least one
person who shows a boot sector where it is needed.

Andries
