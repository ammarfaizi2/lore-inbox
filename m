Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288283AbSAHUYP>; Tue, 8 Jan 2002 15:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288287AbSAHUYG>; Tue, 8 Jan 2002 15:24:06 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:8833 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S288283AbSAHUYA>; Tue, 8 Jan 2002 15:24:00 -0500
Message-ID: <3C3B555E.2000005@allegientsystems.com>
Date: Tue, 08 Jan 2002 15:23:58 -0500
From: Nathan Bryant <nbryant@allegientsystems.com>
Organization: Allegient Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@allegientsystems.com>
CC: Doug Ledford <dledford@redhat.com>,
        Thomas Gschwind <tom@infosys.tuwien.ac.at>,
        linux-kernel@vger.kernel.org
Subject: Re: i810_audio
In-Reply-To: <20020105031329.B6158@infosys.tuwien.ac.at> <3C3A2B5D.8070707@allegientsystems.com> <3C3A301A.2050501@redhat.com> <3C3AA6F9.5090407@redhat.com> <3C3B501D.7050508@allegientsystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> 1) Is the LVI interrupt supposed to arrive when the chip *starts* 
> playing the last buffer?
> 2) Does SiS actually do it this way?
>
> If your theory on why the registers are spinning is correct, and if we 
> receive the LVI interrupt with too much latency, your code will still 
> deadlock, Doug. (The LVI interrupt handler calls update_ptr first 
> thing, which calls get_dma_address.) Furthermore, if this turns out to 
> be the case, the LVI IRQ handler uses dmabuf->count to determine 
> whether to call stop_dac, and needs to call update_ptr to update 
> dmabuf->count... so an explicit stop_dac might be needed elsewhere.
>
> Even if the LVI interrupt comes at the beginning of the buffer, those 
> 2048 bytes will play in 10.67 ms. Can we really guarantee that kind of 
> latency?


Add to this, if SiS isn't sending DCH, and LVI arrives at the beginning 
of the last buffer, count is still > 0, so we don't call stop_dac. And 
we're right back where we started.

