Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270630AbRHSQ7f>; Sun, 19 Aug 2001 12:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270634AbRHSQ7Y>; Sun, 19 Aug 2001 12:59:24 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:36191
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S270630AbRHSQ7M>; Sun, 19 Aug 2001 12:59:12 -0400
Message-ID: <3B7FF06A.4090606@fugmann.dhs.org>
Date: Sun, 19 Aug 2001 18:59:22 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: chuckw@ieee.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for comments on Bottom-Half/Tasklet/SoftIRQ
In-Reply-To: <20010818231704.A2388@ieee.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


chuckw@ieee.org wrote:
> Greetings,
> 	I was reading the unreliable guide to kernel hacking and was looking for
> a little clarification on something.  2 Bottom halves cannot run at the same
> time, why? 

Per linux definition of bottom halves, there can only run one buttom 
half at one system wide. But dont use those - They are old and waists 
resources. Try tasklets instead. Multible tasklets can run in parrallel 
(but not the same tasklet)

> 	Also, could someone give me an example of a service which is a bottom half/
> tasklet/SoftIRQ?
Simple.

Imagine some hardware that generates interrupts.
Now we want to write a driver that keeps the hardware busy, so we 
implement a top half handler (IRQ-handler), and let it retrieve som data 
from the hardware. Instead of processing it right away, we shedule a 
tasklet to do that job. This way we can handle more interrupts/sec from 
the card, and the hardware is kept busy.


To summerize.
Buttom halves are the strictest (only one at a time.)
Takslets can run in parralel, but still no need to worry about reentrant 
code.
SoftIrq give no guarrentee at all, and should be used with great care
(code need to be reentrant).

Also try to readLinux device drivers by  A. Rubini:
http://www.xml.com/ldd/chapter/book/index.html

Hope it helps.
Anders Fugmann

> 
> Thanks in advance,
> Chuck
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


