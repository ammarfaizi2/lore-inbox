Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbVINK3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbVINK3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbVINK27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:28:59 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:16002 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932695AbVINK27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:28:59 -0400
Message-ID: <4327FB6C.3070708@gmail.com>
Date: Wed, 14 Sep 2005 12:29:00 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Manu Abraham <manu@kromtek.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <4327F586.3030901@gmail.com> <4327F551.6070903@kromtek.com>
In-Reply-To: <4327F551.6070903@kromtek.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manu Abraham napsal(a):

> Jiri Slaby wrote:
>
>> Manu Abraham napsal(a):
>>
>>> Now that i have been trying to implement the driver using the new 
>>> PCI API, i feel a bit lost at the different changes gone into the 
>>> PCI API. So if someone could give me a brief idea how a minimal PCI 
>>> probe routine should consist of, that would be quite helpful.
>>
>>
>>
>> Maybe, you want to read http://lwn.net/Kernel/LDD3/, chapter 12, 
>> pages 311+.
>>
>
> I have been updating myself from LDD2 to LDD3. What i was wondering 
> was in what order should i be calling the functions.

You won't call anything, kernel does. You only register driver.
struct pcitbl {venids, devids}

struct driver ... = {probe=a, remove=b, tbl=pcitbl};
a() { if device from pcitbl is in the system (or has been added before 
some little time) this function is called}
b() {if the device was removed from system: modules and hotplug: never 
called; modules: so if modules unload; if both: if the device was 
removed on the fly, or module unload}

module_init() { register_driver(driver)}
module_exit() { unregister_driver(driver); }

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

