Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWGYBJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWGYBJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWGYBJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:09:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932372AbWGYBJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:09:53 -0400
Date: Mon, 24 Jul 2006 17:59:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Arjan van de Ven <arjan@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: remove cpu hotplug bustification in cpufreq.
In-Reply-To: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
Message-ID: <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Jul 2006, Chuck Ebbert wrote:
> 
> I thought just the 'ondemand' governor was a problem?

The ondemand governor seems to be singled out not because it has unique 
problems, but because it seems to be used by Fedora Core for some strange 
reason.

I would judge that any bugs in cpufreq_ondemand.c are likely equally 
evident in cpufreq_conservative.c, for example. I think the two have the 
same background, and seem to have the same broken locking.

> That thing has been broken since day 1 AFAICT.  There are lots of
> reports of problems with it on the list.

See above. I seriously doubt this is ondemand-specific. The whole cpufreq 
locking seems to be very screwed up.

The current -git tree will complain about some of the more obvious 
problems. If you see a "Lukewarm IQ" message, it's a sign of somebody 
re-taking a cpu lock that is already held.

			Linus
