Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291250AbSBGT5Y>; Thu, 7 Feb 2002 14:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291248AbSBGT5F>; Thu, 7 Feb 2002 14:57:05 -0500
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:33502 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S291247AbSBGT4r>;
	Thu, 7 Feb 2002 14:56:47 -0500
Date: Thu, 7 Feb 2002 14:55:46 -0500
From: Mark Frazer <mark@somanetworks.com>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Martin Wirth <Martin.Wirth@dlr.de>, akpm@zip.com.au, torvalds@transmet.com,
        mingo@elte.hu, rml@tech9.net, nigel@nrg.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020207145546.A14022@somanetworks.com>
In-Reply-To: <3C629F91.2869CB1F@dlr.de> <200202071822.g17IMgS14802@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202071822.g17IMgS14802@ns.caldera.de>; from hch@ns.caldera.de on Thu, Feb 07, 2002 at 07:22:42PM +0100
X-Message-Flag: Lookout!
Organization: Detectable, well, not really
X-Fry: How can I live my life if I can't tell good from evil?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@ns.caldera.de> [02/02/07 14:41]:
> What about the following instead:
> 
> 	combi_lock(struct combilock *x, int spin);
> 	combi_unlock(struct combilock *x);

how about
        combi_lock (struct combilock *x, int canblock, int shouldblock);

Where the should block flag is copied to the mutex once it's held by
the caller to indicate to new threads grabbing the lock how long the
lock will be held for.

For locks that are held for some short duration tasks and some long
duration tasks, the holder should indicate how long the lock will be held.
I'd consider that an improvement over the "spin for a while then block"
idea.

Interrupt handlers can't block, so we need a flag to never block.

-mark
