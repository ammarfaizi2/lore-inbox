Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVEDDqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVEDDqd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 23:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVEDDqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 23:46:33 -0400
Received: from warlock.miem.edu.ru ([80.250.162.2]:19728 "EHLO
	warlock.miem.edu.ru") by vger.kernel.org with ESMTP id S261996AbVEDDqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 23:46:31 -0400
Message-ID: <4278455D.308@aknet.ru>
Date: Wed, 04 May 2005 07:45:33 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@telia.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Mateusz Berezecki <mateuszb@gmail.com>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk
Subject: Re: 2.6.12-rc3 OOPS  in vanilla source (once more)
References: <42763388.1030008@gmail.com>	 <20050502200545.266b4e55.akpm@osdl.org> <1115120050.945.39.camel@localhost.localdomain>
In-Reply-To: <1115120050.945.39.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alexander Nyberg wrote:
> /From my reading a task that is scheduled away cannot have a partial/
> saved pt_regs. If this is correct then ptrace won't suffer from this
> problem
This is most likely correct, I
just wanted to be sure.

> I need to look at the partial stack issue closer, don't think I fully
> understand it yet.
When the IRQ/NMI interrupts the
ring0 code (kernel), since the
handler is also ring0, the interrupt
gate doesn't save the SS and ESP
when switching, so you miss the 8 bytes.
After looking at the code again I
don't think this can affect the
ptrace since the ptrace probably
never traces from an IRQ context
(I hope).
So I think it is safe to ignore my
previous comment. (if only perhaps
the "optimized" version of the patch
is to have a look)

