Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277533AbRJESIM>; Fri, 5 Oct 2001 14:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277534AbRJESID>; Fri, 5 Oct 2001 14:08:03 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:40975 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S277533AbRJESHs>; Fri, 5 Oct 2001 14:07:48 -0400
Message-ID: <3BBDF6BC.5000300@zk3.dec.com>
Date: Fri, 05 Oct 2001 14:06:52 -0400
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: paulus@samba.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        trini@kernel.crashing.org, benh@kernel.crashing.org
Subject: Re: [PATCH] change name of rep_nop
In-Reply-To: <E15pW6U-0006Xx-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Here is a patch that addresses those three issues.  It adds an empty
>>definition of cpu_relax for all architectures except x86 (for x86 it
>>is defined to be rep_nop), and it changes smp_init to use a barrier
>>instead of making wait_init_idle be volatile.
>>
>>
> 
> Looks good to me


You also need to move the call to smp_boot_cpus() below the 
clear_bit(...) line in smp_init().  Without it, my Wildfire doesn't get 
past the while(wait_init_idle) loop - seems all of the CPUs have already 
done their work before the mask is set.  Besides, it's the right place 
for it anyway.  I'd generate a patch, but my system is bogged down in a 
benchmark for the next couple of hours.  If someone says so, I'll 
generate the patch after that...

  - Pete


