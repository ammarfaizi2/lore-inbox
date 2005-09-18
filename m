Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVIRQsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVIRQsY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 12:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVIRQsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 12:48:24 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:40104 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1750953AbVIRQsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 12:48:24 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: mmap (2) vs read (2)
References: <wn58xxvhdz8.fsf@linhd-2.ca.nortel.com>
	<1126981595.3010.1.camel@localhost.localdomain>
From: "Linh Dang" <linhd@nortel.com>
Organization: Null
Date: Sun, 18 Sep 2005 12:47:48 -0400
In-Reply-To: <1126981595.3010.1.camel@localhost.localdomain> (Arjan van de
 Ven's message of "Sat, 17 Sep 2005 14:26:35 -0400")
Message-ID: <wn5oe6q9vbf.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arjan van de Ven <arjanv@redhat.com> wrote:

> On Sat, 2005-09-17 at 12:10 -0400, Linh Dang wrote:
>> Hi, how come reading memory from /dev/mem using pread(2) or mmap(2)
>> will give diffent results?
>
> because you're being evil ;)
>
> mmap of /dev/mem for *ram* is special. To avoid cache aliases and
> other evils, you can only mmap non-ram realistically on /dev/mem.
>
> Why are you using /dev/mem in the first place, it's a sure sign that
> you're doing something really wrong in your design...

Thanx for the reply, what I'm doing is writing a driver (based on
mem.c) to export a block of ram to (other masters on) the PCI bus. The
driver does:

        1. get a contiguous block of ram using alloc_pages()
        2. export (via host-bridge hw setting) the block to the pci
           bus
        3. provide the .mmap() method in the driver to let userspace
           to mmap the device

In doing so, I encountered the inconsistencies of mmap(2) vs
read(2)/write(2). The work around I found is to SetPageReserved() on
all the pages got from alloc_pages(). But unfortunately I have no
clues why it's so. The vm code is not the easiest one to read
(compared to let's say the network code.)

-- 
Linh Dang
