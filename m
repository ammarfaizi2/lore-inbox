Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbUKRXu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUKRXu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUKRXsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:48:37 -0500
Received: from [194.90.79.130] ([194.90.79.130]:4358 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S261187AbUKRXof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:44:35 -0500
Message-ID: <419D33DE.2080100@argo.co.il>
Date: Fri, 19 Nov 2004 01:44:30 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@nurfuerspam.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WTF is VLI?
References: <fa.inbtt12.195ed02@ifi.uio.no> <fa.cg6f09j.ji89hv@ifi.uio.no> <E1CUr14-0000oQ-00@be1.7eggert.dyndns.org>
In-Reply-To: <E1CUr14-0000oQ-00@be1.7eggert.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2004 23:44:31.0772 (UTC) FILETIME=[8D1AE5C0:01C4CDC8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:

>Avi Kivity wrote:
>
>  
>
>>for (offset = 0; offset < max_instr_len; ++offset) {
>>    create_object_file(code + offset, len - offset);
>>    disassemble();
>>    if (disassembly_includes_eip())
>>    
>>
>
>
>Will fail for
>
>movl eax,cc000000 ;or something similar, you get the point
>*EIP here*
>
>and result in
>
>INT3
>  
>
no, it will start at lower offsets first and see the movl.

of course, there is a chance that it will get confused (by even earlier 
partial code), but it will usually be better than the current method and 
it will never be confused at or above eip (same as current method).

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

