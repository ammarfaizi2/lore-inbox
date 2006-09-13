Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWIMQRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWIMQRm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWIMQRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:17:42 -0400
Received: from gw.goop.org ([64.81.55.164]:25575 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751001AbWIMQRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:17:41 -0400
Message-ID: <45082F1C.8000003@goop.org>
Date: Wed, 13 Sep 2006 09:17:32 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <45075829.701@goop.org> <20060913095942.GA10075@elte.hu>
In-Reply-To: <20060913095942.GA10075@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> well, the most important thing i believe you didnt test: the effect of 
> mixing two descriptors on the _same_ selector: one %gs selector value 
> loaded and used by glibc, and another %gs selector value loaded and used 
> by the kernel, intermixed. It's the mixing that causes the descriptor 
> cache reload. (unless i missed some detail about your testcase)

But it doesn't mix different descriptors on the same selector; the GDT 
is initialized when the CPU is brought up, and is unchanged from then 
on.  The PDA descriptor is GDT entry 27 and the userspace TLS entries 
are 6-8, so in the typical case %gs will alternate between 0x33 and 0xd8 
as it enters and leaves the kernel.

My test program does the same thing, except using GDT entries 6 and 7 
(selectors 0x33 and 0x3b).

    J

