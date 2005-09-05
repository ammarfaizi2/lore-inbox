Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVIEEIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVIEEIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 00:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVIEEIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 00:08:30 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54942
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932191AbVIEEIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 00:08:30 -0400
Date: Sun, 04 Sep 2005 21:08:48 -0700 (PDT)
Message-Id: <20050904.210848.43982827.davem@davemloft.net>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, hyoshiok@miraclelinux.com,
       mm-commits@vger.kernel.org
Subject: Re: x86-cache-pollution-aware-__copy_from_user_ll.patch added to
 -mm tree
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050904202333.GA4715@redhat.com>
References: <200509042017.j84KHekQ032373@shell0.pdx.osdl.net>
	<20050904202333.GA4715@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Subject: Re: x86-cache-pollution-aware-__copy_from_user_ll.patch added to -mm tree
Date: Sun, 4 Sep 2005 16:23:33 -0400

> On Sun, Sep 04, 2005 at 01:16:00PM -0700, Andrew Morton wrote:
>  >  unsigned long __copy_to_user_ll(void __user *to, const void *from, unsigned long n)
>  >  {
>  >  	BUG_ON((long) n < 0);
> 
> Ehh? It's unsigned. This will never be true.

It's to catch the user slipping in enormous lengths to
the user copy routines.

Sparc64 makes this check as well.  From U3memcpy.S:

	srlx		%o2, 31, %g2
	cmp		%g2, 0
	tne		%xcc, 5

%o2 is the length, we make sure the upper 33-bits are clear.
