Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTKZKkH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 05:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTKZKkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 05:40:07 -0500
Received: from holomorphy.com ([199.26.172.102]:15805 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264126AbTKZKkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 05:40:04 -0500
Date: Wed, 26 Nov 2003 02:39:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
Message-ID: <20031126103957.GK8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ihar 'Philips' Filipau <filia@softhome.net>,
	Rik van Riel <riel@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <VQJL.62Q.11@gated-at.bofh.it> <VR3c.6Ns.21@gated-at.bofh.it> <3FC480BF.9060301@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC480BF.9060301@softhome.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
>> Strict non-overcommit mode.  You can allocate as much
>> non-file-backed virtual memory as will fit in swap,
>> plus /proc/sys/vm/overcommit_percentage worth of memory.

On Wed, Nov 26, 2003 at 11:30:23AM +0100, Ihar 'Philips' Filipau wrote:
>   [ s/overcommit_percentage/overcommit_ratio/ ]
>   Thanks! On 2.6 it works as expected. Test with two concurrent memory 
> allocations took some time, but both apps stops exactly when memory was 
> depleted. Great.
>   Did rmap has something todo with this?
>   As I see from implementation of do_mmap_pgoff() - it changed from 2.4 
> to 2.6 - but there are a lot of common things.
>   If I will do dumb back port of this check to 2.4 - do you think it 
> will work? 2.4->2.6 memory accounting changed?
>   I didn't found this check in your rmap patches for 2.4.22. (btw 
> thanks for keeping them up-to-date).

In principle, non-overcommit shouldn't be dependent on rmap, as it
largely consists of keeping track of the sum of MAP_PRIVATE virtual
mappings' sizes and refusing them when they exceed RAM + swap.

-- wli
