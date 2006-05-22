Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWEVTPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWEVTPL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWEVTPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:15:10 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:46096 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1751117AbWEVTPJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:15:09 -0400
Message-ID: <44720DB8.4060200@argo.co.il>
Date: Mon, 22 May 2006 22:15:04 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: fitzboy <fitzboy@iparadigms.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tuning for large files in xfs
References: <447209A8.2040704@iparadigms.com>
In-Reply-To: <447209A8.2040704@iparadigms.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2006 19:15:06.0781 (UTC) FILETIME=[093784D0:01C67DD4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fitzboy wrote:
>
> BUT... here is what I need to understand, the filesize has a drastic
> effect on performance. If I am doing random reads from a 20GB file
> (system only has 2GB ram, so caching is not a factor), I get
> performance about where I want it to be: about 5.7 - 6ms per block. But
> if that file is 2TB then the time almost doubles, to 11ms. Why is this?
> No other factors changed, only the filesize.
>

With the 20GB file, the disk head is seeking over 1% of the tracks. With 
the 2TB file, it is seeking over 100% of the tracks.

>
> I am assuming that somewhere along the way, the kernel now has to do an
> additional read from the disk for some metadata for xfs... perhaps the
> btree for the file doesn't fit in the kernel's memory? so it actually
> needs to do 2 seeks, one to find out where to go on disk then one to

No, the btree should be completely cached fairly soon into the test.

> get the data. Is that the case? If so, how can I remedy this? How can I
> tell the kernel to keep all of the files xfs data in memory?

Add more disks. If you're writing, use RAID 1.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

