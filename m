Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTJGF0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 01:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTJGF0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 01:26:50 -0400
Received: from dyn-ctb-210-9-245-93.webone.com.au ([210.9.245.93]:17156 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261841AbTJGF0s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 01:26:48 -0400
Message-ID: <3F824E66.7020006@cyberone.com.au>
Date: Tue, 07 Oct 2003 15:25:58 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: maneesh@in.ibm.com
CC: Patrick Mochel <mochel@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Greg KH <gregkh@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
References: <20031006202656.GB9908@in.ibm.com> <Pine.LNX.4.44.0310061321440.985-100000@localhost.localdomain> <20031007043157.GA9036@in.ibm.com>
In-Reply-To: <20031007043157.GA9036@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Maneesh Soni wrote:

>On Mon, Oct 06, 2003 at 01:29:20PM -0700, Patrick Mochel wrote:
>
>>Uh, that's about the same thing I suggested, though probably not as 
>>concisely: 
>>
>>"As I said before, I don't know the right solution, but the directions to 
>>look in are related to attribute groups. Attributes definitely consume the 
>>most amount of memory (as opposed to the kobject hierachy), so delaying 
>>their creation would help, hopefully without making the interface too 
>>awkward. 
>>
>
>Ok.. attributes do consume maximum in sysfs. In the system I mentioned
>leaf dentries are about 65% of the total.
>
>
>>You can also use the assumption that an attribute group exists for all the 
>>kobjects in a kset, and that a kobject knows what kset it belongs to. And
>>
>
>That's not correct... kobject corresponding to /sys/block/hda/queue 
>doesnot know which kset it belongs to and what are its attributes. Same
>for /sys/block/hda/queue/iosched.
>
>
>>that eventually, all attributes should be added as part of an attribute 
>>group.."
>>
>>Attributes are the leaf entries, and they don't need to always exist. But, 
>>you have easy access to them via the attribute groups of the ksets the 
>>kobjects belong to. 
>>
>>
>
>Having backing store just for leaf dentries should be fine. But there is 
>_no_ easy access for attributes. For this also I see some data change required 
>as of now. The reasons are 
> - not all kobjects belong to a kset. For example, /sys/block/hda/queue
> - not all ksets have attribute groups
>  
>

queue and iosched might not be good examples as they are somewhat broken
wrt the block device scheme. Possibly they will be put in their own kset,
with /sys/block/hda/queue symlinked to them.


