Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTEVSXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTEVSXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:23:24 -0400
Received: from holomorphy.com ([66.224.33.161]:48269 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263056AbTEVSXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:23:16 -0400
Date: Thu, 22 May 2003 11:36:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: mikpe@csd.uu.se
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: arch/i386/kernel/mpparse.c warning fixes
Message-ID: <20030522183608.GV8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mikpe@csd.uu.se, akpm@digeo.com, linux-kernel@vger.kernel.org
References: <20030522155320.GP29926@holomorphy.com> <16076.62927.525714.113342@gargle.gargle.HOWL> <20030522162305.GT8978@holomorphy.com> <16077.5909.155004.502440@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16077.5909.155004.502440@gargle.gargle.HOWL>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>> m->mpc_apicid is an 8-bit type; MAX_APICS can be 256. The above fix
>> properly compares two integral expressions of equal width.

On Thu, May 22, 2003 at 08:29:41PM +0200, mikpe@csd.uu.se wrote:
> In the original "_>_", the 8-bit mpc_apicid is implicitly converted to int
> before the comparison, as part of the "integer promotions" in the "usual
> arithmetic conversions" (C standard lingo). The same happens in your "_-_<=0".
> So what's the benefit of the rewrite?

It removes a warning about comparisons being always true or false by
virtue of the limited range of a type.


William Lee Irwin III writes:
>> Also, as MAX_APICS-1 is reserved for the broadcast physical APIC ID
>> (it's 0xF for serial APIC and 0xFF for xAPIC) the small semantic change
>> here is correct.

On Thu, May 22, 2003 at 08:29:41PM +0200, mikpe@csd.uu.se wrote:
> No argument there, except that ">=" gets the job done in a cleaner way.

This is actually massively confused anyway. It gets physical APIC ID
checks wrong for sparse xAPIC's on mach-default. But that's another
issue.


-- wli
