Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbUKWCnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbUKWCnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbUKWCle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:41:34 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:18823 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261170AbUKWCkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:40:25 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: "Deepak Kumar Gupta, Noida" <dkumar@hcltech.com>
Cc: "'Robin Holt '" <holt@sgi.com>,
       "''lilbilchow@yahoo.com' '" <lilbilchow@yahoo.com>,
       "''ananth@sgi.com' '" <ananth@sgi.com>,
       "''linux-kernel@vger.kernel.org' '" <linux-kernel@vger.kernel.org>,
       "''linux-ia64@vger.kernel.org' '" <linux-ia64@vger.kernel.org>
Subject: Re: smp_call_function/flush_tlb_all hang on large memory system 
In-reply-to: Your message of "Tue, 23 Nov 2004 07:41:07 +0530."
             <267988DEACEC5A4D86D5FCD780313FBB2BFBB6@exch-03.noida.hcltech.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Nov 2004 13:36:38 +1100
Message-ID: <12621.1101177398@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has always been an error to call smp_call_function() with interrupts
disabled.  Recent 2.6 kernels check for this and issue a warning.  The
problem is not smp_call_function() or flush_tlb_all(), it is the code
that called them with interrupts disabled.  Find the calling code and
fix it to not disable interrupts.

