Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269418AbUIIKsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269418AbUIIKsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 06:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269419AbUIIKsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 06:48:14 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:21435 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269418AbUIIKsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 06:48:10 -0400
Message-ID: <4140311D.4080405@yahoo.com.au>
Date: Thu, 09 Sep 2004 20:31:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Nick Piggin <piggin@cyberone.com.au>,
       Nathan Lynch <nathanl@austin.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2/2] cpu hotplug notifier for updating sched domains
References: <200409071849.i87Inw3f143238@austin.ibm.com>	 <413E55D8.8030608@cyberone.com.au> <1094608996.8015.5.camel@booger>	 <413E6C49.5080106@cyberone.com.au> <1094725124.25639.18.camel@bach>
In-Reply-To: <1094725124.25639.18.camel@bach>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Wed, 2004-09-08 at 12:19, Nick Piggin wrote:

>>Do you have a theoretical race here? Can we hotplug a CPU before the notifier
>>is registered? (I know we *can't* because it is still earlyish boot).
> 
> 
> No, init has so many serial assumptions that this is the least of our
> worries.
> 

No. But the point is, you cannot (easily) set something up like this:

"do some setup with this specific, valid cpu_online_map";
"register notifier so we can keep everything valid";

without a race between them. Protecting the notifier chain under a
different lock is the trivial fix. I'll send the patch if you'd
like?
