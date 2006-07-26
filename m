Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWGZNCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWGZNCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 09:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbWGZNCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 09:02:08 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61457 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750700AbWGZNCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 09:02:07 -0400
Date: Wed, 26 Jul 2006 15:02:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Lang <dlang@digitalinsight.com>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
Message-ID: <20060726130207.GC23701@stusta.de>
References: <20060725034247.GA5837@kroah.com> <m33bcqdn5y.fsf@anduin.mandriva.com> <200607251123.40549.adq_dvb@lidskialf.net> <Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 09:47:43AM -0700, David Lang wrote:
> On Tue, 25 Jul 2006, Andrew de Quincey wrote:
> 
> >On Tuesday 25 July 2006 10:55, Arnaud Patard wrote:
> >>Greg KH <gregkh@suse.de> writes:
> >>
> >>Hi,
> >>
> >>>We (the -stable team) are announcing the release of the 2.6.17.7 kernel.
> >>
> >>Sorry, but doesn't compile if DVB_BUDGET_AV is set :(
> >>
> >>>Andrew de Quincey:
> >>>      v4l/dvb: Fix budget-av frontend detection
> >
> >
> >In fact it is just this patch causing the problem:
> <SNIP>
> >Sorry, I had so much work going on in that area I must have diffed the 
> >wrong
> >kernel when I created this patch. :(
> 
> is it reasonable to have an aotomated test figure out what config options 
> are relavent to a patch (or patchset) and test compile all the combinations 
> to catch this sort of mistake?

If you think about it, you'll notice it's definitely not reasonable:

#include <linux/module.h> brings you a dependency on 5 config options.
#include <linux/pci.h> brings you a dependency on 6 config options.

By only including these two headers you are at 2048 combinations.
The number of valid configurations will be lower, but 500 test compiles 
sound realistically.

With have a dozen #include's you might need more than a million test 
compiles.

With a dozen #include's, you might need a trilion [1] test compiles.


Compile errors are quickly catched and don't cause any serious problem.

What bothers me more is that noone tested this patch against the kernel 
it was applied against.

The submitter didn't test it works (he didn't even test the compilation).

No user tested it.

Currently, -stable kernels get an 48 hours review on linux-kernel but 
zero testing.

How could this be improved?
Longer review/testing time?
Offer them as also one 2.6.17.7-rc1 patch?

> David Lang

cu
Adrian

[1] American English

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

