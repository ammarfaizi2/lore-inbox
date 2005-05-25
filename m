Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVEYCCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVEYCCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 22:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVEYCCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 22:02:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52985 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262232AbVEYCCh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 22:02:37 -0400
Message-ID: <4293DCB1.8030904@mvista.com>
Date: Tue, 24 May 2005 19:02:25 -0700
From: Sven Dietrich <sdietrich@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au, mingo@elte.hu,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <4292DFC3.3060108@yahoo.com.au>	<20050524081517.GA22205@elte.hu>	<4292E559.3080302@yahoo.com.au>	<20050524090240.GA13129@elte.hu>	<4292F074.7010104@yahoo.com.au>	<1116957953.31174.37.camel@dhcp153.mvista.com>	<20050524224157.GA17781@nietzsche.lynx.com>	<1116978244.19926.41.camel@dhcp153.mvista.com>	<20050525001019.GA18048@nietzsche.lynx.com>	<1116981913.19926.58.camel@dhcp153.mvista.com>	<20050525005942.GA24893@nietzsche.lynx.com>	<1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org>
In-Reply-To: <20050524184351.47d1a147.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Daniel Walker <dwalker@mvista.com> wrote:
>  
>
>>I'm not going to ignore any of the discussion, but it would be nice to
>> hear Andrew's, or Linus's specific objections..
>>    
>>
>This thing will be discussed on a patch-by-patch basis.  Contra this email
>thread, we won't consider it from an all-or-nothing perspective.
>
>(That being said, it's already a mighty task to decrypt your way through
>the maze-like implementation of spin_lock(), lock_kernel(),
>smp_processor_id() etc, etc.  I really do wish there was some way we could
>clean up/simplify that stuff before getting in and adding more source-level
>complexity).
>
>  
>
The IRQ threads are actually a separate implementation.

IRQ threads do not depend on mutexes, nor do they depend
on any of the more opaque general spinlock changes, so this
stuff SHOULD be separated out, to eliminate the confusion..

There was an original IRQ threads submission by
John Cooper/ TimeSys, about a year ago, which Ingo
subsequently rewrote.

The original MV RT-kernel contribution provided separate patches
for IRQ threads, based on Ingo's VP work.

Even Ingo's current IRQ thread implementation,
which provides a /proc interface to pop IRQs in and out of threads,
does not depend on any of the more complex RT-mutex related stuff.

And Ingo's IRQ threads implementation hasn't substantially
changed in close to a year now.

In that sense, Daniel's original query focuses on IRQ threads.

Its up to Ingo if he wants to break that out as a separate patch, again.

I think people would find their system responsiveness / tunability
goes up tremendously, if you drop just a few unimportant IRQs into
threads.

As a logical prerequisite to the Mutex stuff, the IRQ threads, if broken 
out,
could allow folks to test the water in the shallow end of the pool.

Give this technology some run-time, get everyone happy with it,
reduce the patch size for RT, and get the Arm folks, a.o. on generic IRQs,
then lets deal with the other pieces of RT, in a nice overseeable fashion.



Sven

