Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVIGRRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVIGRRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVIGRRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:17:54 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:48290 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751091AbVIGRRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:17:53 -0400
Message-ID: <431F20AA.1090101@cs.wisc.edu>
Date: Wed, 07 Sep 2005 12:17:30 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
CC: boutcher@cs.umn.edu, hch@lst.de, vst@vlnb.net,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, santil@us.ibm.com, lxiep@us.ibm.com
Subject: Re: [RFC] SCSI target for IBM Power5 LPAR
References: <20050906212801.GB14057@cs.umn.edu>	<20050907104932.GA14200@lst.de>	<20050907124504.GA13614@cs.umn.edu> <20050907215816C.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20050907215816C.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FUJITA Tomonori wrote:
> month. We discussed it with Christoph and decided that it would be
> better to start from scratch because of the design differences.

Some of the things we are trying to improve upon are things that are 
better supported in 2.6. Some differences:

- We will support controller hotplug.
- We allow any type of device (dm, scsi, ide, LVM@ etc) as storage. And 
we do not want hook into SCSI-ml's upper layer drivers and deal with 
that refcounting if we can help it so we push a lot of code to userspace 
and only do reads and writes in the kernel.
- We also hope to support any block layer target.
- As mentioned before, scatterlists by using the block layer's support.

There may be more that I am forgetting, but originally we started out by 
trying to clean up the SCST code for 2.6 and make it resemble SCSI-ml's 
hotplug model. As we did this it looked like some code could live in 
userspace and it would end up being a rewrite becuase there was so much 
to do so we started a new project. We hope to work with Vlad and the 
SCST developers.
