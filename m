Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161188AbVKRUdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbVKRUdO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbVKRUdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:33:06 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:44006 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161183AbVKRUcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:32:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GBtqX+WGKdTM5Cjp72Nz0kAV0xQj+qhZIXvZv66aVzMzZPImMpDiZMowQRkcrfky5MgptUWnAQiChDolMdKILfyjqetCdwW3eBiEwPhf1eEkMw+kCNQDpJTuiPQUmBKoscTfh3I4dX3C8lkYmxBgF9vSXIceYcGi97uU4fEL994=
Message-ID: <437E3A5D.1090006@gmail.com>
Date: Sat, 19 Nov 2005 04:32:29 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: X and intelfb fight over videomode
References: <20051117000144.GA29144@hardeman.nu> <437BD8D9.9030904@gmail.com> <20051117014558.GA30088@hardeman.nu> <437C0BF2.4010400@gmail.com> <20051117234510.GA3854@hardeman.nu> <437D298A.7070203@gmail.com> <20051118183607.GA3866@hardeman.nu>
In-Reply-To: <20051118183607.GA3866@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman wrote:
> On Fri, Nov 18, 2005 at 09:08:26AM +0800, Antonino A. Daplas wrote:
>> David Härdeman wrote:
>>> First time I switch from X to VC:
>>> intelfb: Changing the video mode is not supported.
>>> intelfb: ring buffer : space: 6024 wanted 65472
>>> intelfb: lockup - turning off hardware acceleration
>>>
>>
>> Well, intelfb is at the mercy of X if it's in 'fixed mode'.
>>
>>> Other suggestions?
>>
>> I'm adding Sylvain, the intelfb maintainer, to the CC list.
>>
>> How about this one?  It also resets the ringbuffer before re-initializing
>> it again.
> 
> That made no change at all unfortunately, the messages are exactly the
> same as before...

That's the limit to what I can do (I don't have the hardware) and let's just
wait for the maintainer to respond.

For now, you can eliminate that message by turning acceleration off.

video=intelfb:accel:0

Another solution is to disable direct rendering, but I don't think you want
that.

Tony

PS: I saw this problem before with i810fb, and this is because the i810 driver
of X and i810fb shared the same ringbuffer.  But the i810 chipset has 2 ringbuffers,
so I just made i810fb use the ringbuffer that is not touched by X/DRI. (I don't
know the status now since I don't have this chipset anymore).  That is one 
solution.
