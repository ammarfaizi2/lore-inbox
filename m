Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266497AbUALVsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUALVsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:48:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10144 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266497AbUALVse
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:48:34 -0500
Message-ID: <40031623.2000204@pobox.com>
Date: Mon, 12 Jan 2004 16:48:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [I810_AUDIO] 1/x: Fix wait queue race in drain_dac
References: <20031122070931.GA27231@gondor.apana.org.au> <4001B979.1080600@pobox.com> <20040112094625.GA16686@gondor.apana.org.au>
In-Reply-To: <20040112094625.GA16686@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> On Sun, Jan 11, 2004 at 04:00:41PM -0500, Jeff Garzik wrote:
> 
>>Thanks much for these i810_audio patches.  I've been meaning to review 
>>them in-depth for some time.
> 
> 
> Thanks a lot for reviewing them.
> 
> 
>>Could you be kind and "spell out" the patch-1 race for me?
> 
> 
> Prior to the patch, if an interrupt occured between the count check
> and the setting of the current state the wait will timeout instead
> of waking up immediately.

hmmm, I'll have to think on this one a bit.  You are described observed 
behavior here... can you go a bit deeper, and describe what two code 
paths are racing?  I think I might a _different_ race in the code we're 
looking at, but I do not yet see the race you are describing :(


>>Also, it seems to me that you would want to check for signal_pending()
>>(a) just after the schedule_timeout(), and
>>(b) -after- testing the 'signals_allowed' variable  ;-)
> 
> 
> schedule() already checks for signals.

Well -- A signal won't be pending until after you call 
schedule_timeout() ;-)  A signal, particularly SIGINT, might even occur 
_during_ the schedule_timeout().

	Jeff



