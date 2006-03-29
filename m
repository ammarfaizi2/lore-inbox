Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWC2XBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWC2XBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWC2XBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:01:46 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:65166 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751008AbWC2XBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:01:45 -0500
Message-ID: <442B11CC.6040503@vilain.net>
Date: Thu, 30 Mar 2006 11:01:32 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain> <4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at> <4428FB29.8020402@yahoo.com.au> <20060328142639.GE14576@MAIL.13thfloor.at> <44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org>
In-Reply-To: <20060329225241.GO15997@sorel.sous-sol.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>* Sam Vilain (sam@vilain.net) wrote:
>  
>
>>extern struct security_operations *security_ops; in
>>include/linux/security.h is the global I refer to.
>>    
>>
>
>OK, I figured that's what you meant.  The top-level ops are similar in
>nature to inode_ops in that there's not a real compelling reason to make
>them per process.  The process context is (usually) available, and more
>importantly, the object whose access is being mediated is readily
>available with its security label.
>  
>

AIUI inode_ops are not globals, they are per FS.

>>There is likely to be some contention there between the security folk
>>who probably won't like the idea that your security module can be
>>different for different processes, and the people who want to provide
>>access to security modules on the systems they want to host or consolidate.
>>    
>>
>
>I think the current setup would work fine.  It's less likely that we'd
>want a separate security module for each container than simply policy
>that is container aware.
>  
>

That to me reads as:

"To avoid having to consider making security_ops non-global we will
force security modules to be container aware".

It also means you could not mix security modules that affect the same
operation different containers on a system. Personally I don't care, I
don't use them. But perhaps this inflexibility will bring problems later
for some.

I think it's a design decision that is not completely closed, but the
inertia is certainly in the favour of your position.

Sam.
