Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287196AbSALR1O>; Sat, 12 Jan 2002 12:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287200AbSALR1F>; Sat, 12 Jan 2002 12:27:05 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:50185 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S287196AbSALR0w>;
	Sat, 12 Jan 2002 12:26:52 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201121726.g0CHQZ7369540@saturn.cs.uml.edu>
Subject: Re: [PATCH] 1-2-3 GB
To: andrea@suse.de (Andrea Arcangeli)
Date: Sat, 12 Jan 2002 12:26:35 -0500 (EST)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <20020112141738.L1482@inspiron.school.suse.de> from "Andrea Arcangeli" at Jan 12, 2002 02:17:38 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
> On Fri, Jan 11, 2002 at 11:32:37PM -0800, H. Peter Anvin wrote:
>> By author:    rwhron@earthlink.net

>>> --- linux.aa2/arch/i386/config.in       Fri Jan 11 20:57:58 2002
>>> +++ linux/arch/i386/config.in   Fri Jan 11 22:20:32 2002
>>> @@ -169,7 +169,11 @@
>>>  if [ "$CONFIG_HIGHMEM64G" = "y" ]; then
>>>     define_bool CONFIG_X86_PAE y
>>>  else
>>> -   bool '3.5GB user address space' CONFIG_05GB
>>> +   choice 'Maximum Virtual Memory' \
>>> +       "3GB            CONFIG_1GB \
>>> +        2GB            CONFIG_2GB \
>>> +        1GB            CONFIG_3GB \
>>> +        05GB           CONFIG_05GB" 3GB
>>>  fi
>>
>> Calling this "Maximum Virtual Memory" is misleading at best.  This is
>> best described as "kernel:user split" (3:1, 2:2, 1:3, 3.5:0.5);
>> "maximum virtual memory" sounds to me a lot like the opposite of what
>> your parameter is.
>
> actually it is really max virtual memory.. but from the user point of
> view, user is supposed to care about the virtual memory he can manage,
> not about what the kernel will do with the rest. So if the user wants
> 3GB of virtual memory available to each task he will select 3GB. I
> really don't mind if you want to change it from the kernel point of
> view, but given it's the user who's supposed to compile it, also the
> current patch looks good enough to me.

The numbers are wrong anyway, because of vmalloc() and PCI space.
The PCI space is motherboard-dependent AFAIK, but you could at
least account for the 128 MB vmalloc() area:

user virtual space / non-kmap physical memory

3584/384
3072/896
2048/1920
1024/2944  (sure this works, even for syscalls w/ bad pointers?)
512/3456   (sure this works, even for syscalls w/ bad pointers?)
