Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131283AbQKPTrn>; Thu, 16 Nov 2000 14:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131308AbQKPTrd>; Thu, 16 Nov 2000 14:47:33 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:32392 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131283AbQKPTrU>; Thu, 16 Nov 2000 14:47:20 -0500
From: Christoph Rohland <cr@sap.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: shm swapping in 2.4 again
In-Reply-To: <Pine.LNX.4.21.0011160959340.13085-100000@duckman.distro.conectiva>
Organisation: SAP LinuxLab
Date: 16 Nov 2000 20:17:02 +0100
In-Reply-To: Rik van Riel's message of "Thu, 16 Nov 2000 10:01:11 -0200 (BRDT)"
Message-ID: <qwwwve3ybf5.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Thu, 16 Nov 2000, Rik van Riel wrote:
> On 16 Nov 2000, Christoph Rohland wrote:
>> So in shm_swap_out I check if the page is already in the swap
>> cache. If not I put the page into it and note the swap entry in
>> the shadow pte of shm. Right?
> 
> Exactly. And I'll change page_launder() to:
> 1. write dirty swap cache pages to disk
> 2. do some IO clustering (maybe) or rely on luck ;)
> 
>> So does the page live all the time in the swap cache? This would
>> lead to a vastly increased swap usage since we would have to
>> preallocate the swap entries on page allocation.
> 
> If the usage count of the swap entry is 1 (all users of the
> page have swapped it in and the swap cache is the only user),
> then we can free the page from swap and the swap cache.

Great. So what do we have to do to get this done? The shm stuff sounds
pretty easy.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
