Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbTEPWtq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 18:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTEPWtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 18:49:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47448 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S263246AbTEPWtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 18:49:46 -0400
To: Andi Kleen <ak@muc.de>
Cc: kraxel@suse.de, jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
References: <20030515145640.GA19152@averell>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 May 2003 16:58:39 -0600
In-Reply-To: <20030515145640.GA19152@averell>
Message-ID: <m1of2233ds.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> x86-64 cannot call the 32bit VESA BIOS. This means when vesafb is active
> it does software copying in the vesa frame buffer. This is insanely slow
> when the frame buffer is not marked for write combining. 
> 
> Some discussion showed that the use_mtrr flag was only off for some 
> old broken ET4000 ISA card. x86-64 has no ISA, so this is no concern.
> Make the default depend on CONFIG_ISA. 
> 
> Patch for 2.5.69.  Originally suggested by Gerd Knorr.

I don't know if this affects the frame buffers per se.

But often BIOS's on systems with large amounts of memory configure
overlapping mtrrs (where an uncacheable mtrr would override a larger
cacheable range).  To date this has confused the linux mtrr code when
it tries to modify things, and you cannot properly setup mtrrs.    I
believe this applies to both the fb case as well as X.

Eric
