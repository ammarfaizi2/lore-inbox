Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVJKKkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVJKKkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 06:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVJKKkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 06:40:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:46984 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751329AbVJKKkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 06:40:12 -0400
Subject: Re: ide_wait_not_busy oops still with 2.6.14-rc3 (Re: 1GHz pbook
	15", linux 2.6.14-rc2 oops on resume)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1129026807.21318.15.camel@localhost>
References: <1128323544.4602.5.camel@localhost>
	 <pan.2005.10.06.19.19.22.673915@nn7.de>  <1128720351.17365.48.camel@gaston>
	 <1128948118.23434.13.camel@localhost>  <1128982002.17365.163.camel@gaston>
	 <1129026807.21318.15.camel@localhost>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 20:36:26 +1000
Message-Id: <1129026986.17365.206.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 12:33 +0200, Soeren Sonnenburg wrote:
> On Tue, 2005-10-11 at 08:06 +1000, Benjamin Herrenschmidt wrote:
> > > ok, here is the complete one:
> > > 
> > > BUG: soft lockup detected on CPU#0!
> > 
> > Gack, the soft lockup thing. Can you disable that ? If you do so, does
> > it crashes instead of oopsing or just "pauses" for a little while on
> > wakeup ? The problem is that ide_do_request does a synchronous wait for
> > the drive to get out of busy state which can take a while with some
> > optical drives on wakeup. It might be possible to allow scheduling
> > there, I have to look at it. In the meantime, disable the lockup
> > detector (CONFIG_DETECT_SOFTLOCKUP) and tell me if that's enough.
> 
> Hmmhh, I already compiled 2.6.14-rc4 but did not disable
> soft-lockup-ing, should I still do it - the oops looks better as it is
> not followed by a ATAPI reset anymore:

It's still pretty annoying. I'll see what I can do but it won't be for
2.6.14 timeframe, so in the meantime, just ignore it or remove soft
lockup detection.

Ben.


