Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129290AbRBYOUD>; Sun, 25 Feb 2001 09:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129284AbRBYOTy>; Sun, 25 Feb 2001 09:19:54 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:13643
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129283AbRBYOTi>; Sun, 25 Feb 2001 09:19:38 -0500
Date: Sun, 25 Feb 2001 15:19:30 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s/isa//g in drivers/scsi/g_NCR5380.c and some cleanup (242)
Message-ID: <20010225151930.C764@jaquet.dk>
In-Reply-To: <20010225145642.B764@jaquet.dk> <E14X1o6-00035n-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14X1o6-00035n-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Feb 25, 2001 at 02:05:42PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 02:05:42PM +0000, Alan Cox wrote:
[...]
> > (An indication of how often this code path is used can be found in
> > the fact that the previous define of NCR5380_write had its payload
> > and address mixed up, probably making for wierd results should
> > the code ever be executed.)
> 
> The driver works for me nicely. Im not convinced by the changes of direction
> either. At least not without a detailed audit on the 2.2 code. Some of the
> naming is very misleading in that driver
> 

Looking at the define of NCR_5380_write

#define NCR5380_write(reg, value) isa_writeb(NCR5380_map_name + +NCR53C400_mem_base + (reg), value)

followed by an use of NCR5380_write

    NCR5380_write(C400_CONTROL_STATUS_REG, CSR_BASE | CSR_TRANS_DIR);

I doubt that it is not the intention to write CSR_BASE | CSR_TRANS_DIR
at the offset C400_CONTROL_STATUS_REG. But note that this argument
swap only is in the code produced by -DCONFIG_SCSI_G_NCR5380_MEM.
Perhaps you use CONFIG_SCSI_G_NCR5380_PORT? Otherwise I must admit
that I have been had...
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Duct tape is like the force; it has a light side and a dark side, and
it holds the universe together.
  -- Anonymous
