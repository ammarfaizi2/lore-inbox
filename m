Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281264AbRKESDz>; Mon, 5 Nov 2001 13:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281263AbRKESDg>; Mon, 5 Nov 2001 13:03:36 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:16908 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S281265AbRKESDY>;
	Mon, 5 Nov 2001 13:03:24 -0500
Message-ID: <3BE6D469.8000407@epfl.ch>
Date: Mon, 05 Nov 2001 19:03:21 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]agp for i820 chipset
In-Reply-To: <3BE6B50A.5010806@epfl.ch> <1004976089.934.12.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hey, very good.  I don't have an i820 but I am working with the AGPGART
> driver so I can say everything looks good.  I am actually working on a
> rewrite; I find it ridiculous we need all these specific 820 functions. 
> I am have a design where we load a lookup table, index by the enum, with
> the register information and then a generic function can load in the
> right value.  I really working on cleaning the cruft up ...


This would be great. This source _does_ need cleanup. Since I saw taht 
everyone did copy all the functions I just did the same :-)


> I do have two comments, though.  I would suggest if you don't hear
> anything negative and the patch works for you to go ahead and send it to
> Alan and Linus, although you should make sure it is diffed against their
> newest trees.
> 


I sent the patch to linux-kernel, but do you think I have to send it 
personnally to Alan & Linus ?


> 
>>@@ -200,6 +203,9 @@
>> #ifndef PCI_DEVICE_ID_INTEL_810_1
>> #define PCI_DEVICE_ID_INTEL_810_1       0x7121
>> #endif
>>+#ifndef PCI_DEVICE_ID_INTEL_820_1
>>+#define PCI_DEVICE_ID_INTEL_820_1       0x250f
>>+#endif
>>
> 
> I'm not too sure why you need this.  I see other chipsets have their
> device 0:01 defined but I can't reason why.  When I add AGP drivers I
> never add it.  If you remove it, I think you will find everything still
> works.
> 


Damn ! You're right :-). The first entry is needed, because the i810 
chipset uses the secondary device (at least this is what is written in 
the code. see the 'agp_find_supported_device' routine. I remember this 
is needed for on-board chips. Does that make any sense :-) ? ), but the 
i820 related one is useless (afaik).



> 
> You can just use intel_generic_fetch_size or even one of the
> i840-specific or whatever versions, here.  Note you don't use anything
> specific to the i820, so reduce the footprint and ditch it.
> 


The reason for rewriting this function is that, according to the Intel specs, 

the APSIZE register is 8bits long (at least for the i820)! The generic function reads 

16 bits, so who knows what will be in the neighbouting register ? I guess it was 

working by accident, but if you have an argument for sticking to the generic 'fetch_size'

I am all ready to replace my part by the generic one :-)

I have to leave by now, I'll check my e-mail tonight, but it is

likely that I won't make any patch before tomorrow :-(

Best regards.

-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)
Office:  ELE 237
Phone:   +41 - 21 - 693 36 32 (Office) or 46 21 (LTS lab)
Fax:     +41 - 21 - 693 76 00

