Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVAYPik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVAYPik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVAYPik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:38:40 -0500
Received: from [195.23.16.24] ([195.23.16.24]:32683 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261987AbVAYPiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:38:12 -0500
Message-ID: <41F66799.5050004@grupopie.com>
Date: Tue, 25 Jan 2005 15:36:57 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
References: <20050124021516.5d1ee686.akpm@osdl.org>	 <20050125125323.GA19055@infradead.org> <1106662284.5257.53.camel@uganda>	 <20050125142356.GA20206@infradead.org> <1106666690.5257.97.camel@uganda>
In-Reply-To: <1106666690.5257.97.camel@uganda>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> [...]
> No, it is not called lock order reversal.
> 
> There are no places like
> lock a
> lock b
> unlock a
> unlock b

This would be perfectly fine. The order of unlocking doesn't really 
matter. It is the actual locking that must be carried out on the same 
order everywhere to guarantee that there are no deadlocks.

> and if they are, then I'm completely wrong.
> 
> What you see is only following:
> 
> place 1:
> lock a
> lock b
> unlock b
> lock c
> unlock c
> unlock a
> 
> place 2:
> lock b
> lock a
> unlock a
> lock c
> unlock c
> unlock b

I haven't look at the code yet, but this is a deadlock waiting to 
happen. "place 1" gets "lock a", then is interrupted and "place 2" gets 
"lock b". "place 2" waits forever for "lock a" and "place 1" waits 
forever for "lock b". Deadlock.

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu

