Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbUKRPuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbUKRPuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbUKRPr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:47:57 -0500
Received: from [194.90.79.130] ([194.90.79.130]:1039 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S262756AbUKRPrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:47:17 -0500
Message-ID: <419CC402.7080109@argo.co.il>
Date: Thu, 18 Nov 2004 17:47:14 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Hugh Dickins <hugh@veritas.com>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WTF is VLI?
References: <5431.1100670949@kao2.melbourne.sgi.com>
In-Reply-To: <5431.1100670949@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2004 15:47:15.0597 (UTC) FILETIME=[E09D5BD0:01C4CD85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

>So for VLI code, ksymoops splits the code line into two separate pieces
>and processes each one seperately.  ksymoops prints the first bit with
>a warning that it may not be reliable.  The second bit, and all the
>code line for non-VLI architectures, is reliable and is printed without
>a warning.
>
>  
>
ksymoops can disasemble the entire code line, but starting at different 
offsets (up to the maximum instruction length) from the start. the first 
disassembly to include the program counter in the output would be deemed 
correct.

this would work for all architectures, and might improve reliability for 
i386.

in case I'm not communicating well:

for (offset = 0; offset < max_instr_len; ++offset) {
    create_object_file(code + offset, len - offset);
    disassemble();
    if (disassembly_includes_eip())
        break;
}

the likelyhood of the first section containing garbage is reduced; and 
the code works for VLI and FLI.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

