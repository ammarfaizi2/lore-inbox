Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289987AbSBKSOI>; Mon, 11 Feb 2002 13:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289982AbSBKSN7>; Mon, 11 Feb 2002 13:13:59 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:30713 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S289973AbSBKSNu>; Mon, 11 Feb 2002 13:13:50 -0500
Message-ID: <3C6809C2.1030808@nyc.rr.com>
Date: Mon, 11 Feb 2002 13:13:22 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.4 Sound Driver Problem
In-Reply-To: <E16aKwN-0007Ro-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>>The sound_alloc_dmap() function in dmabuf.c must be changed from using 
>>>__get_free_pages() and virt_to_bus() -> pci_alloc_consistent().
>>>
>>What the hell are you talking about, I changed it long ago.
>>Linus uses ymfpci on his Crusoe Picturebook with no problems.
>>What is your kernel version?
>>
> 
> In the ymfpci case its not the sound_alloc_dmap (at least not in 2.4 but
> 2.5 might be out of date except in -dj). Its the use of virt_to_bus still
> rather than the handles returned from the pci api
> 
> 

I am looking at both 2.5.4 and 2.4.18-pre9.

In my copy of sound_alloc_dmap(), I see a direct call to 
__get_free_pages to allocate the buffer and a call to virt_to_bus.  I 
just thought that this could be cleared up by using pci_alloc_consistent 
(since this function will call __get_free_pages anyway and eliminates 
the need to use virt_to_bus).

Anyway, I'm not sure I understand this.  I know using the virt_to_bus is 
wrong, but why would we use __get_free_pages() here?  (This is not a 
rhetorical question, I honestly want to learn).

