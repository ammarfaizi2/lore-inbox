Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVKWPMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVKWPMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbVKWPMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:12:17 -0500
Received: from darwin.snarc.org ([81.56.210.228]:17133 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S1750945AbVKWPMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:12:16 -0500
Date: Wed, 23 Nov 2005 16:12:14 +0100
From: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
To: Gerd Knorr <kraxel@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051123151214.GA4230@snarc.org>
References: <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com> <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438359D7.7090308@suse.de>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 06:48:07PM +0100, Gerd Knorr wrote:
> +	smp = kmalloc(sizeof(*smp), GFP_KERNEL);
> +	if (NULL == smp)
> +		return; /* we'll run the (safe but slow) SMP code then ... */
> +
> +	memset(smp,0,sizeof(*smp));

what about using kzalloc ?

> +	if (ALT_UP == smp_alt_state)
> +		goto out;

any chance to write it smp_alt_state == ALT_UP ?

IMHO, this way of writting equal condition is backward (like giving
answer before asking the question). I do know of the (pseudo-)benefit
to write it this way, but that's not worth it.

Plus, nowadays, gcc warns you about simple equal in if.

Cheers,
-- 
Vincent Hanquez
