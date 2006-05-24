Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWEXW4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWEXW4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 18:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWEXW4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 18:56:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:7574 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751040AbWEXW4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 18:56:40 -0400
Date: Wed, 24 May 2006 18:56:31 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [PATCH 00/03] kexec: Avoid overwriting the current pgd (V2)
Message-ID: <20060524225631.GA23291@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524044232.14219.68240.sendpatchset@cherry.local>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 01:40:31PM +0900, Magnus Damm wrote:
> kexec: Avoid overwriting the current pgd (V2)
> 
> This patch updates the kexec code for i386 and x86_64 to avoid overwriting
> the current pgd. For most people is overwriting the current pgd is not a big
> problem. When kexec:ing into a new kernel that reinitializes and makes use of 
> all memory we don't care about saving state.
> 
> But overwriting the current pgd is not a good solution in the case of kdump 
> (CONFIG_CRASH_DUMP) where we want to preserve as much state as possible when 
> a crash occurs. This patch solves the overwriting issue.
> 
> 20060524: V2
> 
> - Broke out architecture-specific data structures into asm/kexec.h
> - Fixed a i386/PAE page table problem only triggering on real hardware.
> - Moved segment handling code into the assembly routines.

What's the advantage of moving segment handling code into assembly
routines? It will only add to the fear of control code page size growing
beyond 4K.

Thanks
Vivek
