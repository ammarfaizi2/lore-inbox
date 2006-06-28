Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWF1Tiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWF1Tiq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWF1Tiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:38:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46029 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751066AbWF1Tip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:38:45 -0400
Date: Wed, 28 Jun 2006 15:38:41 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: Re: [PATCH] x86_64: Move export symbols to their C functions
Message-ID: <20060628193841.GA22587@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ak@suse.de
References: <200606261902.k5QJ2R93008443@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606261902.k5QJ2R93008443@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 07:02:27PM +0000, Linux Kernel wrote:
 > commit 2ee60e17896c65da1df5780d3196c050bccb7d10
 > tree 54b41b23c92a79e44c7f27c697c84c64052cb85d
 > parent 45486f81c9aa07218b73a38cbcf62ffa66e99088
 > author Andi Kleen <ak@suse.de> Mon, 26 Jun 2006 13:59:44 +0200
 > committer Linus Torvalds <torvalds@g5.osdl.org> Tue, 27 Jun 2006 00:48:22 -0700
 > 
 > [PATCH] x86_64: Move export symbols to their C functions
 > 
 > Only exports for assembler files are left in x8664_ksyms.c
 > 
 > -
 > -EXPORT_SYMBOL_GPL(set_nmi_callback);
 > -EXPORT_SYMBOL_GPL(unset_nmi_callback);

These two exports were never re-added, which broke modular oprofile.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/arch/x86_64/kernel/nmi.c~	2006-06-28 15:35:34.000000000 -0400
+++ linux-2.6/arch/x86_64/kernel/nmi.c	2006-06-28 15:36:12.000000000 -0400
@@ -607,11 +607,13 @@ void set_nmi_callback(nmi_callback_t cal
 	vmalloc_sync_all();
 	rcu_assign_pointer(nmi_callback, callback);
 }
+EXPORT_SYMBOL_GPL(set_nmi_callback);
 
 void unset_nmi_callback(void)
 {
 	nmi_callback = dummy_nmi_callback;
 }
+EXPORT_SYMBOL_GPL(unset_nmi_callback);
 
 #ifdef CONFIG_SYSCTL
 

-- 
http://www.codemonkey.org.uk
