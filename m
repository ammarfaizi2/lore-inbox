Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266164AbUA2B2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 20:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266081AbUA2B1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 20:27:50 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:12676 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S265808AbUA2B1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 20:27:46 -0500
Date: Wed, 28 Jan 2004 20:27:03 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 4/8] autofs4-2.6 - to support autofs 4.1.x
In-reply-to: <Pine.LNX.4.44.0401290832020.16657-100000@wombat.indigo.net.au>
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>, "H. Peter Anvin" <hpa@zytor.com>
Message-id: <40186167.6040608@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
 Debian/1.6-1
References: <Pine.LNX.4.44.0401290832020.16657-100000@wombat.indigo.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent wrote:

>On Wed, 28 Jan 2004, Mike Waychison wrote:
>
>  
>
>>raven@themaw.net wrote:
>>
>>    
>>
>>>Patch:
>>>
>>>4-autofs4-2.6.0-test9-waitq2.patch
>>>
>>>Adds a spin lock to serialize access to wait queue in the super block info
>>>struct.
>>>
>>> 
>>>
>>>      
>>>
>>A while back I wrote up a patch for autofs3 that serialized waitq access 
>>and changed the waitq counters to atomic_t.  I never sent it out because 
>>I had realized that the changes I made weren't needed as all waitq 
>>code-paths were running under the BKL (the big ones were ->lookup and 
>>the ioctls). 
>>    
>>
>
>My understanding is that this code can be reached at least via lookup, 
>readdir and revalidate. I thought that in 2.6 none of these held the BKL 
>on entry (I'll have to check). Certainly this is the case for revalidate.
>
>
>  
>
I just took a look at the autofs4 code and the BKL is explicitly held in 
the lookup code.   It is also implicitly held in the ioctl code.

My understanding is that when the dcache (and subsequently 
->d_revalidate) was introduced into the Linux kernel, autofs3 was 
modified to do revalidates, and would have had it's lock_kernel calls 
added then.  If autofs4 had forked off before the dcache addition, it 
wouldn't have picked the lock_kernel in d_revalidate.

Peter/Jeremy, could you confirm this?


-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

