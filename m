Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVFJTGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVFJTGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 15:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFJTGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 15:06:55 -0400
Received: from [63.81.117.10] ([63.81.117.10]:6632 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261178AbVFJTGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 15:06:47 -0400
Message-ID: <42A9E4C5.8000508@xfs.org>
Date: Fri, 10 Jun 2005 14:06:45 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42A99D9D.7080900@xfs.org> <20050610112515.691dcb6e.akpm@osdl.org>
In-Reply-To: <20050610112515.691dcb6e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2005 19:06:46.0318 (UTC) FILETIME=[8BFD6CE0:01C56DEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Stephen Lord <lord@xfs.org> wrote:
> 
>>I am having troubles getting any recent kernel to boot successfully
>> on one of my machines, a generic 2.6GHz P4 box with HT enabled
>> running an updated Fedora Core 3 distro. This is present in
>> 2.6.12-rc6. It does not manifest itself with the Fedora Core
>> kernels which have identical initrd contents as far as the
>> init script and the set of modules included goes.
>>
>> The problem manifests itself as various undefined symbols from
>> module loads.
> 
> 
> Peculiar.  Module loading is all synchronous, isn't it?


Hmm, now that I found the code, yes it is. insmod itself appears
to do no fancy foot work either.

> 
> 
>>...
>> The failures are different on different boots, sometimes the ata_piix
>> module cannot find symbols from libata, sometimes ext3 cannot find jbd
>> symbols, sometimes dm modules cannot find things from dm-mod, usually
>> it is a combination of these. End result is a panic when it cannot
>> find the root device.
>>
>>  From the behavior, it appears that a module load is returning
>> control to user space before the previous one has got its symbols
>> loaded.
> 
> 
> I wonder if rather than the intermittency being time-based, it is
> load-address-based?  For example, suppose there's a bug in the symbol
> lookup code?
> 
> Have you tried using a different gcc version?
> 

Don't have one handy at the moment, I am away from the machine right
now as well. I have been updating the machine using redhat's update
tools, so the compiler should be the same one I have here:

gcc (GCC) 3.4.3 20050227 (Red Hat 3.4.3-22.fc3)

That should also be a fairly common compiler variant.

I presume this is what redhat does their kernel builds with, so that
should be the same too. Shouldn't the memory map be pretty much
identical on each boot? Things are pretty deterministic at this
stage in the process, and the symbol match failures are not always
the same.

If this was a memory problem it seems like I would see more random
oopses than this. I added more memory to the machine a month or so
back, and had to detune the bios settings a little to make it stable.
It would be odd that a 2.6.11 kernel was rock solid and a 2.6.12-rc6
falls over so quickly if that was the case.

I can play with the init script some and maybe dump out the symbol
table after an insmod.

Steve
