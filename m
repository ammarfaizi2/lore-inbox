Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVHaNZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVHaNZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVHaNZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:25:43 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2055 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S964794AbVHaNZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:25:42 -0400
Date: Wed, 31 Aug 2005 14:25:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
Subject: Re: APIC version and 8-bit APIC IDs
In-Reply-To: <4315AD07.2020500@fujitsu-siemens.com>
Message-ID: <Pine.LNX.4.61L.0508311417110.10940@blysk.ds.pg.gda.pl>
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel>
 <p73pssj2xdz.fsf@verdi.suse.de> <4315AD07.2020500@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005, Martin Wilck wrote:

> We are wondering why these masks are there in the subarch code at all. After
> all, whether or not 8-bit APIC IDs are supported depends mainly on the CPU
> type used. Why wouldn't it possible to have a "default" architecture with APIC
> IDs > 15, if the CPUs allow it?

 It actually depends on the APIC type, rather than the CPU.  E.g. with 
Pentium systems the width of the ID is either 4 bits or 8 bits, depending 
on whether the integrated or an external 82489DX APIC is used.  This 
should be able to be determined by the APIC version; for v <= 0xf the ID 
is 8-bit and for v >= 0x10 it used to be 4-bit.  Now you only need to 
determine what is the value of v above 0x10 that makes the ID 8-bit again.

  Maciej
