Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUAaTls (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 14:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbUAaTls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 14:41:48 -0500
Received: from terminus.zytor.com ([63.209.29.3]:58269 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265155AbUAaTlq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 14:41:46 -0500
Message-ID: <401C04ED.4010109@zytor.com>
Date: Sat, 31 Jan 2004 11:41:33 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Paul Mackerras <paulus@samba.org>, klibc list <klibc@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [klibc] Re: long long on 32-bit machines
References: <4017F991.2090604@zytor.com> <16408.59474.427408.682002@cargo.ozlabs.ibm.com> <401B464C.50004@zytor.com> <200401311323.40399.arnd@arndb.de>
In-Reply-To: <200401311323.40399.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Saturday 31 January 2004 07:08, H. Peter Anvin wrote:
> 
>>Does system calls follow the same convention?
> 
> 
> I have just looked up in glibc what architectures need this kind
> of handling and found that there is no easy rule. The good news
> is that none of (hppa m68k s390 sparc x86_64 alpha cris i386 sparc64 
> arm ia64) are doing this. 
> 
> AFAICS, the padding is done for exactly these system calls:
> 
> ppc: truncate64, ftruncate64, pread64, pwrite64
> mips: truncate64, ftruncate64, pread64, pwrite64
> sh: pread64, pwrite64
> 
> fadvise64_64 is another story: 
> mips does no padding, ppc32 reorders the arguments (int fd, int advise,
> off64_t offset, off64_t len) and s390 passes a struct, for the
> reason Uli already explained.
> 

<BARF>

I hate ad hockery :(  Yet more evidence for the need of a formal 
description of the ABI in the kernel.

	-hpa
