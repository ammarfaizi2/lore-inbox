Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWJ2LTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWJ2LTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 06:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWJ2LTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 06:19:08 -0500
Received: from adsl-ull-63-235.42-151.net24.it ([151.42.235.63]:15401 "EHLO
	apollo.abinetworks.biz") by vger.kernel.org with ESMTP
	id S932208AbWJ2LTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 06:19:07 -0500
Message-ID: <4544900F.3060706@abinetworks.biz>
Date: Sun, 29 Oct 2006 12:27:11 +0100
From: Gianluca Alberici <gianluca@abinetworks.biz>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ??] Re: incorrect taint of ndiswrapper
References: <1161807069.3441.33.camel@dv>	<1161808227.7615.0.camel@localhost.localdomain>	<20061025205923.828c620d.akpm@osdl.org>	<20061026102630.ad191d21.randy.dunlap@oracle.com>	<1161959020.12281.1.camel@laptopd505.fenrus.org>	<20061027082741.8476024a.randy.dunlap@oracle.com> <20061027112601.dbd83c32.akpm@osdl.org>
In-Reply-To: <20061027112601.dbd83c32.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Fri, 27 Oct 2006 08:27:41 -0700
>Randy Dunlap <randy.dunlap@oracle.com> wrote:
>
>  
>
>>From: Randy Dunlap <randy.dunlap@oracle.com>
>>
>>For ndiswrapper, don't set the module->taints flags,
>>just set the kernel global tainted flag.
>>This should allow ndiswrapper to continue to use GPL symbols.
>>Not tested.
>>
>>Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
>>---
>> kernel/module.c |    2 +-
>> 1 files changed, 1 insertion(+), 1 deletion(-)
>>
>>--- linux-2619-rc3-pv.orig/kernel/module.c
>>+++ linux-2619-rc3-pv/kernel/module.c
>>@@ -1718,7 +1718,7 @@ static struct module *load_module(void _
>> 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
>> 
>> 	if (strcmp(mod->name, "ndiswrapper") == 0)
>>-		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
>>+		add_taint(TAINT_PROPRIETARY_MODULE);
>> 	if (strcmp(mod->name, "driverloader") == 0)
>> 		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
>> 
>>    
>>
>
>Could someone please test this for us
>  
>

tested on rc2-mm2. It works.

I think it would be really good to hear somebody from the ndiswrapper 
group about this thread. During these 6 months (?) i believe both the 
kernel and ndiswrapper could go very far with a good collaboration.

Another thing: shouldnt be more efficent and readable to remove those 
"if ((strcmp...." from modules.c and to put all the tainted modules 
names into a separate source file into, say, a string array ? What if we 
had 250 tainted modules ?

And finally, it seems to me that ideas are not perfectly clear about 
what Linux should / should not do in respect to

- GPLed
- NON GPLed
- (???) GPLed

drivers. I believe policies and potential problems should be cristal 
clear before making any implementation.

Regards,

Gianluca
