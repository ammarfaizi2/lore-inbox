Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUF3PWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUF3PWw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUF3PWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:22:48 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:33195 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S266699AbUF3PWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:22:18 -0400
Date: Wed, 30 Jun 2004 16:22:03 +0100
From: Ian Molton <spyro@f2s.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-Id: <20040630162203.245ae9b2.spyro@f2s.com>
In-Reply-To: <20040630145942.GH29285@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org>
	<20040630091621.A8576@flint.arm.linux.org.uk>
	<20040630145942.GH29285@mail.shareable.org>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004 15:59:42 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> 
> Here's an optimisation idea, for ARM26 only:
> ...........................................
> 
> Do you need the "strlst" instructions in putuser.S?  They're followed
> by "strge" instructions.

ARM26 is special compared to some other architectures.

the CPU has a 64MB address space, and in all known ARM26 + MMU
configurations, the bottom 32MB are the logical addresses. the upper
32MB (where kernel, physical RAM (16MB max) and IO live) are physically
addressable ONLY.

the kernel isnt mapped into the virtual address space on ARM26. it could
be, but with only 512 logical pages maximum on a normal machine (1024 on
a machine with very little RAM) it would cripple the system even more
than it already is.

the tests in ARM26 determine wether to use a translated access or a
nontranslated one depending on wether we access kernel or user space.
