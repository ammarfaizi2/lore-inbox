Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUFHKF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUFHKF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 06:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUFHKF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 06:05:57 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:64908 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S262079AbUFHKFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 06:05:35 -0400
Message-ID: <40C59FE9.1010700@codeweavers.com>
Date: Tue, 08 Jun 2004 20:15:53 +0900
From: Mike McCormack <mike@codeweavers.com>
Organization: Codeweavers
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <40C2B51C.9030203@codeweavers.com> <20040606052615.GA14988@elte.hu> <40C2D5F4.4020803@codeweavers.com> <1086507140.2810.0.camel@laptop.fenrus.com> <20040608092055.GX4736@devserv.devel.redhat.com>
In-Reply-To: <20040608092055.GX4736@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Really the most safe way for Wine is to create a PT_LOAD segment with
> p_flags 0 covering the whole area below the executable.  The kernel first
> maps the executable, then the dynamic linker, so no matter what address
> are ld.so and shared libraries prelinked to, they will not be mapped to the
> area Wine reserves.

I did not investigate this, but others who did think that it is not 
possible to create a segment that is reserve only so that does not 
unnecessarily consume virtual memory. Apparently ELF allows it, but 
Linux doesn't.

Secondly the amount of memory we want to reserve depends upon the PE 
executable that we want to load, so varies.  If we reserve only what 
memory we need, when possible shared libraries can be loaded at their 
prefered load address, and benefit from prelinking.

> Making Wine a PIE is also a possible solution (at least in FC2 for
> non-prelinked PIEs kernel doesn't honor ld.so's prelinked address), but
> then you cannot be sure the kernel doesn't choose the addresses Wine wishes
> to reserve while randomizing.

We are using a staticly linked binary (preloader) with a fixed load 
address at the moment, which reserves memory first, then loads 
ld-linux.so.2 and wine as the kernel would.

Mike
