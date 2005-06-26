Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVFZHQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVFZHQj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 03:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVFZHQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 03:16:39 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:3217 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S261414AbVFZHQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 03:16:34 -0400
X-IronPort-AV: i="3.93,230,1115017200"; 
   d="scan'208"; a="194328360:sNHT30733944"
Message-ID: <42BE563D.4000402@cisco.com>
Date: Sun, 26 Jun 2005 17:16:13 +1000
From: Lincoln Dale <ltd@cisco.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregory Maxwell <gmaxwell@gmail.com>
CC: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>	 <42BCD93B.7030608@slaphack.com>	 <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>	 <42BDA377.6070303@slaphack.com>	 <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>	 <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com>
In-Reply-To: <e692861c05062522071fe380a5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:

>On 6/26/05, Lincoln Dale <ltd@cisco.com> wrote:
>  
>
>>the l-k community have asked YOU may times.  any lack of response isn't
>>because of the kernel cabal .. its because YOU are refusing to entertain
>>any notion that what Reiser4 has implemented is unpalatable to the
>>kernel community.
>>    
>>
>
>A lot of this is based on misconceptions, for example in recent times
>reiser4 is faulted for layering violations.. But it doesn't have them,
>it neither duplicates nor modifies the VFS.
>
>It has also been requested that reiser4 be changed to move some of
>it's operations above the VFS... not only would that not make sense
>for the currently provided functions, but merging was put off
>previously because of changes to the VFS.... now that it doesn't
>change the VFS we are asking hans to push it off until it does??
>  
>
<sigh>

it has NEVER been a case of Reiser4 not being merged because "it 
required changes to VFS".

the whole point of VFS is to provide a standard API for data to/from 
individual filesystems.
over the course of history, VFS itself hasn't been a static thing - it 
has had to adapt and change as a result of the needs of filesystems.
but it hasn't ever been a case of individual filesystems doing 
'proprietary' things (i.e. there isn't a sys_ext3() system call) - where 
it has made sense to do things at a VFS layer, VFS itself has been 
adapted to handle those things.

a semi-recent example of this is extended attributes.
it is with some irony that on my desktop i make use of the excellent 
open-source desktop search tool 'beagle'.
it, however, uses extended attributes for storing things - and Reiser4's 
EAs are incompatible with the "standard" EAs such that Reiser4 is 
incompatible with beagle.

this is the WHOLE point of standardization .. i don't think its that 
Reiser4's EAs offer any more or less capabilities than standard EAs - 
BUT they haven't used the standard mechanisms available for implementing 
them, such for Beagle to work on Reiser4, there now needs to be logic 
added to Beagle to do so.

lets take this a step further.  what about compression?  do we accept 
that each filesystem can implement its own proprietary compression via 
its own API - and now we need individual user-space tools to understand 
each of these APIs?
how about encryption?
... and so-on.
suddenly every user app out there needs to have specialized knowledge of 
each type of filesystem.

Hans should be applauded for the 'plug-in' concept and showing how it 
can be used.  however, from an implementation stand-point, it really 
shouldn't come as any great surprise that numerous kernel developers are 
pushing back saying 'layering violation' and "why can't this be done at 
the VFS layer".

none of this is rocket-science.  its just plain common sense.

>It's a filesysem for gods sake. Hans and his team have worked hard to
>minimize its impact and they are still willing to accept more
>guidance,
>
i don't see any acceptance at this point.  simply lots of hot air that 
smells like marketing & PR.


cheers,

lincoln.
