Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVC1Lqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVC1Lqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 06:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVC1Lqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 06:46:46 -0500
Received: from mail3.euroweb.net.mt ([217.145.4.38]:38026 "EHLO
	mail3.euroweb.net.mt") by vger.kernel.org with ESMTP
	id S261383AbVC1Lqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 06:46:33 -0500
Message-ID: <4247EEA2.1040006@euroweb.net.mt>
Date: Mon, 28 Mar 2005 13:46:42 +0200
From: "Josef E. Galea" <josefeg@euroweb.net.mt>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: EXPORT_SYMBOL question
References: <4247E62B.5080900@euroweb.net.mt> <20050328111953.GA20502@mars.ravnborg.org>
In-Reply-To: <20050328111953.GA20502@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

>On Mon, Mar 28, 2005 at 01:10:35PM +0200, Josef E. Galea wrote:
>  
>
>>Hi,
>>
>>I have 2 modules. The first one uses EXPORT_SYMBOL to make some function 
>>available to other modules. These prototypes for these functions were 
>>also put in a header file. Now the second module uses the functions the 
>>functions defined in the first module by and includes the afore 
>>mentioned header file. However when i'm compiling the module, I get a 
>>symbol underfined warning. When I load the module it works as expected. 
>>Is there any way to get rid of these warnings.
>>
>>Another problem I'm having is that when I load the second module I get 
>>`no version for "rbnode_initialize" found: kernel tainted.' 
>>(rbnode_initialize is one of the functions exported by the first 
>>module). Both MODULE_LICENSE("GPL"); and MODULE_VERSION are declared in 
>>the two modules. Is there anything I'm missing?
>>    
>>
>
>You need to compile both modules at the same time.
>Do something like this for your two modules foo and bar:
>
>modules/Makefile
>obj-y := foo/ bar/
>modules/foo/	<= Your foo module
>modules/bar/	<= Your bar module
>
>Then when building the modules stay in modules/ and
>execute:
>make -C <path-to-kernel-src> M=`pwd`
>
>And to install modules:
>make -C <path-to-kernel-src> M=`pwd` modules_install
>
>	Sam
>
>  
>
Thanks for your help. That solved both the warnings and the kernel 
tainted message.

Josef
