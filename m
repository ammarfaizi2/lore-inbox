Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWFPQdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWFPQdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 12:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWFPQdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 12:33:35 -0400
Received: from sunsite.ms.mff.cuni.cz ([195.113.15.26]:31908 "EHLO
	sunsite.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751480AbWFPQde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 12:33:34 -0400
Date: Fri, 16 Jun 2006 18:33:15 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>, Jes Sorensen <jes@sgi.com>,
       Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Message-ID: <20060616163315.GO3823@sunsite.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200606140942.31150.ak@suse.de> <200606161737.06132.ak@suse.de> <20060616155804.GN3823@sunsite.mff.cuni.cz> <200606161824.52620.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606161824.52620.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 06:24:52PM +0200, Andi Kleen wrote:
> I wonder why it happened on x86-64 though - i thought there were no negative
> offsets on x86-64 TLS.

It uses negative offsets for __thread vars and positive are reserved for
implementation (i.e. glibc).  But as %fs in 64-bit programs is just
msr 0xc0000100 base addition, with no segment limit, neither Xen nor VMWare
can play limit tricks with it.

	Jakub
