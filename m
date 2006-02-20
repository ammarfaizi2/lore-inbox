Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWBTP7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWBTP7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWBTP7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:59:08 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:11409 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964940AbWBTP7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:59:07 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43F9E70C.5030809@s5r6.in-berlin.de>
Date: Mon, 20 Feb 2006 16:58:04 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Subodh Shrivastava <subodh.shrivastava@gmail.com>,
       linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org, bcollins@debian.org, scjody@modernduck.com
Subject: Re: ieee1394 failed to work after S3 resume.
References: <8b12046a0602191137n12997938kd8404814f7c8e2ba@mail.gmail.com>
In-Reply-To: <8b12046a0602191137n12997938kd8404814f7c8e2ba@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.635) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subodh Shrivastava wrote:
> Suspend to Ram works fine here with 2.6.16-rc3 kernel except ieee1394
> fails to resume properly.
...
[SCSI command timeout in sbp2 after resume; no nodemgr updates after resume]
...

AFAICT the reason is that the host adapter drivers (1394 low-level 
drivers) ohci1394 and pcilynx lack proper .suspend and .resume hooks. 
Such functionality seems only be present for Powermacs with Uninorth 
chipset.

OHCI 1.1 table A-11 says (surprise!) that host adapters loose PCI 
configuration and 1394 configuration when going into D3 state. We don't 
backup and restore it yet. I could perhaps look into it in late spring 
or summer.
-- 
Stefan Richter
-=====-=-==- --=- =-=--
http://arcgraph.de/sr/
