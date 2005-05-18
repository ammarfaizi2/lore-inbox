Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVERWVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVERWVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVERWVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:21:20 -0400
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:4279 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S262396AbVERWTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:19:04 -0400
Message-ID: <428BBEED.6090608@enterprise.bidmc.harvard.edu>
Date: Wed, 18 May 2005 18:17:17 -0400
From: Kris Karas <ktk@enterprise.bidmc.harvard.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Greg Stark <gsstark@mit.edu>
Subject: Re: Problem report: 2.6.12-rc4 ps2 keyboard being misdetected as
 /dev/input/mouse0
References: <87zmuveoty.fsf@stark.xeocode.com>	 <200505160036.30628.dtor_core@ameritech.net>	 <4289682B.8060403@enterprise.bidmc.harvard.edu>	 <200505162358.15099.dtor_core@ameritech.net>	 <20050518111322.GC1952@elf.ucw.cz> <d120d500050518063926943e91@mail.gmail.com>
In-Reply-To: <d120d500050518063926943e91@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>On 5/18/05, Pavel Machek <pavel@ucw.cz> wrote:
>  
>
>>>Although... maybe the patch below is not too ugly.
>>>      
>>>
>>Looks pretty much okay to me...
>>    
>>
>
>Does it work for you? If so I'll send it to Andrew to simmer in -mm.
>  
>

FWIW, I've tested the patch and it seems to be working just fine.  Thanks!

There is one exception, though it does not appear to be related to the 
mouse code or the patch, as far as I can tell.   Pressing or releasing 
the right-windows key sends a blank event to GPM (as reported by 'mev') 
causing the mouse cursor to reappear.  If I use "showkey -s" to tell me 
the scancode, nothing happens.  The key is evidently bound in the kernel 
table, else I'd see the obligatory PRINTK encouraging me to bind it.  So 
something is intercepting the key and sending it to GPM.   
Experimentally, it appears as if the key press is delivered only if it 
has not been pressed for roughly 3 seconds (256 Jiffies???).

Kris
