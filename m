Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTIKOdB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTIKOdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:33:00 -0400
Received: from ns.suse.de ([195.135.220.2]:60828 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261294AbTIKOcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:32:53 -0400
Date: Thu, 11 Sep 2003 16:32:48 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030911163248.15aeaab6.ak@suse.de>
In-Reply-To: <20030911142809.GB20434@redhat.com>
References: <Pine.LNX.4.44.0309110650390.28410-100000@home.osdl.org>
	<1063289641.2967.3.camel@dhcp23.swansea.linux.org.uk>
	<20030911162421.419f4432.ak@suse.de>
	<20030911142809.GB20434@redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 15:28:09 +0100
Dave Jones <davej@redhat.com> wrote:

> On Thu, Sep 11, 2003 at 04:24:21PM +0200, Andi Kleen wrote:
>  > I considered that when writing the patch, but: is_prefetch is a single byte 
>  > memory access for something already in cache. Checking for an Athlon
>  > CPU needs two memory accesses in boot_cpu_data at least (checking vendor
>  > and model) 
> 
> You only need to check it once when the path is first taken, and then
> set a variable that makes you exit as soon as you enter it again.

Checking the variable also an memory access. 

is_prefetch does a few more instructions around the memory access, but these
are completely left in the noise.

The is_prefetch check is likely faster even than checking that variable because
the chances that the EIP is already in cache are much higher than some rarely
used variable.

-Andi
