Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVAKTLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVAKTLu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVAKTLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:11:50 -0500
Received: from main.gmane.org ([80.91.229.2]:54933 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262339AbVAKTLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:11:25 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jim Zajkowski <jamesez@umich.edu>
Subject: Sparse LUN scanning - 2.4.x
Date: Tue, 11 Jan 2005 14:05:53 -0500
Message-ID: <cs182h$6nl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 141.211.74.215
User-Agent: Unison/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

We have an Apple Xserve RAID, connected through a FC switch.  The RAID 
has LUN-masking enabled, such that one of our Linux boxes only gets LUN 
1 and not LUN 0.  We're running the 2.4.x kernel series now, since this 
is under a RHEL envinronment.

The problem is this: since LUN 0 does not show up -- specifically, it 
can't read the vendor or model informaton -- the kernel SCSI scan does 
not match with the table to tell the kernel to do sparse LUN 
scanning... so the RAID does not appear.

I can make the RAID show up by injecting a add-single-device to the 
SCSI proc layer.  Trivially patching scsi_scan.c to always do sparse 
scanning works as well.  No hokery with max_scsi_luns or ghost devices 
works.

I'm considering making a patch to add a kernel option to force sparse 
scanning.  Is there a better way?

Thanks in advance,

--Jim

-- 
Jim Zajkowski          OpenPGP 0x21135C3    http://www.jimz.net/pgp.asc
System Administrator  8A9E 1DDF 944D 83C3 AEAB  8F74 8697 A823 2113 5C53
UM Life Sciences Institute

 


