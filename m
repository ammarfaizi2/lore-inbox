Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVCVNqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVCVNqj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 08:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVCVNqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 08:46:39 -0500
Received: from dwdmx2.dwd.de ([141.38.3.197]:5686 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S261226AbVCVNq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 08:46:28 -0500
Date: Tue, 22 Mar 2005 13:46:06 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, "Moore, Eric  Dean" <emoore@lsil.com>
Subject: RE: Fusion-MPT much faster as module
In-Reply-To: <200503221029.j2MATNg12775@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0503221344170.17195@diagnostix.dwd.de>
References: <200503221029.j2MATNg12775@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Chen, Kenneth W wrote:

> On Mon, 21 Mar 2005, Andrew Morton wrote:
>> Holger, this problem remains unresolved, does it not?  Have you done any
>> more experimentation?
>>
>> I must say that something funny seems to be happening here.  I have two
>> MPT-based Dell machines, neither of which is using a modular driver:
>>
>> akpm:/usr/src/25> 0 hdparm -t /dev/sda
>>
>> /dev/sda:
>> Timing buffered disk reads:  64 MB in  5.00 seconds = 12.80 MB/sec
>
>
> Holger Kiehl wrote on Tuesday, March 22, 2005 12:31 AM
>> Got the same result when compiled in, always between 12 and 13 MB/s. As
>> module it is approx. 75 MB/s.
>
>
> Half guess, half with data to prove: it must be the variable driver_setup
> initialization.  If compiled as built-in, driver_setup is initialized to
> zero for all of its member variables, which isn't the fastest setting. If
> compiled as module, it gets first class treatment with shinny performance
> setting.  Goofing around, this patch appears to be giving higher throughput.
>
Yes, that fixes it.

Many thanks!

Holger
