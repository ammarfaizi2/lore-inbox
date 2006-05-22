Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWEVPE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWEVPE7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWEVPE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:04:59 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:3640
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750908AbWEVPE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:04:59 -0400
Message-Id: <4471EF6D.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Mon, 22 May 2006 17:05:49 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: Re: [PATCH 5/6, 2nd try] reliable stack trace support (i386)
References: <4471D660.76E4.0078.0@novell.com> <200605221613.57000.ak@suse.de>
In-Reply-To: <200605221613.57000.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 22.05.06 16:13 >>>
>On Monday 22 May 2006 15:18, Jan Beulich wrote:
>> These are the i386-specific pieces to enable reliable stack traces. This is
>> going to be even more useful once CFI annotations get added to he assembly
>> code, namely to entry.S.
>
>Also obsolete with 6/6? 

Yes, but I thought this basically just says that.

>> +#ifdef CONFIG_STACK_UNWIND
>> +  . = ALIGN(4);
>> +  .eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {
>> +	__start_unwind = .;
>> +  	*(.eh_frame)
>> +	__end_unwind = .;
>> +  }
>> +#endif
>
>Shouldn't this be CONFIG_UNWIND_INFO?  Seems a bit unsymmetric to x86-64

It's exactly the same xor x86-64 - the added symbols (__start_unwind and __end_unwind) are only needed then. Of course,
there wouldn't be anything wrong if one used CONFIG_UNWIND_INFO here.

>I merged the patches all up for now. Thanks.

Thanks!

Jan
