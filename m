Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbUB0K12 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUB0K12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:27:28 -0500
Received: from viefep12-int.chello.at ([213.46.255.25]:33333 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id S261747AbUB0KYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:24:19 -0500
Message-ID: <403F1ACC.5060804@freemail.hu>
Date: Fri, 27 Feb 2004 11:24:12 +0100
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu; rv:1.6) Gecko/20040115
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-mmX locks up reading scratched SVCD
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Feb 27 2004, Boszormenyi Zoltan wrote:
>> Hi,
>> 
>> I have a scratched SVCD and reading it back with vcdimager-0.7.14
>> locks up the machine completely. I tried it with kernels is 2.6.3-mm[1234].
>> I have not tried older kernel.
>> 
>> A flawless SVCD can be read back. I also tried reading back a bad 
>> overburned SVCD,
>> (cdrdao-1.1.8 reported error at the end) and it also locked up the machine.
>> I fixated this disk, tried reading back -> lockup.
>> Two IDE CD-RWs produce the same effect: LG 52/24/52 and Sony 48/24/48.
>> Something must be bad in the ide-cd driver, it should at least report an
>> error instead of locking up.
> 
> With damaged media, the problem is often the hardware locking up. In
> that case there's really not much the kernel can do. That said, does the
> keyboard LED's blink when the machine hangs?
 >
 > --
 > Jens Axboe

No, they do not. Numlock is not responding. The CD-RW drives were not locked up.
I already experienced drive lockups earlier, the eject button does not respond,
the LED on one of the drives changes to red (instead of green -> normal operation
or orange -> writing)

In the meantime I was busy compiling libcddb-0.9.4, libcdio-0.66
and vcdimager-0.7.20. I am trying to read the CDs back with it,
the changelog mentions memleak fixes.

(several minutes later) Hm, it finished now, the overburned
SVCD is read back, it's about 20MB shorter than the original mpeg.
I got this error:

$ vcdxrip -C /dev/cdrom -p -v
!ASSERT: file mpeg.c: line 509 (_analyze_pes_header): assertion failed: (vcd_bitvec_peek_bits (buf, pos2, 8) == 0x0f)
Terminated

Somehow I expected that. So vcdimager-0.7.14 is faulty, the machine
lockup was in fact an OOM. Sorry for the noise.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.
