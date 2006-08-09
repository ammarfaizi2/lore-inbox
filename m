Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWHIObm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWHIObm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWHIObm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:31:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:48520 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750894AbWHIObm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:31:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iK4P4+WOy8ma6lXIfw9LFOyNfzvA4xkeXV+jCQQp5xTrKkoMUdkPXyiXRoooRzcEG3Xl3Bn/iq4uDZ9ijsciCFU4Xc0gnupyfz/FuSB/dUeMKfAHCeseZ7jnFx8UwuGvWtvAzwLek3Es+dnErlKZUUZUJHn0RSO4m8hLB937RZ8=
Message-ID: <44D9F1D7.7050407@gmail.com>
Date: Wed, 09 Aug 2006 16:31:28 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: sasha <sasha@scalemp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Map memory to user, then map it back to kernel
References: <44D98BF3.5060706@scalemp.com>
In-Reply-To: <44D98BF3.5060706@scalemp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sasha wrote:
> Hi folks.
> 
> I am looking for a way to map a memory (allocated with get_free_pages()) 
> from kernel space to user space, so that I will later be able to map it 
> back with get_user_pages().
> 
> I tried remap_pfn_range(), but it didn't work as it assumes the memory 
> being mapped is IO range (marking vma with VM_IO flag), while 
> get_user_pages() works on regular memory.
> 
> Any ideas?

VM_IO flag means not to swap this memory and don't do any side-effects bound 
with that IIRC.

If you want to mmap some memory in kernel to allow userspace to be able to read 
from it, just remap and don't care. I actually don't understand, what you mean 
by remapping it back to kernelspace, can you be more specific?

Caveat of get_free_pages is that it allocates physically contiguous memory and 
this may fail in later times, when the memory is not so free. You can use 
virtual memory to avoid this: vmalloc_32_user, remap_vmalloc_range, vfree.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
