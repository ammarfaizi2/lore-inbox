Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269698AbUJGFT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269698AbUJGFT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 01:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269700AbUJGFT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 01:19:56 -0400
Received: from lists.us.dell.com ([143.166.224.162]:6004 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S269698AbUJGFTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 01:19:54 -0400
Date: Thu, 7 Oct 2004 00:19:39 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@redhat.com,
       david.balazic@hermes.si
Subject: Re: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR
Message-ID: <20041007051939.GA9075@lists.us.dell.com>
References: <20041004214803.GC2989@lists.us.dell.com> <4164C89A.2040408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4164C89A.2040408@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 12:39:54AM -0400, Jeff Garzik wrote:
> Alas, this does not eliminate the 30-second delay on my box.

OK, thanks for trying.  So it's not the READ SECTORS call itself
that's the problem.
 
> Just to re-emphasize, I feel a particularly relevant detail is that my 
> VIA-based Athlon64 box has _all_ PATA ports disabled.
> 
> I am fairly certainly that the delay did not exist when I enabled at 
> least one PATA port, and I can verify this if you would like.

Yeah, that'd be good to know.  The PATA controller doesn't show up in
your lspci results from 5 July, so I'm sure you had it turned off then too.

BIOS reports having 4 disks in your system.  Does that match
what you would expect?

Your boot disk is on this Promise controller, yes?
00:0d.0 RAID bus controller: Promise Technology, Inc. PDC20378
(SATA150 TX) (rev 02)

The second disk is on a different controller though, with its own EDD
3.0-compliant BIOS.
00:0f.0 RAID bus controller: VIA Technologies,
Inc. VIA VT6420 SATA
        RAID Controller (rev 80)
        Subsystem: Micro-Star International Co., Ltd. MSI Neo K8T
	FIS2R mainboard

Then BIOS says you've got two more disks.
Both disks 82 and 83 look remarkably small (20808 sectors each,
~10MB).  And I would bet there's no media present, as there's no
mbr_signature field given...  So BIOS says there's a disk there, but
there really isn't.  Which could cause the kind of timeout you're
seeing.  To what are these attached?  It's the BIOS for this
controller that's probably what's lying.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
