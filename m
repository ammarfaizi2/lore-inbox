Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbQKPFiV>; Thu, 16 Nov 2000 00:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbQKPFiM>; Thu, 16 Nov 2000 00:38:12 -0500
Received: from Host4.modempool1.milfordcable.net ([206.72.42.4]:2820 "HELO
	windeath.2y.net") by vger.kernel.org with SMTP id <S129449AbQKPFh7>;
	Thu, 16 Nov 2000 00:37:59 -0500
Message-ID: <3A136CA4.A061DA26@windeath.2y.net>
Date: Wed, 15 Nov 2000 23:12:04 -0600
From: James M <dart@windeath.2y.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gert Wollny <wollny@cns.mpg.de>
Cc: linux-kernel@vger.kernel.org, twaugh@redhat.com
Subject: Re: BUG Report 2.4.0-test11-pre3: NMI Watchdoch detected LOCKUP 
 atCPU[01]
In-Reply-To: <Pine.LNX.4.10.10011152005570.769-200000@bolide.beigert.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gert Wollny wrote:
> 
> Hello,
> 
> i think it got it nailed, please try the attached patch (it is against
> 11-pre4, but it should work against all test11).
> 
> Explanation:
> with test7-pre6 in the  imm-module the new scsi - code was enabled (see
> imm.h).
> This causes the locking of the io_request_lock in scsi_register_host
> (scsi.c) during detection of the ZIP drive. Seems, that the request_module
> call for the parport_pc doesn't like this.
> The patch does, what the comment in scsi.c suggests: Enable the new code
> only, after the drive is detected.
> 
> Have a nice day

Thank you Gert. I turned off Winbond support as before and it truly is
"safe to say no" now. Your patch seems to work. Good Job.

Still outstanding:

If (mode=SPP && Zip100) Log_msg("Spp is godawful slow, set for EPP in
bios");
// I don't know off top of my head if Zip250 can use ECP or not
// Zip100 is EPP at best

Imm driver reports Zip100 at 101 MB

ECP/EPP setting in Bios yields SPP for Zip100. 1284 spec says you should
be able to set mode 100 to get EPP and even tho it's a M$ extension most
chipsets should support it.

Speed Sucks: Hdparm reports 496k/sec for EPP on a 64 MB buffered disk
read. 1284 spec says 500k/2 MB for EPP and Iomega says it can do 1.4 MB
sustained for Zip100. Not that it matters but SPP runs 96k/sec.

I'm coding up a parport-poker to get familiar then I'll take a stab at
these if someone doesn't beat me to it.

> 
> Gert
> 
> 
> 
>   ------------------------------------------------------------------------
>                           Name: imm-lockup.patch
>    imm-lockup.patch       Type: Plain Text (TEXT/PLAIN)
>                       Encoding: BASE64
>                    Description: the patch
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
