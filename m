Return-Path: <linux-kernel-owner+w=401wt.eu-S1752433AbWLXRif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbWLXRif (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 12:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbWLXRif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 12:38:35 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:4460 "EHLO
	mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbWLXRif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 12:38:35 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] i386: per-cpu mmconfig map
References: <87lkkxz0k5.fsf@duaron.myhome.or.jp>
	<1166980577.3281.1396.camel@laptopd505.fenrus.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 25 Dec 2006 02:38:20 +0900
In-Reply-To: <1166980577.3281.1396.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Sun\, 24 Dec 2006 18\:16\:17 +0100")
Message-ID: <87hcvlyz1v.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Arjan van de Ven <arjan@infradead.org> writes:

>>     [ Alternatively, we could make a per-cpu mapping area or something. Not
>>       that it's probably worth it, but if we wanted to avoid all locking and
>>       instead just disable preemption, that would be the way to go. --Linus ]
>> 
>> This patch is a draft of Linus's suggestion. This seems work for me.
>> And this removes pci_config_lock in mmconfig access path, I think we
>> don't need lock on this path, although we need to disable IRQ.
>> 
>> Comment?
>
> I like the idea and the implementation, I have just one concern:
> Does your schema still work if the Non-Maskable-Interrupt code uses
> config space? It may do that I suspect to deal with ECC memory errors ;(

I didn't notice the problem of NMI at all. However if NMI path use it,
pci_config_lock would be deadlock already. So I think NMI can't access
to PCI config... Hm...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
