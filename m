Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTDJWNc (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbTDJWNc (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:13:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:17081 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264231AbTDJWNY convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 18:13:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Date: Thu, 10 Apr 2003 15:22:41 -0700
User-Agent: KMail/1.4.1
References: <UTC200304102209.h3AM9pf11795.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200304102209.h3AM9pf11795.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304101522.41236.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 April 2003 03:09 pm, Andries.Brouwer@cwi.nl wrote:

>
> I try to make sure there are no assumptions about the
> size or structure of device numbers anywhere outside kdev_t.h.
> In particular I object to the use of KDEV_MINOR_BITS.
>
> Apart from this formal point, there is also the practical point:
> suppose 64 = 32+32 is used, so that KDEV_MINOR_BITS equals 32.
> Then LAST_MAJOR_DISKS is 2^28 and sd_index_bits[] would be 32 MB array.
> Unreasonable.

agreed !! (I mentioned this ealier in my previous postings - sd_index_bits[]
array size)

>
> The conclusion is that the easy way out is to define MAX_NR_DISKS.

Unfortunately, MAX_NR_DISK will be dependent on KDEV_MINOR_BITS.
We can't set MAX_NR_DISKS to arbitrary value and if there are not
enought MINOR bits, it won't work. Only way to make this work is
to do dynamic major allocation and update /dev/ entries for them.

> A different way out, especially when we use 32+32, is to kill this
> sd_index_bits[] array, and give each disk a new number: replace
> 	index = find_first_zero_bit(sd_index_bits, SD_DISKS);
> by
> 	index = next_index++;
>
I wish it is that simple. We use sd_index_bits[] since we could
sd_detach() and then sd_attach()  few disks. We will end up with
holes, name slippage without this. We need to know what disks are 
currently being in use.

Thanks,
Badari

