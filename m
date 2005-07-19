Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVGSQFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVGSQFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 12:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVGSQFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 12:05:05 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:19588 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261464AbVGSQFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 12:05:03 -0400
Message-ID: <42DD1FCF.4050304@gmail.com>
Date: Tue, 19 Jul 2005 17:44:15 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rth@twiddle.net,
       dhowells@redhat.com, kumar.gala@freescale.com, davem@davemloft.net,
       mhw@wittsend.com, support@comtrol.com,
       Rogier Wolff <R.E.Wolff@bitwizard.nl>, nils@kernelconcepts.de,
       cjtsai@ali.com.tw, Lionel.Bouton@inet6.fr, benh@kernel.crashing.org,
       mchehab@brturbo.com.br, laredo@gnu.org, rbultje@ronald.bitfreak.net,
       middelin@polyware.nl, philb@gnu.org, tim@cyberelk.net,
       campbell@torque.net, andrea@suse.de, linux@advansys.com,
       chirag.kantharia@hp.com, mulix@mulix.org
Subject: Re: [PATCH] pci_find_device --> pci_get_device
References: <42DC4873.2080807@gmail.com> <200507191327.44415@bilbo.math.uni-mannheim.de>
In-Reply-To: <200507191327.44415@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer napsal(a):

>Jiri Slaby wrote:
>  
>
>>Kernel version: 2.6.13-rc3-git4
>>
>>* This patch removes from kernel tree pci_find_device and changes
>>it with pci_get_device. Next, it adds pci_dev_put, to decrease reference
>>count of the variable.
>>* Next, there are some (about 10 or so) gcc warning problems (i. e.
>>variable may be unitialized) solutions, which were around code with old
>>pci_find_device.
>>    
>>
>
>Is this the reason why you initialize members of static structs? If this is 
>uninitialized it will end in the bss section and will be zeroed before the 
>kernel uses is. If you do it will go into data section and add more bloat to 
>the binary. At least this is the explanation I got once why not to do this.
>  
>
I can't find now changes of initialization static variables, but i have 
deleted section
dealing up with gcc warning from patch, it would go on a queue later.

>Many of the callers of pci_find_device() look like they are not ported to the 
>2.6 driver API and do the scanning for devices themself. I think it would be 
>a good idea to try to convert them to the new driver model instead of 
>replacing this. When you mark this deprecated and they still use the old 
>function everyone using this will see that there is some work to do.
>  
>
I don't know now the difference between API accurately, but I'll study 
it in a few days
and delete this sections from patch, alternatively rewrite the code.

>>* Some code was unpretty, or ugly, so the patch provides more readable
>>code, in some cases.
>>    
>>
>
>If you try to beautify code then please use for_each_pci_dev() macro from 
>include/linux/pci.h where possible.
>  
>
Done.

>When you want something of this getting included you have to split that into 
>pieces. Use extra patches for changes in coding style and functionality.
>  
>
Yeah, the patch now provides only changes of pci_find problems.
[Gcc will be discussed later, after doing more changes and completing patch
against gcc 4, where are more warnings...]


OK. The new patch is:
http://www.fi.muni.cz/~xslaby/lnx/lnx-pci_find-2.6.13-r3g4_1.patch
and bzipped
http://www.fi.muni.cz/~xslaby/lnx/lnx-pci_find-2.6.13-r3g4_1.patch.bz2
[Kernel version is the same (2.6.13-rc3-git4)]

And the patch now contains only:
* This patch removes from kernel tree pci_find_device and changes
it with pci_get_device. Next, it adds pci_dev_put, to decrease reference
count of the variable.
* Some code was unpretty, or ugly, so the patch provides more readable
code, in some cases.
* Marks the function (pci_find_device) as deprecated in pci.h

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

