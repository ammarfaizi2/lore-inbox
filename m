Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUCaIzI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 03:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUCaIzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 03:55:07 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:45320 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261857AbUCaIyt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 03:54:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Balazs Ree <ree@ree.hu>, linux-kernel@vger.kernel.org
Subject: Re: HPT370 locks up (2.4/2.6)
Date: Wed, 31 Mar 2004 10:54:01 +0200
X-Mailer: KMail [version 1.4]
References: <pan.2004.03.30.12.36.03.326699@ree.hu>
In-Reply-To: <pan.2004.03.30.12.36.03.326699@ree.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403311054.01626.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 March 2004 14:36, Balazs Ree wrote:
> Hello,
>
> I know that this issue has been brought up before, but still...
>
> I have an ABIT KT7-RAID motherboard with a HPT370 IDE controller on it.
> I have two SAMSUNG SP0802N drives attached, one on each channel, with a
> software RAID1 setup.
>
> Under both 2.4.22 and 2.6.4 that I tried, the same thing happens. System
> boots up allright, and works for a random period of time. Then it
> locks up completely with the disk led stuck lighting. No keystrokes work
> and there is no error message that I could see. The crash can be triggered

SysRq not working too? Look into interrupt handler of this driver.
Is there any potentially-endless loops? Modify them to have
some timeout, make them printk out loud if timeout triggers.

> by disk-intensive operations, it seems however like a random
> phenomenon, that but sooner or later happens for sure. It is likely
> that the case is connected with DMA handling, and that it only occurs if
> both IDE channels are utilized heavily (like is the case with RAID1).

Do parallel reads with dd. Does it happen? Do the same with DMA off.
Does it happen now? Same with writes. etc.

You may need to serialize channel usage in driver code if it indeed
happens when both channels are working at the same time.

> I've read from others having the same symptom on this list, but I could
> find no solution so far. None of the suggestions or patches that I tried
> have worked out (including the new patch of Andre Hedrick, which has no
> effect in this case since the HPT370 is a rev 3. controller)
>
> However, since my last try in last August with 2.4.22 I was using the
> "opensource" driver of HighPoint which worked rock stable for my setup.
> Now I started to experiment again with the hpt366 driver, this time under
> 2.6.4, and it's the same lockup situation. I would be rather happy to see
> the hpt366 driver working as then I (and others) would not be forced to
> use the "opensource" driver of Highpoint, that, besides being a
> partly binary driver, has other disadvantages (like it needs initrd, and
> it does not support S.M.A.R.T., or compile yet with the 2.6 kernel)
>
> In case someone has any idea, I would be glad to send specific logs and/or
> test patches (preferably with 2.6.4).
-- 
vda
