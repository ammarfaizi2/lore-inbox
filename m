Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUBPOAH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265613AbUBPN4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:56:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45705 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265647AbUBPNzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:55:18 -0500
Message-ID: <4030CBC3.6060605@redhat.com>
Date: Mon, 16 Feb 2004 08:55:15 -0500
From: Will Cohen <wcohen@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: Philippe Elie <phil.el@wanadoo.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: Re: [PATCH] oprofile add Pentium Mobile support
References: <20040212224152.GE316@zaniah> <16432.39480.817800.21083@alkaid.it.uu.se>
In-Reply-To: <16432.39480.817800.21083@alkaid.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> Philippe Elie writes:
>  > From: Will Cohen <wcohen@redhat.com>
>  > 
>  > Add oprofile support for Pentium Mobile (P6 core). Pentium Mobile needs
>  > to unmask LVPTC vector, since it doesn't hurt other P6 core based cpus
>  > we do it unconditionally for all these.
> 
> [Patch talking about the Pentium-M.]
> 
> I can find no support in Intel's documentation (IA32 Volume 3,
> 25366813.pdf) that Pentium-M:s need to unmask LVTPC.
> 
> How certain are you of this? Is this an undocumented hardware
> quirk? If it is documented, please indicate where.

I have tested it on a Pentium M machine. Without the unmask LVTPC the 
nmi handler collected precisely one interrupt. With the LVTPC unmask the 
OProfile data collection worked normally.

> It's my theory that P4 added the auto-masking to help PEBS
> buffer overflow situations, but since P-M doesn't have PEBS,
> they shouldn't have had to change this on P-M as well.
> OTOH, it's certainly possible they changed it by accident.

My theory is that the Pentium M uses same bus interface and local apic 
as the Pentium M. Thus, the Pentium M shares the Pentium 4 need to 
unmask LVTPC.

> One way of testing this would be to run a P-M with
> nmi_watchdog=2. If the NMI counter keeps ticking, then
> LVTPC does not need unmasking.

Yes, I tested the nmi watchdog and it currently does not work on the 
Pentium M. It doesn't get the later interrupts and states it is stuck.


-Will

