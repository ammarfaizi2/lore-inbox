Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVAEWYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVAEWYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 17:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVAEWYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 17:24:50 -0500
Received: from host-83-146-9-72.bulldogdsl.com ([83.146.9.72]:11600 "EHLO
	host-83-146-9-72.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S262614AbVAEWYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 17:24:34 -0500
Message-ID: <41DC691F.3010800@unsolicited.net>
Date: Wed, 05 Jan 2005 22:24:31 +0000
From: David R <spam.david.trap@unsolicited.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fw: [Bugme-new] [Bug 3993] New: sata_sx4 causes file corruption
 during simultaneous writes
References: <20050105133548.13ac80d3.akpm@osdl.org>
In-Reply-To: <20050105133548.13ac80d3.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>controller, using the libata sata_sx4 driver.  Individual writes to the drives
>are fine.  When the drives are written to simultaneously, either by multiple cp
>threads or assembling them in a raid 5, corruption occurs as evidenced by fsck
>errors and inconsistent md5 sums.
>
>  
>
FWIW at <$dayjob> we have had exactly the same issues using Win2k (ugh) 
and Promise's own drivers on a Dual Opteron system (Rioworks HDAMA) with 
an integrated Fastrak S150TX4 controller. Relatively stable using a 
single drive as a separate volume (our application prefers a RAID 0 
stripe), but random subtle corruptions when using an array (striped or 
mirrored). This is both using the controller's embedded RAID and W2K's 
software RAID (with the Promise configured to present separate disks). 
Firmware upgrades/downgrades were tried with no luck. We have two 
identically configured machines that both exhibit the same problem.

Interestingly, the errors were always single flipped bit(s) at random 
offset(s) within the file. Different on each run. Sounds like a RAM 
issue but both machines memtest fine and run without issues when using a 
single drive.

We never found a solution (we simply use single (large) SATA drives 
instead) :-(

David




