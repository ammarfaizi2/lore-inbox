Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbTFUAdO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 20:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbTFUAdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 20:33:14 -0400
Received: from mithra.wirex.com ([65.102.14.2]:35854 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id S265060AbTFUAdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 20:33:04 -0400
Message-ID: <3EF3AB03.20500@immunix.com>
Date: Fri, 20 Jun 2003 17:46:59 -0700
From: Crispin Cowan <crispin@immunix.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Bastian Blank <bastian@waldi.eu.org>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] builtin stack support
References: <20030620195051.GA28020@wavehammer.waldi.eu.org> <20030620233606.GA14869@kroah.com>
In-Reply-To: <20030620233606.GA14869@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Fri, Jun 20, 2003 at 09:50:51PM +0200, Bastian Blank wrote:
>  
>
>>hi folks
>>    
>>
>I'd suggest CC: the lsm mailing list, they might have some comments
>about this.
>
FYI, Chris Wright (one of the main LSM developers) left for a week's 
vacation today. This patch appears to be a major change in how LSM 
works, and I suspect Chris will want some time to consider it. So don't 
be terribly surprised if not much happens until June 30.

However, Chris also told me that he took his laptop with him. He might 
choose to take some of his vacation time to look at this.

>>- if the modules don't define a function, the call always travers
>>  through the stack until it hits the dummy module
>>- more pointer needs to be dereferences, more parameter
>>    
>>
>How does the performance of this work out, if you only have 1 security
>module?  In my opinion, preformance should not drop, unless you want to
>stack modules.
>
I agree with Greg. We deliberately did not design in explicit support. 
The priority scheme was:

   1. Have the least impact possible on kernels not using modules.
   2. Have the best performance possible for a single module.
   3. Push work for stacking modules onto module writers who want to stack.


>And did you see the previous stacker lsm module?  What advantage does
>this patch over that one?
>
The problem with module composition is that it is sometimes straight 
forward, but often problematic, and in some cases impossible. You 
*cannot* provide support for module composition in the general case; at 
best it will work sometimes. Wheeler's existing Stacker module 
encapsulates the logistics for supporting module composition in the 
simple cases, and module writers *need* to hack it themselves in the 
harder cases.

Crispin

-- 
Crispin Cowan, Ph.D.           http://immunix.com/~crispin/
Chief Scientist, Immunix       http://immunix.com
            http://www.immunix.com/shop/


