Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129344AbRBYOzO>; Sun, 25 Feb 2001 09:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129338AbRBYOzF>; Sun, 25 Feb 2001 09:55:05 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:51019
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129344AbRBYOys>; Sun, 25 Feb 2001 09:54:48 -0500
Date: Sun, 25 Feb 2001 15:54:38 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s/isa//g in drivers/scsi/g_NCR5380.c and some cleanup (242)
Message-ID: <20010225155438.E764@jaquet.dk>
In-Reply-To: <20010225154043.D764@jaquet.dk> <E14X2RG-0003D4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14X2RG-0003D4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Feb 25, 2001 at 02:46:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 02:46:15PM +0000, Alan Cox wrote:
> > I am sorry but have I inverted the arguments to the memcpy_*io calls?
> > Or are you referring to something other than the arguments here?
> 
> You seem to have swapped the source/dest over in memcpy_toio cases and I need
> to convince myself you did that correctly

Yes, that is neither obvious nor nice. My apologies, but I could not
find a better way.

Explanation: The memcpy_toio cases goes like this:

-       isa_memcpy_toio(NCR53C400_host_buffer+NCR5380_map_name,src+start,128);
+       memcpy_toio(isa_remap_ptr+OFFSET_FROM_REMAPPING, src+start, 128);

isa_remap_ptr is the ioremap from NCR5380_map_name + NCR53C400_mem_base.
I would like to memcpy from NCR53C400_host_buffer+NCR5380_map_name thus
needing to add the difference between NCR53C400_host_buffer and the
NCR53C400_mem_base (used in isa_remap_ptr). Thus, in the hope that
this can be done linearly, I add OFFSET_FROM_REMAPPING 
(NCR53C400_host_buffer - NCR53C400_mem_base). (BTW, this is also done
in the memcpy_fromio cases.)

I hope that the above is readable.
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)
