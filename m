Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269088AbUJQJm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269088AbUJQJm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 05:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269092AbUJQJm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 05:42:58 -0400
Received: from mail-gateway-0-1.landonet.net ([196.25.111.196]:30669 "EHLO
	mail-gateway-0-1.landonet.net") by vger.kernel.org with ESMTP
	id S269088AbUJQJmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 05:42:55 -0400
Message-ID: <41723E8D.4060203@lbsd.net>
Date: Sun, 17 Oct 2004 09:42:37 +0000
From: Nigel Kukard <nkukard@lbsd.net>
Organization: Linux Based Systems Design
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040712
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-bk2 bug report
References: <416FD24C.7020007@lbsd.net>	<20041015225306.10bbbc69.akpm@osdl.org>	<4170C946.5020800@lbsd.net> <20041016001445.41cbd2db.akpm@osdl.org>
In-Reply-To: <20041016001445.41cbd2db.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>>>While booting with 2.6.9rc4-bk2 I seem to get the below OOPS, I copied 
>>>>the modules & System.map file over to another box of mine where i used 
>>>>serial-console to grab the oops.
>>>>        
>>>>
>>Could it be caused by loading a module?
>>    
>>
>Yes.  Or by unloading a module.  The oops will happen some time _after_ the
>buggy module has done its buggy thing.  Maybe you could change your
>modprobe command to be:
>
>	echo running modprobe $*
>	modprobe.old $*
>	sleep 5
>	echo finished modprobe $*
>
>or something like that.
>  
>
Ok, it seems to be related to specific hardware. I tried loading the 
exact same modules on another box in the exact same order, no crash. The 
box is actually running nicely.

I'm busy compiling the kernel again, this time with a few debug options 
ticked.

As far as I saw 2 days ago, its when I load uhci-hcd that the problem 
manifests itself... this is the order the modules are loaded in...

snd, snd_als4000, crc32, sis900, psmouse, evdev, tsdev, agpgart, 
sis_agp, pci_hotplug, usbcore, ohci_hcd, ub, ehci_hcd, ieee1394, 
ohci1394, uhci_hcd

The OOPS is  triggered from loading uhci_hcd, so it could be ohci1394 
that creates the corruption. I've had problems with ohci1394 in 26.8.1 
aswell, I cannot load it, unload it, and reload it... generates a D 
state for the modprobe.

Any tips on how i can track down the offending line in source?

Regards
Nigel Kukard




