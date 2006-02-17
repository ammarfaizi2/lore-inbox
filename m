Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWBQV1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWBQV1n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWBQV1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:27:42 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:19115 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1750792AbWBQV1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:27:41 -0500
Message-ID: <43F64D22.7080607@wolfmountaingroup.com>
Date: Fri, 17 Feb 2006 15:24:34 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Phillip Susi <psusi@cfl.rr.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: C/H/S from user space
References: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com> <43F617FA.2030609@wolfmountaingroup.com> <Pine.LNX.4.61.0602171452520.4290@chaos.analogic.com> <43F63A59.6090401@cfl.rr.com> <Pine.LNX.4.61.0602171609480.4549@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602171609480.4549@chaos.analogic.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



And a very useful translation table for coversion to 63 head models.

Jeff

// Use the Phoenix method of drive translation
// to translate drive geometry for those drives
// that exceed 1024 cylinders in size.
//
// Phoenix Geometry Translation Table
// -----------------------------------
//
// Phys Cylinders Phys Heads Trans Cyl Trans Heads Max
// --------------------------------------------------------
// 1 <C<= 1024 1 <H<= 16 C = C H = H 528 MB
// 1024 <C<= 2048 1 <H<= 16 C = C/2 H = H*2 1.0 GB
// 2048 <C<= 4096 1 <H<= 16 C = C/4 H = H*4 2.1 GB
// 4096 <C<= 8192 1 <H<= 16 C = C/8 H = H*8 4.2 GB
// 8192 <C<= 16384 1 <H<= 16 C = C/16 H = H*16 8.4 GB
// 16384 <C<= 32768 1 <H<= 8 C = C/32 H = H*32 8.4 GB
// 32768 <C<= 65536 1 <H<= 4 C = C/64 H = H*64 8.4 GB
//
// LBA Assisted Translation Table
// ------------------------------
//
// (NOTE: The method below is an alternate method for
// translating large drives that does not place any limits
// on reported drive geometry. It has the disadvantage
// of always assuming 63 Sectors Per Track.)
//
// Range Sectors Heads Cylinders
// -----------------------------------------------------
// 1 MB <X< 528 MB 63 16 X/(63 * 16 * 512)
// 528 MB <X< 1.0 GB 63 32 X/(63 * 32 * 512)
// 1.0 GB <X< 2.1 GB 63 64 X/(63 * 64 * 512)
// 2.1 GB <X< 4.2 GB 63 128 X/(63 * 128 * 512)
// 4.2 GB <X< 8.4 GB 63 255 X/(63 * 255 * 512)
//

// Adjust cylinder and head dimensions until this drive
// presents a geometry with a cylinder count


linux-os (Dick Johnson) wrote:

>On Fri, 17 Feb 2006, Phillip Susi wrote:
>
>  
>
>>linux-os (Dick Johnson) wrote:
>>    
>>
>>>Yes, it's a very good model, in fact what I've been talking about.
>>>However, several people who refused to read or understand, insisted
>>>upon obtaining the exact same C/H/S that the machine claimed to
>>>use when it was booted.
>>>
>>>      
>>>
>>That's because if you don't use the same geometry that the bios reports
>>when calculating the CHS addresses of the sectors you intend to load,
>>you won't be requesting the right sectors from int 13.
>>    
>>
>   ^^^____
>
>Who is YOU??? I would certainly be requesting the right sectors
>if I (or anybody else who knows what they are doing), wrote
>the boot code. The boot loader knows about OFFSETS into the
>device where it's going to get its data, which eventually
>becomes a whole operating system. It doesn't give a *uck about
>anything else. There is a table of OFFSETS, obtained from
>the file-system, of the correct pieces of files (since there
>will not be a file-system until the machine is booted). This
>table of offsets needs to be read somewhere in the first 63
>sectors (32256 bytes). These offsets contain the junk to
>be loaded into memory.
>
>The boot-code, the code that executes in the 16-bit environment,
>converts those offsets (after getting data from the DPB) into
>the respective junk to put into the registers as I explained
>over and over and over again.
>
>You refuse to learn. Please go away.
>
>[SNIPPED...]
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.6.15.4 on an i686 machine (5589.53 BogoMips).
>Warning : 98.36% of all statistics are fiction.
>_
>
>
>****************************************************************
>The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
>
>Thank you.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

