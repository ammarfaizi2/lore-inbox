Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130271AbQLOS02>; Fri, 15 Dec 2000 13:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130338AbQLOS0S>; Fri, 15 Dec 2000 13:26:18 -0500
Received: from mailb.telia.com ([194.22.194.6]:54795 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S130271AbQLOS0B>;
	Fri, 15 Dec 2000 13:26:01 -0500
From: Anders Torger <torger@ludd.luth.se>
Reply-To: torger@ludd.luth.se
Organization: -
To: linux-kernel@vger.kernel.org
Subject: mmap'ing IO memory on i386
Date: Fri, 15 Dec 2000 18:52:20 +0100
X-Mailer: KMail [version 1.1.61]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00121518522008.21281@paganini>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm writing an ALSA sound card driver, for a card that does not support DMA, 
thus the CPU need to do the copying to and from the onboard buffer. ALSA 
allows for optional mmap'd access, that is accessing the in memory dma buffer 
directly from user space. However, for this card that does not support DMA, 
it would be best to mmap its IO memory directly, this way I get rid of a copy 
in the interrupt handler to an intermediate kernel buffer. This should be 
possible on the i386 as far as I know.

I use a 2.2.14 kernel, and ioremap (also tested ioremap_nocache) to relocate 
the IO memory. In kernel space it works fine to access the ioremap'd area 
just like any other kernel buffer. However, when the ioremap'd area is mmap'd 
from user space, problems occur. In user space: when the memory is read, all 
bytes are always 0xFF, and when written to, nothing happens (the memory being 
on the sound card is unchanged).

I have two questions: (1) why is this happening? (2) is it possible to make 
it work?

Please reply to my address directly, since I'm not on the mailing list.

/Anders Torger
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
