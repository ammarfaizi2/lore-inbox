Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270670AbUJUK4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270670AbUJUK4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270675AbUJUKyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:54:47 -0400
Received: from aun.it.uu.se ([130.238.12.36]:63911 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S270670AbUJUKvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:51:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16759.38054.944944.610417@alkaid.it.uu.se>
Date: Thu, 21 Oct 2004 12:51:18 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, andrea@novell.com,
       linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
In-Reply-To: <20041020213622.77afdd4a.akpm@osdl.org>
References: <20041021011714.GQ24619@dualathlon.random>
	<417728B0.3070006@yahoo.com.au>
	<20041020213622.77afdd4a.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
 > >
 > > >  #if defined(CONFIG_SMP)
 > >  >  struct zone_padding {
 > >  > -	int x;
 > >  >  } ____cacheline_maxaligned_in_smp;
 > >  >  #define ZONE_PADDING(name)	struct zone_padding name;
 > >  >  #else
 > > 
 > >  Perhaps to keep old compilers working? Not sure.
 > 
 > gcc-2.95 is OK with it.

Have you verified that? GCCs up to and including 2.95.3 and
early versions of 2.96 miscompiled the kernel when spinlocks
where empty structs on UP. I.e., you might not get a compile-time
error but runtime corruption instead.
