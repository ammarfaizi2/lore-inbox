Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbWD1QD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbWD1QD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030469AbWD1QD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:03:29 -0400
Received: from smtpout.mac.com ([17.250.248.183]:28133 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030468AbWD1QD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:03:29 -0400
In-Reply-To: <1146238623.11909.524.camel@pmac.infradead.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com> <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org> <1146105458.2885.37.camel@hades.cambridge.redhat.com> <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org> <1146107871.2885.60.camel@hades.cambridge.redhat.com> <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org> <20060427213754.GU3570@stusta.de> <Pine.LNX.4.64.0604271439100.3701@g5.osdl.org> <20060427231200.GW3570@stusta.de> <Pine.LNX.4.64.0604271656390.3701@g5.osdl.org> <Pine.LNX.4.61.0604281729250.9011@yvahk01.tjqt.qr> <1146238623.11909.524.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BEF524DD-84E8-4579-ABFC-0AFB9EAC1982@mac.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Simple header cleanups
Date: Fri, 28 Apr 2006 12:01:49 -0400
To: David Woodhouse <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 28, 2006, at 11:37:03, David Woodhouse wrote:
> On Fri, 2006-04-28 at 17:32 +0200, Jan Engelhardt wrote:
>> Sounds like they want it BSD-style. Do they realize that?  New  
>> release, new headers, making it necessary to recompile every app,  
>> because a struct could have changed. That'd seriously impact  
>> compatibility.
>
> Utter crap.
>
> We don't _change_ any of the structs which would be exposed in such  
> files (i.e. the structs which should be outside the #ifdef  
> __KERNEL__ at the moment, because that would mean we break  
> userspace binary compatibility from kernel to kernel.
>
> We absolutely do _NOT_ want to go there. We're talking about  
> cleaning up the existing mess, not starting a crack habit.

Example:  Say the proposed utsname virtualization gets a new clone  
flag (CLONE_NEWUTSNAME).  Old headers would obviously not include the  
CLONE_NEWUTSNAME define.  If you want to compile a glibc that uses  
CLONE_NEWUTSNAME, you need to build it against a set of the "kabi  
headers" from a version of the kernel that includes the feature.  The  
resulting glibc will _run_ on any kernel; if you call clone 
(CLONE_NEWUTSNAME) on an older kernel it would return EINVAL but work  
otherwise.  A glibc that does *not* use CLONE_NEWUTSNAME would build  
an identical binary with older versions and newer versions.  This is  
_exactly_ the way things work now, except there is no outside llh  
project, it's all stored in the kernel tree.

Cheers,
Kyle Moffett
