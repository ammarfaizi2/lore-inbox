Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbULIVxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbULIVxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 16:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbULIVxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 16:53:15 -0500
Received: from peabody.ximian.com ([130.57.169.10]:48300 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261632AbULIVxK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 16:53:10 -0500
Subject: Re: Question from Russells Spinlocks
From: Robert Love <rml@novell.com>
To: kernel-stuff@comcast.net
Cc: Imanpreet Singh Arora <imanpreet@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <120920042115.25628.41B8C082000394E30000641C220076219400009A9B9CD3040A029D0A05@comcast.net>
References: <120920042115.25628.41B8C082000394E30000641C220076219400009A9B9CD3040A029D0A05@comcast.net>
Content-Type: text/plain
Date: Thu, 09 Dec 2004 16:49:41 -0500
Message-Id: <1102628981.4622.9.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 21:15 +0000, kernel-stuff@comcast.net wrote:

This part is incorrect (and horribly wrapped):

>  The comment about  atomic_t - It is due to the fact that some ( IA-32 for e.g.) architectures guarantees atomicity of integer operations for only 24 bits. So you could possibly manipulate only 24 out of the 32 bits atomically - that's the hardware guarantee. The comments reflect this fact. (Pointers are 32bits on IA32 so it applies to pointer as well.)

The reason for the 24-bit limit on atomic_t is because SPARC32's
implementation of atomic operations was limited to 24-bits per atomic
integer, because the architecture provides very minimal atomic support,
we had to embed a byte-sized lock in the word.  This limited SPARC32's
atomic integer to 24 usable bits.  The other architectures can, of
course, hold the full 32-bits but to be compatible code must assume the
24-bit limit.

Although this was fixed recently in 2.6 so it actually no longer
applies.

	Robert Love


