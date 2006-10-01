Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751828AbWJAFUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbWJAFUi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 01:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWJAFUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 01:20:38 -0400
Received: from smtpout.mac.com ([17.250.248.186]:36852 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751384AbWJAFUh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 01:20:37 -0400
In-Reply-To: <20060930215343.548f5cd9.akpm@osdl.org>
References: <200609150901.33644.ismail@pardus.org.tr> <200609281003.28644.ismail@pardus.org.tr> <1159427179.3309.183.camel@pmac.infradead.org> <200609281030.26640.ismail@pardus.org.tr> <20060930215343.548f5cd9.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <110413A1-7699-4DDB-9997-C3DA9E9DDB46@mac.com>
Cc: Ismail Donmez <ismail@pardus.org.tr>,
       David Woodhouse <dwmw2@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, mchehab@infradead.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: __STRICT_ANSI__ checks in headers
Date: Sun, 1 Oct 2006 01:20:15 -0400
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 01, 2006, at 00:53:43, Andrew Morton wrote:
> On Thu, 28 Sep 2006 10:30:25 +0300
> Ismail Donmez <ismail@pardus.org.tr> wrote:
>
>> 28 Eyl 2006 Per 10:06 tarihinde, David Woodhouse şunları  
>> yazmıştı:
>>> On Thu, 2006-09-28 at 10:03 +0300, Ismail Donmez wrote:
>>> David, is this ok? It would be good to apply this for 2.6.19 so  
>>> all of KDE would compile ( all of the parts I tested ) with  
>>> kernel-headers.
>>>
>>> Looks good to me.
>>
>> Andrew, now that David gave his blessing , can you push this for  
>> 2.6.19?
>>
>
> Bisection shows that this patch causes these depmod warnings:
>
> WARNING: "snd_card_disconnect" [sound/usb/usx2y/snd-usb-usx2y.ko]  
> has no CRC!
> [etc]
>
> I don't know why that would happen.
>
> From: Ismail Donmez <ismail@pardus.org.tr>
>
> __STRICT_ANSI__ usage in types.h header results in compile errors  
> for some userspace packages[1] when used with gcc -ansi flag.  With  
> the suggestion of Kyle Moffett I replace strict ansi checks with  
> __extension__ to tell gcc not to error or warn on gcc extensions.   
> Compile tested on x86 with 2.6.18.

Best guess:  Depmod does some kind of funny type-based expansion and  
hashing of the symbols which doesn't understand the "__extension__"  
keyword.  Probably the simplest thing to do is to add "- 
D__extension__=" to the depmod preprocessing flags.  Alternatively  
you could teach depmod to completely ignore the __extension__ keyword  
when it shows up in the sources, but the former seems like it would  
be much simpler.

Just thinking about it we probably also need to educate sparse about  
__extension__ too.  Perhaps somebody could also add an sparse flag to  
make it warn about nonportable constructs in exported header files.

I'd submit a patch but my knowledge of kernel makefiles and depmod is  
somewhere between zero and none, exclusive.

Cheers,
Kyle Moffett

