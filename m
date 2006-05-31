Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWEaCuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWEaCuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 22:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWEaCuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 22:50:07 -0400
Received: from terminus.zytor.com ([192.83.249.54]:37002 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751573AbWEaCuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 22:50:06 -0400
Message-ID: <447D0453.5070201@zytor.com>
Date: Tue, 30 May 2006 19:49:55 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@HansenPartnership.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: i386 subarchitectures: boot page table flags
References: <447CF7F5.8010709@zytor.com> <1149042065.3545.49.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1149042065.3545.49.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Tue, 2006-05-30 at 18:57 -0700, H. Peter Anvin wrote:
>> Does any of the i386 subarchitectures actually care about the Accessed and Dirty bits in 
>> the bootup pagetables (the ones that start at pg0, used before the mm is initialized?)  If 
>> not, I'd like to speed up booting by setting those bits at initialization time.
> 
> Depends what you mean by "care".  I do hijack pg0 in
> voyager_memory_detect() to access the clickmap for ascertaining the
> memory layout, but I don't use the accessed or dirty bits.

Okay...

Leaving the A and D bits clear means the CPU has to trap to microcode to 
set those bits before it is allowed to load the entry into the TLB. 
Furthermore, and this is the real killer on some CPUs, it is not allowed 
to load those entries speculatively.

As far as I can tell, this is completely pointless for pg0.

(And no, the Voyager code wouldn't be affected.)

	-hpa

