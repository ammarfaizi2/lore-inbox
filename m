Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVK0Rjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVK0Rjz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 12:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVK0Rjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 12:39:55 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:37315 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751118AbVK0Rjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 12:39:55 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       paulmck@us.ibm.com, greg@kroah.com, Douglas_Warzecha@dell.com,
       Abhay_Salunke@dell.com, achim_leubner@adaptec.com,
       dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain 
In-reply-to: Your message of "Sun, 27 Nov 2005 18:27:25 BST."
             <20051127172725.GJ20775@brahms.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 28 Nov 2005 04:39:36 +1100
Message-ID: <24158.1133113176@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2005 18:27:25 +0100, 
Andi Kleen <ak@suse.de> wrote:
>On Mon, Nov 28, 2005 at 02:59:05AM +1100, Keith Owens wrote:
>> On Sun, 27 Nov 2005 14:47:36 +0100, 
>> Andi Kleen <ak@suse.de> wrote:
>> >akpm wrote
>> >>   - Introduce a new notifier API which is wholly unlocked
>> >
>> >The old notifiers were already wholly unlocked. So it wouldn't 
>> >even need any changes. Just additional locks everywhere.
>> 
>> Wrong.  
>
>Did you actually read what I wrote? 

Of course I did.  The whole point is that _ALL_ of the existing
notifier chain callback code is racy[*].  Saying that the code can be
left without any changes is simply ignoring the existing races.  They
_ALL_ need to be fixed.

[*] Except for one bit of hand crafted locking in USB.

