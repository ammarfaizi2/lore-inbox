Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265681AbUFSBCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUFSBCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 21:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266746AbUFRT71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:59:27 -0400
Received: from crl-mail.crl.dec.com ([192.58.206.9]:30697 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S266614AbUFRTuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:50:24 -0400
Message-ID: <40D3471A.4020105@hp.com>
Date: Fri, 18 Jun 2004 15:48:42 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
CC: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org, greg@kroah.com,
       tony@atomide.com, david-b@pacbell.net, joshua@joshuawise.com
Subject: Re: DMA API issues
References: <20040618175902.778e616a.spyro@f2s.com> <20040618110721.B3851@home.com> <40D3356E.8040800@hp.com> <20040618122112.D3851@home.com>
In-Reply-To: <20040618122112.D3851@home.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-4.9, required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter wrote:

>On Fri, Jun 18, 2004 at 02:33:18PM -0400, Jamey Hicks wrote:
>  
>
>Yes, it can be cleaner, but it's not something I would say is
>completely broken with the DMA API.  It does provide a way to
>make your device specific implementation, regardless of whether
>it's managed ideally via a struct device pointer.  Migrating to
>dev->dma* sounds suspiciously like a 2.7ism.
>  
>
The DMA API is certainly not completely broken.  Except for page_to_dma 
needing struct device the interface could be implemented with per-device 
dma operation implementations.

>>described, but there is already a good start towards that support in 
>>2.6.  The other thing that might be needed is passing device to 
>>    
>>
>
>Where's that code?
>
>  
>
arch/arm/common/dmabounce.c

>>page_to_dma so that device specific dma addresses can be constructed.
>>    
>>
>
>A struct device argument to page_to_dma seems like a no brainer to be
>included.
> 
>  
>
>>Deepak Saxena wrote a pretty good summary as part if the discussion 
>>about this issue on the linux-arm-kernel mailing list:
>>
>>http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-June/022796.html
>>    
>>
>
>Ahh, ok.  Deepak and I have discussed this idea F2F on a several
>occassions, I recall he needed it for the small floating PCI window
>he has to manage on the IXP* ports.  It may help in some embedded
>PPC areas as well.
>
>  
>
>>I think I'm looking for something like the PARISC hppa_dma_ops but more 
>>generic:
>>  
>>http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-June/022813.html
>>    
>>
>
>I see that's somewhat like what David Brownell suggested before...a single
>pointer to a set of dma ops from struct device.  hppa_dma_ops translated
>into a generic dma_ops entity with fields corresponding to existing
>DMA API calls would be a good starting point. We can get rid of some
>address translation hacks in a lot of custom embedded PPC drivers
>with something like this.
>  
>
Yes, I think this would be generally useful.

Jamey


