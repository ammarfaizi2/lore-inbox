Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWH0Re4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWH0Re4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWH0Re4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:34:56 -0400
Received: from gw.goop.org ([64.81.55.164]:37085 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932206AbWH0Re4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:34:56 -0400
Message-ID: <44F1D7B6.80105@goop.org>
Date: Sun, 27 Aug 2006 10:34:46 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
References: <20060827084417.918992193@goop.org> <20060827172155.GA21724@rhlx01.fht-esslingen.de>
In-Reply-To: <20060827172155.GA21724@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> This is interesting, since even by doing a non-elegant
> current->... --> struct task_struct *tsk = current;
> replacement for excessive uses of current, I was able to gain almost 10kB
> within a single file already!
> I guess it's due to having tried that on an older installation with gcc 3.2,
> which probably does less efficient opcode merging of current_thread_info()
> requests compared to a current gcc version.
> IOW, .text segment reduction could be quite a bit higher for older gcc:s.
>   

That doesn't sound likely.  current_thread_info() is only about 2 
instructions.  Are you looking at the .text segment size, or the actual 
file size?  The latter can be very misleading in the presence of debug info.

>> This uses the x86 segmentation stuff in a way similar to NPTL's way of
>> implementing Thread-Local Storage.  It relies on the fact that each CPU
>> has its own Global Descriptor Table (GDT), which is basically an array
>> of base-length pairs (with some extra stuff).  When a segment register
>> is loaded with a descriptor (approximately, an index in the GDT), and
>> you use that segment register for memory access, the address has the
>> base added to it, and the resulting address is used.
>>     
>
> Not a problem for more daring user-space apps (i.e. Wine), I hope?
>   

No.  The LDT is still available for userspace use.

    J
