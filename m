Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVHaHx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVHaHx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVHaHx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:53:29 -0400
Received: from [218.25.172.144] ([218.25.172.144]:26898 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932467AbVHaHx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:53:28 -0400
Message-ID: <431561EE.8000909@fc-cn.com>
Date: Wed, 31 Aug 2005 15:53:18 +0800
From: Qi Yong <qiyong@fc-cn.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       dhommel@gmail.com
Subject: Re: syscall: sys_promote
References: <20050826092537.GA3416@localhost.localdomain>	 <20050826110226.GA5184@localhost.localdomain>	 <1125069558.4958.83.camel@localhost.localdomain>	 <4312870E.9000708@fc-cn.com>	 <1125318568.23946.15.camel@localhost.localdomain> <a36005b505082908415d9202d5@mail.gmail.com>
In-Reply-To: <a36005b505082908415d9202d5@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:

>On 8/29/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>  
>
>>Fixing it might be useful in some obscure cases anyway - POSIX threads
>>might benefit from it too, providing the functionality of changing all
>>thread uids at once isnt triggered for sensible threaded app behaviour.
>>    
>>
>
>I would very much like to see that fixed.  Currently we have to change
>the UIDs/GIDs at userlevel with cross-thread calls implemented via
>signals.  This is user observable which is not correct.  This is
>probably the last area where we're not 100% POSIX compliant.
>
>As for adding this proposed syscall: it can only lead to chaos.  All
>kinds of user code correctly so assumes the IDs don't change over the
>lifetime of a process.  The solution for the problem has been
>  
>
After a user shell is promoted to root, its prompt is still $ instead of 
#. But why do we care?

>mentioned as well: re-exec.  This will require some code rewrite on
>the side of the applications but any decent daemon is hopefully soon
>  
>

OK, so any decent processes should not break into other processes' 
address space.
And let us use non-preemptive multitasking?

>support re-exec anyway for another reason: re-randomization of the
>address space.  What good does address space randomization do if the
>machines and programs are so damn stable that they keep running for
>months at a time?  nscd supports this now and I think openssh as well.
>  
>

