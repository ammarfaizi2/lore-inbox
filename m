Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTKJQuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbTKJQuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:50:37 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:57796 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263969AbTKJQuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:50:35 -0500
Message-ID: <3FAFC1D1.3090309@colorfullife.com>
Date: Mon, 10 Nov 2003 17:50:25 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: EFAULT reading /dev/mem... - broken x86info
References: <20031108162737.GB26350@vana.vc.cvut.cz> <20031110161114.GM10144@redhat.com>
In-Reply-To: <20031110161114.GM10144@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>I don't really have much insight into the behind the scenes going on's of
>DEBUG_PAGEALLOC, so I don't know if your suggestion has merit or not.
>Maybe Manfred can shed some insight?
>
DEBUG_PAGEALLOC is not the only user of change_page_attr: gart also 
removes it's pages from the linear mapping.
I think x86info should accept the -EFAULT as an indication that the 
targeted page is in use for other purpose, and definitively doesn't 
contain a mptable. The other option would be to change both 
DEBUG_PAGEALLOC and the AGP gart driver

>  This does seem to be a regression IMO
>(Though I am somewhat biased as this breaks my app 8-)
>
It breaks either your app or your AGP driver - what's simpler to fix? 
I'm biased, because if you update the AGP driver, then I must figure out 
how to fix DEBUG_PAGEALLOC 8-)

--
    Manfred

