Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbUKCBoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbUKCBoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbUKCBop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:44:45 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:24711 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261306AbUKCBoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:44:44 -0500
Message-ID: <418837D1.402@us.ibm.com>
Date: Tue, 02 Nov 2004 17:43:45 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
References: <4187FA6D.3070604@us.ibm.com> <20041102220720.GV3571@dualathlon.random> <41880E0A.3000805@us.ibm.com> <4188118A.5050300@us.ibm.com> <20041103013511.GC3571@dualathlon.random>
In-Reply-To: <20041103013511.GC3571@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Tue, Nov 02, 2004 at 03:00:26PM -0800, Dave Hansen wrote:
> 
>>just sent out, I just wanted to demonstrate what solves my immediate 
>>problem.
> 
> sure ;)
> 
> that's like disabling the config option, the only point of
> change_page_attr is to split the direct mapping, it does nothing on
> highmem, it actually BUGS() (and it wasn't one of my new bugs ;):
> 
> #ifdef CONFIG_HIGHMEM
> 	if (page >= highmem_start_page) 
> 		BUG(); 
> #endif

Oh, crap.  I meant to clear ->mapped when change_attr(__pgprot(0)) was 
done on it, and set it when it was changed back.  Doing that correctly 
preserves the symmetry, right?
