Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWDFDeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWDFDeB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 23:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWDFDeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 23:34:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751350AbWDFDeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 23:34:00 -0400
Date: Wed, 5 Apr 2006 20:32:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: phillips@google.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
Message-Id: <20060405203233.5fb222ae.akpm@osdl.org>
In-Reply-To: <20060406015636.GE6924@ccure.user-mode-linux.org>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
	<20060324144535.37b3daf7.akpm@osdl.org>
	<20060325010524.GA8117@ccure.user-mode-linux.org>
	<44343E86.30301@google.com>
	<20060406015636.GE6924@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> +			/* 0 means don't wait (like GFP_ATOMIC) and
>  +			 * don't dip into emergency pools (unlike
>  +			 * GFP_ATOMIC).
>  +			 */
>  +			new = kmalloc(sizeof(*new), 0);

What we've done in the past here is to use (GFP_ATOMIC & ~__GFP_HIGH).  It
amounts to the same thing, but it carries some semantic meaning: "whatever
GFP_ATOMIC measn, only don't dip into page reserves".

Plus it future-safes us against changes in GFP_ATOMIC.

I'll make that change.
