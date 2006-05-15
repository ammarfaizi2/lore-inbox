Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWEOSiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWEOSiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWEOSiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:38:03 -0400
Received: from ns2.suse.de ([195.135.220.15]:24029 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965124AbWEOSiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:38:00 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86 NUMA panic compile error
Date: Mon, 15 May 2006 20:37:53 +0200
User-Agent: KMail/1.9.1
Cc: mingo@elte.hu, apw@shadowen.org, linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org> <200605152013.53728.ak@suse.de> <20060515113439.457f5809.akpm@osdl.org>
In-Reply-To: <20060515113439.457f5809.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152037.54242.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > Another reason I don't like it is that it's ugly and reimplements
> > parts of ACPI on its own for no reason.
> 
> So shouldn't such a patch remove that code rather than panicing?

I would be for remove, but apparently we have one or two users in
IBM that run their x440s (32bit only) with CONFIG_NUMA. No distributions
do so though and I would expect x440s to usually run distributions
because they are quite expensive machines.

My arguments for remove:
- The code is very hackish - it was written before the proper ACPI
infrastructure is in place - and NUMA on 32bit in general needs a lot
of hacks because of the limited ZONE_NORMAL.
- NUMA on 32bit is kind of broken by design.
- It isn't used much.
- It breaks often
- It tends to not work on Opterons and hits the users who try it there.

Short of remove I would settle on the panic on non Summit.

Also if you only wanted NUMA emulation for testing it could be also
done much much simpler removing near all of i386/*/srat.c. But with
the inherent 32bit NUMA limitations I have my doubts on its great
usefulness.

-Andi
