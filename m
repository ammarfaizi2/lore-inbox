Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWCVXKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWCVXKG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWCVXKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:10:06 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:52887 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751425AbWCVXKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:10:04 -0500
Message-ID: <4421D943.1090804@garzik.org>
Date: Wed, 22 Mar 2006 18:09:55 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>
CC: Anthony Liguori <aliguori@us.ibm.com>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>,
       ian.pratt@cl.cam.ac.uk, SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
In-Reply-To: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pratt wrote:
>>This is another thing that has always put me off.  The 
>>virtual block device driver has the ability to masquerade as 
>>other types of block devices.  It actually claims to be an 
>>IDE or SCSI device allocating the appropriate major/minor numbers.
>>
>>This seems to be pretty evil and creating interesting failure 
>>conditions for users who load IDE or SCSI modules.  I've seen 
>>it trip up a number of people in the past.  I think we should 
>>only ever use the major number that was actually allocated to us.
> 
> 
> We certainly should be pushing everyone toward using the 'xdX' etc
> devices that are allocated to us. However, the installers of certain
> older distros and other user space tools won't except anything other
> than hdX/sdX, so its useful from a compatibility POV even if it never
> goes into mainline, which I agree it probably shouldn't. 

Yes, this is true.  Red Hat installer guys grumbled at me when I wrote 
the 'sx8' block driver:  since it wasn't hda/sda, they had to write 
special code for it, as they apparently must do for any new block driver 
"class".  SuSE and other distros are probably similar, since each block 
driver provides its own special behaviors and feature exports.

I should have spoken up a long time ago about this, but anyway:

An IBM hypervisor on ppc64 communicates uses SCSI RPC messages.  I think 
this would be quite nice for Xen, because SCSI (a) is a message-based 
model, and (b) implementing block using SCSI has a very high Just 
Works(tm) value which cannot be ignored.  And perhaps (c) SCSI target 
code already exists, so implementing the server side doesn't require 
starting from scratch, but rather simply connecting the Legos.

	Jeff


