Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932676AbWCIEgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbWCIEgY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWCIEgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:36:24 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:34491 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S932675AbWCIEgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:36:23 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Date: Wed, 8 Mar 2006 20:36:19 -0800
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org> <Pine.LNX.4.64.0603081716400.32577@g5.osdl.org> <17423.42185.78767.837295@cargo.ozlabs.ibm.com>
In-Reply-To: <17423.42185.78767.837295@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603082036.19811.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 08, 2006 7:45 pm, Paul Mackerras wrote:
> If we can have the following rules:
>
> * If you have stores to regular memory, followed by an MMIO store,
> and you want the device to see the stores to regular memory at the
> point where it receives the MMIO store, then you need a wmb() between
> the stores to regular memory and the MMIO store.
>
> * If you have PIO or MMIO accesses, and you need to ensure the
>   PIO/MMIO accesses don't get reordered with respect to PIO/MMIO
>   accesses on another CPU, put the accesses inside a spin-locked
>   region, and put a mmiowb() between the last access and the
>   spin_unlock.
>
> * smp_wmb() doesn't necessarily do any ordering of MMIO accesses
>   vs. other accesses, and in that sense it is weaker than wmb().

This is a good set of rules.  Hopefully David can add something like 
this to his doc.

> ... then I can remove the sync from write*, which would be nice, and
> make mmiowb() be a sync.  I wonder how long we're going to spend
> chasing driver bugs after that, though. :)

Hm, a static checker should be able to find this stuff, shouldn't it?

Jesse
