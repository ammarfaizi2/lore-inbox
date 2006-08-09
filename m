Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWHICUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWHICUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWHICUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:20:18 -0400
Received: from mx1.suse.de ([195.135.220.2]:24237 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751252AbWHICUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:20:16 -0400
From: Andi Kleen <ak@suse.de>
To: Magnus Damm <magnus@valinux.co.jp>
Subject: Re: [PATCH 02/06] i386: remove redundant generic_identify() calls when identifying cpus
Date: Wed, 9 Aug 2006 04:20:06 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060809010345.25458.86096.sendpatchset@cherry.local> <20060809010350.25458.46602.sendpatchset@cherry.local>
In-Reply-To: <20060809010350.25458.46602.sendpatchset@cherry.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090420.06156.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 03:03, Magnus Damm wrote:
> i386: remove redundant generic_identify() calls when identifying cpus
> 
> cpu_dev->c_identify is only called from arch/i386/common.c:identify_cpu(), and
> this after generic_identify() already has been called. There is no need to call
> this function twice and hook it in c_identify - but I may be wrong, please
> double check before applying.
> 
> This patch also removes generic_identify() from cpu.h to avoid unnecessary
> future nesting.

There are sometimes subtle interactions with this (e.g. with parameters
changing flags and then someone else overwriting them again)

But agreed it seems bogus to call it twice.

I guess the only way to find out how much it breaks is to merge it.

-Andi

