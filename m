Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbUKVVsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbUKVVsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbUKVVmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:42:54 -0500
Received: from alog0143.analogic.com ([208.224.220.158]:11904 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262377AbUKVVgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:36:39 -0500
Date: Mon, 22 Nov 2004 16:30:21 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Justin Thiessen <jthiessen@penguincomputing.com>, greg@kroah.com,
       phil@netroedge.com, khali@linux-fr.org, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: adm1026 driver port for kernel 2.6.10-rc2  [RE-REVISED DRIVER]
In-Reply-To: <1101157242.2813.34.camel@laptop.fenrus.org>
Message-ID: <Pine.LNX.4.61.0411221625570.23112@chaos.analogic.com>
References: <20041102221745.GB18020@penguincomputing.com> 
 <NN38qQl1.1099468908.1237810.khali@gcu.info>  <20041103164354.GB20465@penguincomputing.com>
  <20041118185612.GA20728@penguincomputing.com>  <1100945635.2639.31.camel@laptop.fenrus.org>
  <20041122194327.GB4698@penguincomputing.com> <1101157242.2813.34.camel@laptop.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Arjan van de Ven wrote:

>
>>> this locking construct is rahter awkward; is it possible to refactor the
>>> code such that you can down and up in the same function ?
>>
>> Yes, at the cost of some minor code duplication or the introduction of
>> another variable.  Is that preferable?  Is holding the lock across function
>> calls a Bad Idea?
>
> holding lock across function calls isn't, unlocking in another function
> than you take the lock is.
> For one it makes auditing the code a lot harder.
>

Also, code like:

 	down(&mylock);
 	do_something();
         if(fail) {
             up(&mylock);
             return retval;
         }

... is prone to errors where a lock never gets released on some
corner cases. It's often better to "goto" a common exit point where
the lock is released.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
