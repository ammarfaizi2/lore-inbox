Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291005AbSBLMph>; Tue, 12 Feb 2002 07:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291007AbSBLMp0>; Tue, 12 Feb 2002 07:45:26 -0500
Received: from [195.63.194.11] ([195.63.194.11]:61708 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291005AbSBLMpX>; Tue, 12 Feb 2002 07:45:23 -0500
Message-ID: <3C690E56.3070606@evision-ventures.com>
Date: Tue, 12 Feb 2002 13:45:10 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <20020212132846.A7966@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>>The first does control an array of values, which doesn't make sense in 
>>first place. I.e. changing it doesn't
>>change ANY behaviour of the kernel.
>>
>
>Actually HFS uses it ...
>
Please note that the use in HFS is inappriopriate. It's supposed to 
optimize the
read throughput there, which is something that shouldn't be done at the 
fs setup
layer at all. The usage of read_ahead there can be just removed and
everything should be fine (modulo the fact that in current state the HFS 
filesystem code
is just non-working obsolete code garbage anyway ;-).

>>The second of them is trying to control a file-system level constant
>>inside the actual block device driver. This is a blatant violation of
>>the layering principle in software design, and should go as soon as
>>possible.
>>
>
>Yes. But still block device drivers allocate the array ...
>

Well if we do:

find ./ -name "*.c" -exec grep max_readahead /dev/null {} \;


One can already easly see that apart from ide, md, and acorn drivers 
this has been already abstracted
away one level up at the block device handling as well. My suspiction is 
that there is now already
*double* initialization of the sub-slices of this array there. Anyway 
ide should be adapted here to the
same way as it's done now for scsi.

Will you look after this or should me? (I can't until afternoon, becouse 
I'm at my "true live" job now
and have other things to do...)


