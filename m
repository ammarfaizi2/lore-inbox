Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318047AbSHAWP0>; Thu, 1 Aug 2002 18:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSHAWP0>; Thu, 1 Aug 2002 18:15:26 -0400
Received: from [195.63.194.11] ([195.63.194.11]:13326 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318047AbSHAWPZ>; Thu, 1 Aug 2002 18:15:25 -0400
Message-ID: <3D49B29D.1090702@evision.ag>
Date: Fri, 02 Aug 2002 00:13:49 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: viro@math.psu.edu, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: IDE from current bk tree, UDMA and two channels...
References: <C94E6D2807@vcnet.vc.cvut.cz> <20020801220031.GA1756@vana.vc.cvut.cz>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Petr Vandrovec napisa?:
> On Thu, Aug 01, 2002 at 07:07:21PM +0200, Petr Vandrovec wrote:
> 
>>On 31 Jul 02 at 22:01, Marcin Dalecki wrote:
>>
>>>Well OK this was my next idea, but apparently you already did the
>>>experient on your own. Thanks for the result. I'm still scratching my
>>>head and I have already observed this before myself.
>>>It's always funny to see what happens when one stops a driver
>>>from deliberately disabling IRQs for eons of jiffies :-).
>>
>>I currently suspect IRQ handling changes, but maybe someone has
>>better idea? Also, I cannot reproduce problem with Seagate UDMA66
>>drive switched to UDMA33 mode, so it looks like that problem is 
>>timming/firmware (Toshiba MK6409MAV) dependent.
> 
> 
> I'd like to apologize to Ingo, his changes were completely innocent.
> Problem was triggered by Al's 'block device size cleanups' (currently
> cset 1.403.160.5 on bkbits).
> 
> Before this change, my system was using 4KB block size when reading
> from /dev/hdc1, because of blk_size[][] (which is in 1kB units) of this 
> partition was multiple of 2, and so i_size % 4096 was 0.  But after
> Al's change partition size is read from gendisk, and not from blk_size,
> and gendisk partition size is in 512 bytes units: and, as you can
> probably guess, now my partition had i_size % 4096 == 512, and so only
> 512 byte block size was choosen. And with 512 bytes block size my
> harddisk refuses to cooperate.
> 
> I was trying to find reason in code, why 512 byte block size should
> not work, but I was not able to reveal any. Maybe I/O gurus here
> will know?

Petr. First - I wish to express my respect (for whatever it's
worth). Once again you are fscking sharp and up the point in problem
analysis.

For what few things I know about the situation is that the SATA
people are having great problems with the mediocre physical sector size 
and they are pushing hard toward bigger sector
sizes. This may explain a bit why there is a propability why one
should be awake in this area.

Would you mind sending me hdparm -i /dev/hdx and hdparm -I /dev/hdx
for documentation purposes? The host controller chip could be the
one to blame as well.

I fear the need for jet another black list.

