Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbSLQVdX>; Tue, 17 Dec 2002 16:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbSLQVdX>; Tue, 17 Dec 2002 16:33:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29200 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267174AbSLQVdS>; Tue, 17 Dec 2002 16:33:18 -0500
Message-ID: <3DFF99F3.2010503@transmeta.com>
Date: Tue, 17 Dec 2002 13:41:07 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Ulrich Drepper <drepper@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com> <3DFF6D4B.3060107@redhat.com> <1040153186.20780.11.camel@irongate.swansea.linux.org.uk> <3DFF7399.40708@redhat.com> <20021217163838.C10781@redhat.com>
In-Reply-To: <20021217163838.C10781@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Tue, Dec 17, 2002 at 10:57:29AM -0800, Ulrich Drepper wrote:
> 
>>But this is exactly what I expect to happen.  If you want to implement
>>gettimeofday() at user-level you need to modify the page.  Some of the
>>information the kernel has to keep for the thread group can be stored in
>>this place and eventually be used by some uerlevel code  executed by
>>jumping to 0xfffff000 or whatever the address is.
> 
> 
> You don't actually need to modify the page, rather the data for the user 
> level gettimeofday needs to be in a shared page and some register (like 
> %tr) must expose the current cpu number to index into the data.  Either 
> way, it's an internal implementation detail for the kernel to take care 
> of, with multiple potential solutions.
> 

That's not the problem... the problem is that the userland code can get
preempted at any time and rescheduled on another CPU.

	-hpa


