Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317441AbSFCRv5>; Mon, 3 Jun 2002 13:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317442AbSFCRv4>; Mon, 3 Jun 2002 13:51:56 -0400
Received: from mx3.fuse.net ([216.68.1.123]:58008 "EHLO mta03.fuse.net")
	by vger.kernel.org with ESMTP id <S317441AbSFCRvy>;
	Mon, 3 Jun 2002 13:51:54 -0400
Message-ID: <3CFBACD2.4000904@fuse.net>
Date: Mon, 03 Jun 2002 13:52:18 -0400
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020520 Debian/1.0rc2-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Link order madness :-(
In-Reply-To: <200206031729.g53HTwTo002828@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Jean Tourrilhes <jt@bougret.hpl.hp.com> said:
>
>[...]
>
>  
>
>>	The problem is *not* the networking initialisation (I wish
>>people were *reading* my e-mails). The basic networking is initialised
>>early enough. The various networking stacks could be initialised
>>earlier, but I don't depend on them. Note that there might be a reason
>>to initialise networking after the file system, so to do that we might
>>need to insert a level between fs_initcall() and device_initcall().
>>    
>>
>
>If you insert enough levels, you are in another form of madness.
>
>There should be a way of saying "This must be initialized after this, and
>before that" (the "before that" might perhaps be taken care of by the
>"that" itself). Spiced with a few "barriers": "Networking inited", etc.
>>From there the build system should figure it out by itself. tsort(1) on an
>appropiate bunch of descriptive one-liners (extracted from the sources?)
>should give the right initialization order, or error out.
>
>Yes, I know this has been proposed before and been thrown out (for no good
>reason, AFAICS)
>  
>

Throwing in my $.02.  /etc/rc.d/* seems to have 100 levels (00 through 
99) and it (so far) appears to be pretty sane, from my perspective. 
 While 100 levels are perhaps too many, would it be more reasonable to 
have, say _early_initcall, _initcall, and _late_initcall for each of the 
categories (arch, fs, device, etc.)?  This would allow more granularity 
within levels so things needn't ever be improperly promoted out of their 
rightly-named level.  Prolly not, just thought I'd ask.

--Nathan


