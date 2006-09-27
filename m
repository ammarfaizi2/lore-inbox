Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965418AbWI0HYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965418AbWI0HYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965422AbWI0HYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:24:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:25074 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965420AbWI0HYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:24:06 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Bad page state with x86_64
From: "Andreas Block" <andreas.block@esd-electronics.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
In-Reply-To: <4519200A.4000109@yahoo.com.au>
References: <op.tghdlool8n9ctc@pc-block.esd> <4519200A.4000109@yahoo.com.au>
Content-Transfer-Encoding: 7bit
Date: Wed, 27 Sep 2006 09:20:48 +0200
Message-ID: <op.tgiz0y0t8n9ctc@pc-block.esd>
User-Agent: Opera Mail/9.02 (Win32)
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:7ee1d245d6d47e4a96dce2c88f0dd45f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 14:41:46 +0200, Nick Piggin <nickpiggin@yahoo.com.au>
wrote:

> It is freeing a PageReserved page. You should ensure to balance your
> reference counting on *each* page (or allocate a compound page and
> treat it as a single one). When you map pages into userspace via
> nopage or remap_pfn_range, you need to increment their count, which
> gets decremented by the VM when they are unmapped.

Thanks a lot for your time and help. Still there are a few things a
seemingly don't understand correctly.
Do I understand you right, I don't have to "put_page" after calling
"get_page" in my no-page handler?
Also I'm wondering, why this code works flawlessly on 2.6.10 32-Bit and
several 2.4.x kernels 32-Bit and PPC and is failing to work on x86_64,
only. Do I have to do the "get/put_page" mechanism differnetly on x86_64?
Another question:
In my no-page handler, I reserve the physical page. I do have to clear the
reserve bit of those page after unmap, right? Or is this done implicitly
as well?

Again, thanks for your effort.
-- 
-------------------------------------------------------------------------

                             _/_/_/_/   Andreas Block
                            _/_/_/_/   Dipl.-Ing.
                           _/_/_/_/   andreas.block@esd-electronics.com

       _/_/_/   _/_/_/_/_/_/_/      esd electronic system design gmbh
     _/   _/  _/             _/    Vahrenwalder Str. 207
    _/   _/    _/_/_/   _/   _/   D-30165 Hannover
    _/             _/  _/   _/   Phone: +49-511-37298-0
     _/_/_/_/_/_/_/   _/_/_/    Fax:   +49-511-37298-68
                               http://www.esd-electronics.com

-------------------------------------------------------------------------
 
