Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269703AbUJGFc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269703AbUJGFc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 01:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269704AbUJGFc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 01:32:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24469 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269703AbUJGFcZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 01:32:25 -0400
Message-ID: <4164D4D4.4040407@pobox.com>
Date: Thu, 07 Oct 2004 01:32:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@redhat.com,
       david.balazic@hermes.si
Subject: Re: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR
References: <20041004214803.GC2989@lists.us.dell.com> <4164C89A.2040408@pobox.com> <20041007051939.GA9075@lists.us.dell.com>
In-Reply-To: <20041007051939.GA9075@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> On Thu, Oct 07, 2004 at 12:39:54AM -0400, Jeff Garzik wrote:
> 
>>Alas, this does not eliminate the 30-second delay on my box.
> 
> 
> OK, thanks for trying.  So it's not the READ SECTORS call itself
> that's the problem.
>  
> 
>>Just to re-emphasize, I feel a particularly relevant detail is that my 
>>VIA-based Athlon64 box has _all_ PATA ports disabled.
>>
>>I am fairly certainly that the delay did not exist when I enabled at 
>>least one PATA port, and I can verify this if you would like.
> 
> 
> Yeah, that'd be good to know.  The PATA controller doesn't show up in
> your lspci results from 5 July, so I'm sure you had it turned off then too.
> 
> BIOS reports having 4 disks in your system.  Does that match
> what you would expect?
> 
> Your boot disk is on this Promise controller, yes?
> 00:0d.0 RAID bus controller: Promise Technology, Inc. PDC20378
> (SATA150 TX) (rev 02)
> 
> The second disk is on a different controller though, with its own EDD
> 3.0-compliant BIOS.
> 00:0f.0 RAID bus controller: VIA Technologies,
> Inc. VIA VT6420 SATA
>         RAID Controller (rev 80)
>         Subsystem: Micro-Star International Co., Ltd. MSI Neo K8T
> 	FIS2R mainboard
> 
> Then BIOS says you've got two more disks.
> Both disks 82 and 83 look remarkably small (20808 sectors each,
> ~10MB).  And I would bet there's no media present, as there's no
> mbr_signature field given...  So BIOS says there's a disk there, but
> there really isn't.  Which could cause the kind of timeout you're
> seeing.  To what are these attached?  It's the BIOS for this
> controller that's probably what's lying.

One SATA disk is attached to the Promise SATA controller, and one SATA 
disk is attached to the VIA SATA controller.

I _think_ the Promise controller boots first, but I could be wrong.

I'll try enabling a PATA port sometime when it isn't 1:30am :)

	Jeff


