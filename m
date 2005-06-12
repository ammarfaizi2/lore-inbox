Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVFLEVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVFLEVG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 00:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVFLEVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 00:21:06 -0400
Received: from opersys.com ([64.40.108.71]:41992 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261158AbVFLEVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 00:21:02 -0400
Message-ID: <42ABBA95.3050602@opersys.com>
Date: Sun, 12 Jun 2005 00:31:17 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] local_irq_disable removal
References: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com>
In-Reply-To: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel Walker wrote:
> Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The current 
> method does "lea" which takes 1 cycle, and "or" which takes 1 cycle. I'm 
> not sure if there is any function call overhead .. So the soft replacment 
> of cli/sti is 70% faster on a per instruction level .. So it's at least 
> not any slower .. Does everyone agree on that?

The proof is in the pudding: it's not for nothing that the results
we published earlier show that the mere enabling of Adeos actually
increases Linux's performance under heavy load.

This could easily be called the Stodolsky effect. Here, have a look
at this article, it was presented at the USENIX Symposium on
Microkernels and Other Kernel Architectures ... in 1993:
http://www-2.cs.cmu.edu/afs/cs.cmu.edu/user/danner/www/OptSynch.ps
We've been referring back to this paper as early as the first public
release of Adeos ... in June 2002.

That being said, I'm not sure exactly why you guys are reinventing the
wheel. Adeos already does this soft-cli/sti stuff for you, it's been
available for a few years already, tested, and ported to a number of
architectures, and is generalized, why not just adopt it? After all,
like I've been saying for some time, it isn't mutually exclusive with
PREEMPT_RT.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
