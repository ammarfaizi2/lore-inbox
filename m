Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422896AbWBAT7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422896AbWBAT7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 14:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422907AbWBAT7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 14:59:16 -0500
Received: from mx1.suse.de ([195.135.220.2]:53663 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422896AbWBAT7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 14:59:15 -0500
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] AMD64: fix mce_cpu_quirks typos
References: <87fyn2yjpr.fsf@mid.deneb.enyo.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Feb 2006 20:59:06 +0100
In-Reply-To: <87fyn2yjpr.fsf@mid.deneb.enyo.de.suse.lists.linux.kernel>
Message-ID: <p731wymn94l.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> writes:

First please send x86-64 patches cc to the maintainer, things can
get lost in the noise of the list.

> The spurious MCE is TLB-related.  I *think* the bit for the correct
> status code is stored at position 10 HEX, not 10 DEC.  At least I
> still get those MCEs on a two-way Opteron box, even though they are
> supposed to be filtered out.

No, 10 is the correct bit index. But normally it's set by BIOS anyways.

The reason you still see it is that setting the bit here only
prevent MCE exceptions, but it's still logged and the regular polling
picks them up anyways. I have not found a nice way to handle this
(other than adding a ugly CPU specific special case in the middle
of the nice cpu independent machine check handler, which I couldn't 
bring myself to do so far...)

-Andi
