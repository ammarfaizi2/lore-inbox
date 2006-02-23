Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWBWATW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWBWATW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWBWATW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:19:22 -0500
Received: from kanga.kvack.org ([66.96.29.28]:24284 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751488AbWBWATW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:19:22 -0500
Date: Wed, 22 Feb 2006 19:14:11 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: klibc@zytor.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sys_mmap2 on different architectures
Message-ID: <20060223001411.GA20487@kvack.org>
References: <43FCDB8A.5060100@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FCDB8A.5060100@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 01:45:46PM -0800, H. Peter Anvin wrote:
> I've looked through the code for sys_mmap2 on several architectures, and 
> it looks like some architectures plays by the "shift is always 12" rule, 
>  e.g. SPARC, and some expect userspace to actually obtain the page 
> size, e.g. PowerPC and MIPS.  On some architectures, e.g. x86 and ARM, 
> the point is moot since PAGE_SIZE is always 2^12.

The sys_mmap2() ABI is that the page shift is always fixed to whatever 
page size is reasonable for the architecture, typically 2^12.  The syscall 
should never be exposed as mmap2(), only as the large file size version 
of mmap() (aka mmap64()).  The other consideration is that it should not 
be implemented in 64 bit ABIs, as those machines should be using a 64 bit 
native mmap().  Does that clear things up a bit?  Cheers,

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
