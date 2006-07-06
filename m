Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWGFTDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWGFTDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWGFTDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:03:22 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:27363 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1750733AbWGFTDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:03:21 -0400
Message-ID: <44AD5E5C.6070703@colorfullife.com>
Date: Thu, 06 Jul 2006 21:02:52 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: Michael Kerrisk <mtk-manpages@gmx.net>, mtk-lkml@gmx.net, rlove@rlove.org,
       roland@redhat.com, eggert@cs.ucla.edu, paire@ri.silicomp.fr,
       torvalds@osdl.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
Subject: Re: Strange Linux behaviour with blocking syscalls and stop signals+SIGCONT
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com> <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com> <44AD5CB6.7000607@redhat.com>
In-Reply-To: <44AD5CB6.7000607@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:

>Manfred Spraul wrote:
>  
>
>>1) I would go further and try ERESTARTSYS: ERESTARTSYS means that the
>>kernel signal handler honors SA_RESTART
>>2) At least for the futex functions, it won't be as easy as replacing
>>EINTR wiht ERESTARTSYS: the futex functions receive a timeout a the
>>parameter, with the duration of the wait call as a parameter. You must
>>use ERESTART_RESTARTBLOCK.
>>    
>>
>
>Whoa, not so fast.  At least the futex syscall but be interruptible by
>signals.  It is crucial to return EINTR.
>
>  
>
Yes, of course.
ERESTARTSYS means honor SA_RESTART.
EINTR means return from the syscall, even if SA_RESTART is set in the 
signal handler.

Is it necessary that the futex syscall ignores SA_RESTART?

--
    Manfred


