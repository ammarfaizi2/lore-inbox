Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVCWFND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVCWFND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 00:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVCWFND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 00:13:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:900 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262786AbVCWFMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 00:12:38 -0500
Message-ID: <4240FAB9.5040200@pobox.com>
Date: Wed, 23 Mar 2005 00:12:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH libata-dev-2.6 05/05] libata: rework how CCs generated
References: <20050317221753.53957EDF@lns1032.lss.emc.com> <20050317221753.0D09D0D9@lns1032.lss.emc.com>
In-Reply-To: <20050317221753.0D09D0D9@lns1032.lss.emc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> 05_libata_split_ata_to_sense_error.patch
> 
> 	This patch fixes several bugs as well as reorganizes the way
> 	check conditions are generated.  Bugs fixed: 1) in
> 	ata_scsi_qc_complete(), ATA_12/16 commands wouldn't call
> 	ata_pass_thru_cc() on error status; 2) ata_pass_thru_cc()
> 	wouldn't put the SK, ASC, and ASCQ from ata_to_sense_error()
> 	in the correct place in the sense block because
> 	ata_to_sense_error() was writing a fixed sense block.
> 
> 	Per the recommendations in the comments, ata_to_sense_error()
> 	is now split into 3 parts.  The existing fcn is only used for
> 	outputting a sense key/ASC/ASCQ triplicate.  A new function
> 	ata_dump_status() was created to print the error info, similar
> 	to the ide variety.  A third function ata_gen_fixed_sense()
> 	was created to generate a fixed length sense block.  I added
> 	the use of the info field for 28b LBAs only.
> 	ata_pass_thru_cc() renamed to ata_gen_ata_desc_sense() to
> 	match naming convention, presumably to include another
> 	descriptor format function in the future (see question 2
> 	below).
> 
> 	Questions:
> 
> 	1) I made the ata_gen_..._sense() routines read the status
>            register themselves rather than use the drv_stat values
>            that used to be passed in?  These values seemed
>            unreliable/useless since they were often hard coded (see
>            calls to ata_qc_complete() for origins of most drv_stat
>            variables).  Sound ok?
> 
> 	2) the SAT spec has little about error handling and sense
>            information, sepcifically what descriptor format is valid
>            for use by SAT commands.  I want to use descriptor type 00
>            (information) in my next patch until a spec says
>            differently.  Sound ok?
> 
> Signed-off-by: Brett Russ <russb@emc.com>

Patch in general is OK, but I would prefer that it be split up a bit 
more.  Suggested split:

* whitespace changes (obscures reviewing the code)
* create and use ata_dump_status()
* the rest of the changes

Regards,

	Jeff


