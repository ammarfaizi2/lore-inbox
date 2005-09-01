Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbVIAIEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVIAIEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 04:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbVIAIEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 04:04:04 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:24561 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965080AbVIAIED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 04:04:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hR+nv08Wllb5DgQPGHuZ3qK4RcNqGbVmwH1HeOEWby7c1F7YtJOyKlF5XUYRgdGjIDUoxq1mqlwMdPUaUQPcf9hXLnF9IWkWwE+wT8C3dYuH/7XbRFZKNaLNxxl8i+etrlbtoLfQbQ57oelyHNnj/dLwHf4nIuN8sZqPF7Hc/jg=
Message-ID: <4316C1D9.10704@gmail.com>
Date: Thu, 01 Sep 2005 11:54:49 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, SYSLINUX@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com>	 <20050831215757.GA10804@taniwha.stupidest.org>	 <431628D5.1040709@zytor.com>	 <20050831220717.GA14625@taniwha.stupidest.org>	 <9a874849050831151230d68d64@mail.gmail.com>	 <20050831221424.GA14806@taniwha.stupidest.org> <9a8748490508311518320c6aba@mail.gmail.com> <43162E3A.9070703@zytor.com>
In-Reply-To: <43162E3A.9070703@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all for your quick responses!

I want to add some of my comments.


1. Kernel parameters is a great mechanism to control how the kernel 
behaves without modifying any file in kernel,

putting options in a file maybe seems a good solution... but it lower 
the power of the boot loader,

which can be used to control the kernel externally.


So I think we should solve the 256 limitation... And not adding a new 
mechanism.


2. As I understand initramfs gradually replaces initrd, since all the 
user space applications needs initramfs,

So modifying the initramfs to be different at each machine is not good 
for maintenance, and not easy to

control as editing its contents as in the boot loader approach.


3. Adding the maximum limit as configuration option is needed since the 
kernel allocates a static memory buffer,

As such, it should be determined... I think the default should be at 
least 1024... But I don't like

hard coded constants to be written in source.


4. "The concept of a command-line works for passing simple state but for 
more complex things it's too cumbersome."

I don't agree with that... the term "simple" is user defined...


For example, I use the command-line to do the following:

a. Report kernel of my root partition.

b. Report kernel of my root partition type.

c. Report my initramfs of my swap partition, boot partition, root partition.

d. Report my initramfs of where to find decryption key.

e. Report kernel+initramfs of which bootsplash to use and what resolution.

f. Set my initramfs debug level.

g. Set silent console output tty.

h. Set initial loop device number for decryption.


This all must happen at boot, and I needed to squeeze the names of the 
arguments in

order them to feet 256 limitation...

Does it fall in the "simple definition"?


5. In order for Lilo and Grub to implement the 2.02+ protocol without 
truncating the command line,

I need a definite response that they should not do that... Can you 
please provide it...?

It would be best if you update the boot.txt document.

Since without boot loader support, we cannot break this limitation for 
ordinary users.


6. A minor issue... Why the COMMAND_LINE_SIZE is defined in two files? 
Is there a specific reason?


Best Regards,

Alon Bar-Lev.



H. Peter Anvin wrote:

> Jesper Juhl wrote:
>
>>
>> Well, it wouldn't have to be initrd specifically. Generally what's
>> needed is *some* way to tell the kernel "please read more options from
>> location <foo>". The interresting bit is what <foo>'s supposed to be.
>>
>
> This is what initramfs (as opposed to initrd) does quite well.
>
>     -hpa
>
>

