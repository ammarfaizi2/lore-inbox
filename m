Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWI2Jcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWI2Jcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWI2Jcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:32:50 -0400
Received: from gw.goop.org ([64.81.55.164]:49109 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751024AbWI2Jcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:32:50 -0400
Message-ID: <451CE84E.300@goop.org>
Date: Fri, 29 Sep 2006 02:33:02 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
References: <20060928225444.439520197@goop.org>	<20060928225452.229936605@goop.org> <20060929021604.02fb6162.akpm@osdl.org>
In-Reply-To: <20060929021604.02fb6162.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> For my x86_64 usualconfig .text (from objdump --headers) went from
> 0x002c55c7 down to 0x002c2bda, which is 10.5k saved.
>
> According to /usr/bin/size, vmlinux got bigger:
>
> box:/usr/src/25> size vmlinux 
>    text    data     bss     dec     hex filename
> 3597448  716340  510456 4824244  499cb4 vmlinux-before
> 3640604  716228  510456 4867288  4a44d8 vmlinux-after
>   

Good, that's what we'd hope for.  It's going to be a bigger overall than 
the previous i386 code, because it's now saving away the EIP as well as 
filename* and line for each BUG.

> But that's because size(1) is too blunt an instrument: the sum of .text and
> the new bug section got larger.
>   

size -A will tell you everything you ever wanted to know.

> I think we need to thank the powerpc guys, then take away their function
> name printing ;)
>   

I think so...

    J
