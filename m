Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbUCTKhy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263342AbUCTKhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:37:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6295 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263339AbUCTKhv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:37:51 -0500
Message-ID: <405C1EF2.9070201@pobox.com>
Date: Sat, 20 Mar 2004 05:37:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de> <200403200140.59543.bzolnier@elka.pw.edu.pl> <405B936C.50200@pobox.com> <200403200224.14055.bzolnier@elka.pw.edu.pl> <20040320095820.GC2711@suse.de> <405C191F.3020501@pobox.com> <20040320101929.GF2711@suse.de>
In-Reply-To: <20040320101929.GF2711@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sat, Mar 20 2004, Jeff Garzik wrote:
> 
>>Jens Axboe wrote:
>>
>>>I agree with Bart, it's usually never that clear. Quit harping the
>>>stupid LG issue, they did something brain dead in the firmware and I
>>>almost have to say that they got what they deserved for doing something
>>>as _stupid_ as that.
>>
>>I use it because it's an excellent illustration of what happens when you 
>>ignore the spec.
> 
> 
> Really, I think it's a much better demonstration of exactly how stupid
> hardware developers are at times...

No argument.  But their behavior, however awful, _was_ reported in 
places where a spec-driven driver would have noticed... :)


>>>Jeff, it's wonderful to think that you can always rely on checking spec
>>>bits, but in reality it never really 'just works out' for any given set
>>>of hardware.
>>
>>"just issue it and hope" is not a reasonable plan, IMO.
> 
> 
> I agree with that as well. I just didn't agree with your rosy idea of
> thinking everything would always work if you just check the bits
> according to spec.

Everything _will_ always work, if you check the bits according to spec. 
     Not reporting the flush-cache feature bit, when it really the 
opcode exists, isn't a spec violation.  The opposite is, and I haven't 
heard of any such drives :)

AFAICS:
* for ATA versions where flush-cache is optional, you must check the 
bit.  otherwise, issuing flush-cache would be very unwise.
* for ATA versions where flush-cache is mandatory...  the argument can 
be made that issuing a flush-cache in the absence of the bit isn't a bad 
thing.  I'm not sure I agree with that, but I'm willing to be convinced.

"just check the bits" always works because it is the conservative 
choice...  but it can lead to suboptimal (but valid!) behavior by 
ignoring some devices' flush-cache capability.

If it's only a few drives out there that misreport their flush-cache 
bit, then who cares --> just more broken hardware, that we won't issue a 
flush-cache on.  If it's a lot of drives, that changes things...

	Jeff


