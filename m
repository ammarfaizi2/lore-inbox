Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288338AbSBKLtA>; Mon, 11 Feb 2002 06:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288158AbSBKLsk>; Mon, 11 Feb 2002 06:48:40 -0500
Received: from adsl-63-194-232-126.dsl.lsan03.pacbell.net ([63.194.232.126]:37898
	"HELO alpha.dyndns.org") by vger.kernel.org with SMTP
	id <S288338AbSBKLsg>; Mon, 11 Feb 2002 06:48:36 -0500
Message-ID: <3C67B1D6.5020408@alpha.dyndns.org>
Date: Mon, 11 Feb 2002 03:58:14 -0800
From: Mark McClelland <mark@alpha.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: video4linux-list@redhat.com
CC: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: [V4L] [PATCH/RFC] videodev.[ch] redesign
In-Reply-To: <20020209194602.A23061@bytesex.org> <3C65EFF4.2000906@alpha.dyndns.org> <20020210101130.A28225@bytesex.org> <3C666D98.70600@alpha.dyndns.org> <20020211105534.A4745@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:

>On Sun, Feb 10, 2002 at 04:54:48AM -0800, Mark McClelland wrote:
>
>>BTW, is there any chance for vmalloc() and pals to be moved to 
>>videodev.c, or something higher-up?
>>
>
>What do you mean exactly?  bttv's memory management code, which has
>been copied to various places, and which is now broken in 2.5.x due
>to virt_to_bus() being gone finally?
>

Sorry, I meant to type rvmalloc().

Many drivers (eg. USB webcam drivers), don't need virt_to_bus(). They 
only need a way to allocate reserved pages that they can safely do 
remap_page_range() on, for mmap().

>Some of this is work-in-progress.  I'm talking to Dave to put some
>helper functions to handle DMA to vmalloced memory blocks to some
>sensible place within the kernel.  If someone wants to have a look
>(not final yet): http://bytesex.org/patches/15_pci-2.4.18-pre8.diff
>

Thanks, that's exactly what I was looking for. pci_vmalloc_to_page() 
should satisfy all of the USB drivers, if they override 
vma->vm_ops->nopage().

-- 
Mark McClelland
mmcclell@bigfoot.com



