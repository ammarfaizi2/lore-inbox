Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbUJ1Dlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbUJ1Dlh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 23:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbUJ1Dle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 23:41:34 -0400
Received: from delta.ece.northwestern.edu ([129.105.5.125]:14469 "EHLO
	delta.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S262741AbUJ1Dkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 23:40:43 -0400
Message-ID: <41806A99.7060807@ece.northwestern.edu>
Date: Wed, 27 Oct 2004 22:42:17 -0500
From: Lei Yang <lya755@ece.northwestern.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bijoy Thomas <bijoyjth@gwu.edu>
Cc: linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@nl.linux.org>
Subject: Re: set blksize of block device
References: <55dddd455db643.55db64355dddd4@gwu.edu>
In-Reply-To: <55dddd455db643.55db64355dddd4@gwu.edu>
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your reply!

The problem is, I want to do all these stuff in kernel space. More 
specifically,  I want to use them in a newbie kernel module. In this 
module, I wanna do something with a raw block device (with no 
filesystem).  Below are some more questions regarding to your comments.  
Really appreciate your help!

Lei


Bijoy Thomas wrote:

>You set the blocksize for block device when you format it. For e.g, when you format a device with mkfs.ext2, you specify what block size you wish to use. This gets recorded in the superblock of the device. You can see what blocksize a device is using by running the tune2fs command with the deivce as an argument.
>  
>
What if I don'w want to format the device with a filesystem?

>Reading and writing a block on a device in userspace is as simple as opening the device, lseeking to the block in question and doing a read or write. Keep in mind that the filesystem blocksize has nothing to do with the blocksize for the device. The sector size for most block devices is 512 bytes. This means that the unit in which we can communicate with the device is 512bytes. However, the filesystem driver will have it own unit i.e, the blocksize. Hence, usually many sectors will fall in a block. The blocks are held in the buffer cache.The filesystem block size should be a power of 2 and less than the pagesize.
>
>In kernel space, reads and writes to blocks on the device are done through the function bread and block_read. Both functions are used to read blocks from a device. If you modify a block, you can set the buffer as dirty and the kernel will later write it to disk.
>  
>
Isn't there a bwrite similar to bread?

>Regards,
>Bijoy.
>
>
>----- Original Message -----
>From: Lei Yang <lya755@ece.northwestern.edu>
>Date: Wednesday, October 27, 2004 10:25 pm
>Subject: Re: set blksize of block device
>
>  
>
>>Or in other words, is there generic routines for block devices such 
>>that 
>>we could:
>>
>>get (set) block size of a block device;
>>read an existing block (e.g. block 4);
>>write an existing block (e.g. block 5);
>>
>>Please help!!!!
>>
>>TIA
>>Lei
>>    
>>


