Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbTEVQK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 12:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTEVQK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 12:10:27 -0400
Received: from holomorphy.com ([66.224.33.161]:49292 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262735AbTEVQKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 12:10:18 -0400
Date: Thu, 22 May 2003 09:23:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: mikpe@csd.uu.se
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: arch/i386/kernel/mpparse.c warning fixes
Message-ID: <20030522162305.GT8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mikpe@csd.uu.se, akpm@digeo.com, linux-kernel@vger.kernel.org
References: <20030522155320.GP29926@holomorphy.com> <16076.62927.525714.113342@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16076.62927.525714.113342@gargle.gargle.HOWL>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>> -	if (m->mpc_apicid > MAX_APICS) {
>> +	if (MAX_APICS - m->mpc_apicid <= 0) {
>>  		printk(KERN_WARNING "Processor #%d INVALID. (Max ID: %d).\n",
>>  			m->mpc_apicid, MAX_APICS);
>>  		--num_processors;

On Thu, May 22, 2003 at 06:07:43PM +0200, mikpe@csd.uu.se wrote:
> Eeew. Whatever the original problem is, this "fix" is just too
> obscure and ugly.

m->mpc_apicid is an 8-bit type; MAX_APICS can be 256. The above fix
properly compares two integral expressions of equal width.

Also, as MAX_APICS-1 is reserved for the broadcast physical APIC ID
(it's 0xF for serial APIC and 0xFF for xAPIC) the small semantic change
here is correct.


-- wli
