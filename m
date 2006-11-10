Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946824AbWKJXja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946824AbWKJXja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 18:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946828AbWKJXja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 18:39:30 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13521
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1946827AbWKJXj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 18:39:29 -0500
Date: Fri, 10 Nov 2006 15:39:30 -0800 (PST)
Message-Id: <20061110.153930.23011358.davem@davemloft.net>
To: jeremy@goop.org
Cc: magnus.damm@gmail.com, horms@verge.net.au, ebiederm@xmission.com,
       magnus@valinux.co.jp, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com,
       ak@muc.de, fastboot@lists.osdl.org, anderson@redhat.com
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
From: David Miller <davem@davemloft.net>
In-Reply-To: <45550D2F.2070004@goop.org>
References: <20061110005051.GB4107@verge.net.au>
	<aec7e5c30611092000k397fb578xc59a990043fc310a@mail.gmail.com>
	<45550D2F.2070004@goop.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Fitzhardinge <jeremy@goop.org>
Date: Fri, 10 Nov 2006 15:37:19 -0800

> Magnus Damm wrote:
> > I see no point in aligning to 32-bit boundaries on 64-bit platforms.
> > Their intention was most likely to align to the word size IMO, so this
> > is most likely a "thinko" left over from whoever ported the code from
> > 32-bit to 64-bit.
> 
> I don't think so.  Since Elf64 notes still have 32-bit values in them,
> 32-bit alignment seems the most sensible.  It would certainly be an
> irritation to have Elf32 and Elf64 Notes with basically the same
> definition, but with different alignments.

I think Elf64 notes very much would need 64-bit alignment, especially
if there are u64 objects in there.  Otherwise it would not be possible
to directly dereference such objects without taking unaligned faults
on several types of RISC cpus.

