Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbSJXS0J>; Thu, 24 Oct 2002 14:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265590AbSJXS0J>; Thu, 24 Oct 2002 14:26:09 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:31765 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265589AbSJXS0I>;
	Thu, 24 Oct 2002 14:26:08 -0400
Message-ID: <3DB83CC8.7070607@mvista.com>
Date: Thu, 24 Oct 2002 13:32:40 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: dipankar@gamebox.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release, version 5 - I think this one's ready
References: <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com> <20021024144632.GC32181@compsoc.man.ac.uk> <3DB81376.90403@mvista.com> <20021024171815.GA6920@compsoc.man.ac.uk> <3DB83156.5000402@mvista.com> <20021024180435.GB8915@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:

>On Thu, Oct 24, 2002 at 12:43:50PM -0500, Corey Minyard wrote:
>  
>
>>There's a comment in do_nmi() that says that the NMI is edge triggered. 
>>    
>>
>
>So there is. Darn. You could special case default_do_nmi, only printing
>out "Unknown NMI" iff the reason inb() check fails, /and/ no previous
>handlers set handled. Theoretically we have to take the cost of the
>inb() every time otherwise we can lose one of the NMISC-based things in
>default_do_nmi ... I can always see if this makes a noticable practical
>difference for oprofile under high interrupt load
>
>(I also need to be able to remove the NMI watchdog handler, but that's
>an oprofile-specific problem).
>
>Perhaps things will end being best to leave the current fast-path thing,
>but we should make sure that we've explored the possibilities of
>removing it first ;)
>
This also means that the current code is actually wrong, since the 
current code just returns at the first thing it finds.

I'll work on redoing this all in one list.

Do you know if nmi_shutdown in oprofile/nmi_int.c can be called from 
interrupt context?  Because nmi_release() can block, so I couldn't use 
it as-is if it ran in interrupt context.

-Corey


