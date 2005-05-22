Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVEVGt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVEVGt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 02:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVEVGt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 02:49:57 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:36769 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261746AbVEVGty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 02:49:54 -0400
Message-ID: <42902B8C.1070401@colorfullife.com>
Date: Sun, 22 May 2005 08:49:48 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.7) Gecko/20050417 Fedora/1.7.7-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: randy_dunlap <rdunlap@xenotime.net>
CC: Patrick Plattes <patrick@erdbeere.net>, linux-kernel@vger.kernel.org
Subject: Re: semaphore understanding: sys_semtimedop()
References: <20050516201704.GA9836@erdbeere.net> <20050521222151.15bb0eb4.rdunlap@xenotime.net>
In-Reply-To: <20050521222151.15bb0eb4.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

randy_dunlap wrote:

>On Mon, 16 May 2005 22:17:04 +0200 Patrick Plattes wrote:
>
>| The variable decrease will never be used again in this 
>| function, so why this intricate code? Isn't this much easier and works
>| also:
>| 
>|         for (sop = sops; sop < sops + nsops; sop++) {
>|                 if (sop->sem_num >= max)
>|                         max = sop->sem_num;
>|                 if (sop->sem_flg & SEM_UNDO)
>|                         undos++;
>|                 if (sop->sem_op != 0)
>|                         alter = 1;
>|         }
>| 
>| Maybe i'm totally wrong, so please correct me and don't shoot me up,
>| 'cause i'm not a os developer.
>
>Looks like a reasonable and correct optimization to me.
>
>  
>
It looks correct:
decrease was added during 2.1 development: it's not in 2.0.40, it's in 
2.2.26: I think the idea was that operations with decrease can cause 
other threads to block, therefore a different wakeup strategy was used. 
The wakeup implementation was rewritten, but the loop remained unchanged.
I'll write a patch, thanks Patrick.

--
    Manfred
