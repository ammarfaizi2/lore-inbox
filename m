Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBONdO>; Thu, 15 Feb 2001 08:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRBONdF>; Thu, 15 Feb 2001 08:33:05 -0500
Received: from pcow024o.blueyonder.co.uk ([195.188.53.126]:43017 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S129093AbRBONc7>;
	Thu, 15 Feb 2001 08:32:59 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compaq Alpha: missing i-cache invalidates in ptrace (2.2.18, 2.4.0) ? 
In-Reply-To: Your message of "Thu, 15 Feb 2001 06:29:13 CST."
             <Pine.LNX.3.96.1010215062856.5873D-100000@mandrakesoft.mandrakesoft.com> 
Date: Thu, 15 Feb 2001 13:32:55 +0000
From: James Cownie <jcownie@etnus.com>
Message-ID: <14TOWl-51w-00@etnus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik asked :-

> Does the same Alpha problem exist in 2.4.1-AC patches?  (Alan Cox's
> patchkit)

It looks as if there's a very suitable fix in kernel/ptrace.c .

In access_one_page we have 

	if (write) {
		maddr = kmap(page);
		memcpy(maddr + (addr & ~PAGE_MASK), buf, len);
		flush_page_to_ram(page);
		flush_icache_page(vma, page);
		kunmap(page);
	}

which looks ideal to me...

That still leaves 2.2 broken, though :-(

-- Jim 

James Cownie	<jcownie@etnus.com>
Etnus, LLC.     +44 117 9071438
http://www.etnus.com
