Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbUDPQWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUDPQWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:22:52 -0400
Received: from holomorphy.com ([207.189.100.168]:50566 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263372AbUDPQWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:22:50 -0400
Date: Fri, 16 Apr 2004 09:22:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mikkel Christiansen <mixxel@cs.auc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfree in timerfunciton causes  kernel crash
Message-ID: <20040416162243.GR743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mikkel Christiansen <mixxel@cs.auc.dk>,
	linux-kernel@vger.kernel.org
References: <4080058A.8090607@cs.auc.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4080058A.8090607@cs.auc.dk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 06:10:50PM +0200, Mikkel Christiansen wrote:
> Idea: a module allocates memory (vmalloc) for userspace program which 
> then craches.
> Due to lack of activity timer is  expires and free's the unused memory 
> (vfree).
> (see tc_core.c later in this mail for details)
> Problem: when timer expires and vfree is called then kernel crashes -
> or rather freezes silently.
> Can anyone explain why this happens? a kernel bug?
> Cheers
>    Mikkel
> kernel 2.6.5

Use schedule_work() to do this from process context. It's a programming
error (specifically a deadlock) to vfree() from interrupt context or with
interrupts disabled.


-- wli
