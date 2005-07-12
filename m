Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVGLRUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVGLRUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVGLRUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:20:05 -0400
Received: from kirby.webscope.com ([204.141.84.57]:48103 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S261291AbVGLRUC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:20:02 -0400
Message-ID: <42D3FBA4.3050501@m1k.net>
Date: Tue, 12 Jul 2005 13:19:32 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: [PATCH -rc2-mm2] BUG FIX - v4l broken hybrid dvb inclusion
References: <42D3DC5A.3010807@m1k.net> <200507122107.51907.adobriyan@gmail.com>
In-Reply-To: <200507122107.51907.adobriyan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:

>On Tuesday 12 July 2005 19:06, Michael Krufky wrote:
>  
>
>>v4l-saa7134-hybrid-dvb.patch
>>v4l-cx88-update.patch
>>
>>The specific change that caused this problem is:
>>
>>- Let Kconfig decide whether to include frontend-specific code.
>>
>>I had tested this change against 2.6.13-rc2-mm1, and it worked perfectly as
>>expected, but it caused problems in today's 2.6.13-rc2-mm2 release.  For
>>some reason, the symbols don't get set properly.
>>    
>>
>What symbols? What error messages do you see?
>
Alexey-

Maybe symbols was the wrong terminology... What I meant was the 
CONFIG_DVB_LGDT3302 , etc flags

Previous patch removed the #define's that you see below... This should 
have worked, since these should be set instead from kconfig, but it 
didn't work as expected (even though the modules ARE selected by 
kconfig), and the #ifdef's return false.... (I don't know why it worked 
in my test against 2.6.13-rc2-mm1, but it doesn't work in -mm2, and it 
must be fixed) Breaks all hybrid v4l/dvb boards.

>>--- linux-2.6.13-rc2-mm2.orig/drivers/media/video/cx88/cx88-dvb.c
>>+++ linux/drivers/media/video/cx88/cx88-dvb.c
>>    
>>
>>+#define CONFIG_DVB_MT352 1
>>+#define CONFIG_DVB_CX22702 1
>>+#define CONFIG_DVB_OR51132 1
>>+#define CONFIG_DVB_LGDT3302 1
>>    
>>
>>--- linux-2.6.13-rc2-mm2.orig/drivers/media/video/saa7134/saa7134-dvb.c
>>+++ linux/drivers/media/video/saa7134/saa7134-dvb.c
>>    
>>
>>+#define CONFIG_DVB_MT352 1
>>+#define CONFIG_DVB_TDA1004X 1
>>    
>>
>
>Looks band-aidly.
>  
>
Yes, it does LOOK like a band-aid, but this is actually only reverting a 
previous change.  I admit that something better needs to be done.  Gerd 
Korr says to remove the #ifdef's alltogether.  Instead, I just returned 
the #define's .....  We can remove the #ifdef's in a future patch, but I 
want to discuss this with the other v4l developers before I would make a 
change like that.  THIS patch, however, is safe to apply, and I've 
already committed it into video4linux cvs.

Andrew, please apply this and don't merge the 
[v4l-saa7134-hybrid-dvb.patch & v4l-cx88-update.patch] patches to Linus' 
tree without this patch as well.

Thank you.

-- 
Michael Krufky


