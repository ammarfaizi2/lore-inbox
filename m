Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVBQAnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVBQAnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 19:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVBQAnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 19:43:31 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:10961 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262168AbVBQAn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 19:43:26 -0500
Date: Thu, 17 Feb 2005 09:43:28 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] /proc/cpumem
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m1hdkcvc6v.fsf@ebiederm.dsl.xmission.com>
References: <20050216170224.4C66.ODA@valinux.co.jp> <m1hdkcvc6v.fsf@ebiederm.dsl.xmission.com>
Message-Id: <20050217084547.4C72.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> The lack of a type field looses a fair amount of functionality compared
> to /proc/iomem.  In particular you can't see where the ACPI data is.

Hmm, restricting System RAM only may be too pessimistic.
(One of motivations of this work is for using /dev/mem safely.
 "dd if=/dev/mem of=xxx" causes panic on my amd64(8GB mem) machine
 since reading from address around 0xfe000000 causes a machine
 check. hmm, this area is marked as "reserved". not ACPI area.
 ACPI area can be read.)

Ok, I will add a type field.

> The other direction something like this can go is to dump 
> the data structures in linux/mmzone.h 

Do you mean defining a data structure in linux/mmzone.h ?

I used to think a particular struct is not necessary for this work,
but now I think it is better to define a struct for this.
Let me consider. 

> I have written a first pass at a user space core dump generator,
> using /dev/mem.  /sbin/kexec still needs some work to prepare
> the ELF headers before a crash.

I am looking forward this :-)

And, you mentioned a couple of weeks ago:
> Anyway one thing I want to do is actually drop the apic shutdown
> code altogether in this code path.  I threw it in there to
> ease the transition from the old code base to the new, but
> if that code is causing issues....  So this is probably a good time
> to start testing that.

How about this ?

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>

