Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVKXNF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVKXNF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 08:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVKXNF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 08:05:29 -0500
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:5763 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S1750769AbVKXNF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 08:05:28 -0500
Message-ID: <4385B9BB.7020007@draigBrady.com>
Date: Thu, 24 Nov 2005 13:01:47 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Daniel Jacobowitz <dan@debian.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org> <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Wed, 23 Nov 2005, Daniel Jacobowitz wrote:
>  
>
>>Why should we use a silicon based solution for this, when I posit that
>>there are simpler and equally effective userspace solutions?
>>    
>>
>
>Name them.
>
>In user space, doing things like clever run-time linking things is 
>actually horribly bad. It causes COW faults at startup, and/or makes the 
>compiler have to do indirections unnecessarily.  Both of which actually 
>make caches less effective, because now processes that really effectively 
>do have exactly the same contents have them in different pages.
>
>The other alternative (which apparently glibc actually does use) is to 
>dynamically branch over the lock prefixes, which actually works better: 
>it's more work dynamically, but it's much cheaper from a startup 
>standpoint and there's no memory duplication, so while it is the "stupid" 
>approach, it's actually better than the clever one.
>  
>
Just a note to say glibc is getting better wrt to locking.
Compare the results and trival test program here:
http://lkml.org/lkml/2001/12/7/75
That showed that for glibc 2.2.4, getc & putc
were 669% slower than the unlocked versions.

4 years later and with 2.3.5-1ubuntu1, getc & putc
are only 230% slower than the unlocked versions:

$ dd bs=1MB count=100 if=/dev/zero | ./locked >/dev/null
100000000 bytes transferred in 3.709362 seconds (26958813 bytes/sec)
$ dd bs=1MB count=100 if=/dev/zero | ./unlocked >/dev/null
100000000 bytes transferred in 1.602427 seconds (62405339 bytes/sec)

Pádraig.
