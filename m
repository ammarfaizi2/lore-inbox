Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWCASaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWCASaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWCASaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:30:13 -0500
Received: from mail.suse.de ([195.135.220.2]:449 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750778AbWCASaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:30:11 -0500
From: Andi Kleen <ak@suse.de>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Subject: Re: AMD64 X2 lost ticks on PM timer
Date: Wed, 1 Mar 2006 19:29:58 +0100
User-Agent: KMail/1.9.1
Cc: Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org
References: <200602280022.40769.darkray@ic3man.com> <200603011647.34516.ak@suse.de> <20060301180714.GD20092@ti64.telemetry-investments.com>
In-Reply-To: <20060301180714.GD20092@ti64.telemetry-investments.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603011929.59307.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 19:07, Bill Rugolsky Jr. wrote:

> Mar  1 11:39:27 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)

Yes, I bet something forgets to turn on interrupts again and it's picked up by
(and blamed on) the next guy who does an unconditional sti, which happens to be __do_sofitrq
or idle.


> Time to instrument sata_nv, I suppose.  Many thanks for helping to narrow this
> down.

Sprinkle WARN_ON(in_interrupt()) all over the parts that shouldn't have interrupts 
off.

-Andi
