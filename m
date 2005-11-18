Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVKRUbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVKRUbI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVKRUbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:31:07 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:46464 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S932407AbVKRUbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:31:06 -0500
Message-ID: <437E33E5.2060603@soleranetworks.com>
Date: Fri, 18 Nov 2005 13:04:53 -0700
From: jmerkey <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Swap Bug Massive EXT3 Corruption on FC4 with 2.6.14 update
References: <437CC67C.4060109@soleranetworks.com> <1132346133.5238.4.camel@localhost.localdomain>
In-Reply-To: <1132346133.5238.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Iau, 2005-11-17 at 11:05 -0700, jmerkey wrote:
>  
>
>>To reproduce, install FC2 on an /dev/hda device with defaults, then 
>>install FC4 on a /dev/hdb device, build the 2.6.14 update for
>>FC4 and watch your data disappear.
>>    
>>
>
>Should be reported in the FC bugzilla although I've not been able to
>reproduce it.
>
>
>  
>

Alan,

I'll report over there.  I reproduced it with an install of Suse 10.0 
and FC4 and got to the bottom of it.  During install of FC4, anaconda 
allocates
the swap partitions assigned to Suse 10.0 on /dev/hda (or any swap 
partitions on the primary drive) for use during the install.  After the 
install
completes, FC4 uses this LABEL-SWAP-hda2 (etc.) method for determining 
which partitions to use for swap.  What happened here it turned
out was not related to swap extents, but misidentifcation of which 
partition was assigned this LABEL-XXX tag.  Upon first boot of FC4,
it allocated /dev/hda6 (the / partitition) as swap and started swapping 
to the / partition for Suse 10.0.  I first saw it when I installed FC4 
on a system
with FC2.  After FC2 / partition got trashed, I reinstalled with Suse 
10.0 (since I am porting DSFS to all of these distributions) and then 
reinstalled
FC4 on /dev/hdb -- same thing happened again. 

I just finished reinstalling Suse 10.0 and tried with FC2 on /dev/hdb.  
FC2 does the same thing and gets mixed on on Swap on the /dev/hda 
device, but this time, it did not corrupt the Suse 10.0 on /dev/hda.  
This appears to be a bug in anaconda and the setup for the FCX 
distributions.  ES and AS probably do the same thing since they use 
anaconda, so I would have someone look into this.

Jeff
