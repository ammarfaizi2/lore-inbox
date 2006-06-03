Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWFCKoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWFCKoe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 06:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWFCKoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 06:44:34 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:11662 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750815AbWFCKoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 06:44:34 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44816794.7060601@s5r6.in-berlin.de>
Date: Sat, 03 Jun 2006 12:42:28 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andreas Schwab <schwab@suse.de>, scjody@modernduck.com,
       bcollins@ubuntu.com, mjt@tls.msk.ru, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [stable] [PATCH] sbp2: fix check of return value of	hpsb_allocate_and_register_addrspace
References: <tkrat.f195e45ae32b9c02@s5r6.in-berlin.de>	<20060603013515.GV18769@moss.sous-sol.org>	<44814A63.1080707@s5r6.in-berlin.de> <44815283.7080306@tls.msk.ru>	<jemzcu7fgw.fsf@sykes.suse.de> <20060603024305.dd0404d0.akpm@osdl.org>
In-Reply-To: <20060603024305.dd0404d0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.733) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 03 Jun 2006 11:31:27 +0200
> Andreas Schwab <schwab@suse.de> wrote:
>>Michael Tokarev <mjt@tls.msk.ru> writes:
>>>>>* Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
>>>>>>-    if (!scsi_id->status_fifo_addr) {
>>>>>>+    if (scsi_id->status_fifo_addr == ~0ULL) {
>>>
>>>Umm.  Can this ~0ULL constant be #define'd to something?
>>>It's way too simple to mis-read it as NULL (or ~NULL whatever).
>>
>>How about writing it as -1?
> 
> That's preferable.
> 
> It doesn't actually cause a problem, but status_fifo_addr is defined as
> u64, which is not `unsigned long long'.  On powerpc, for example, u64 is
> implemented as unsigned long.  -1 just works.

I have a patch ready which replaces the magic value by a sensibly named 
preprocessor constant. Will be posted within the hour. Thanks for the 
comments.
-- 
Stefan Richter
-=====-=-==- -==- ---==
http://arcgraph.de/sr/
