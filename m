Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTLCX6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbTLCX6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:58:43 -0500
Received: from holomorphy.com ([199.26.172.102]:6863 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262695AbTLCX6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:58:42 -0500
Date: Wed, 3 Dec 2003 15:58:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ethan Weinstein <lists@stinkfoot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HT apparently not detected properly on 2.4.23
Message-ID: <20031203235837.GW8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ethan Weinstein <lists@stinkfoot.org>, linux-kernel@vger.kernel.org
References: <3FCE2F8E.90104@stinkfoot.org> <20031203224023.GV8039@holomorphy.com> <3FCE74B0.9010506@stinkfoot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCE74B0.9010506@stinkfoot.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>>You probably have sparse physical APIC ID's.

On Wed, Dec 03, 2003 at 06:41:36PM -0500, Ethan Weinstein wrote:
> Ok, setting CONFIG_NR_CPUS=8 does indeed solve the HT issue, looks like 
> it was the numbering scheme:

It's easy to fix this; just terminate the loop when the count of cpus
kicked hits NR_CPUS or the bit would overflow the map instead of the bit
hitting NR_CPUS. Compare smpboot.c in 2.4 vs. 2.6. No need for the extra
CONFIG_NR_CPUS bloat.


On Wed, Dec 03, 2003 at 06:41:36PM -0500, Ethan Weinstein wrote:
> But we're still only interrupting on CPU0 with this kernel.

That's P-IV retardation. Not really fixable, but irqbalance daemons
etc. can help mitigate the severity of the erratum. I'm not sure if
2.4 has the interfaces for the userspace solutions to work or the
kernel solutions either.


-- wli
