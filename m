Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264999AbUD2WdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264999AbUD2WdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265010AbUD2WdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:33:20 -0400
Received: from [66.35.79.110] ([66.35.79.110]:57999 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S264999AbUD2WdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:33:12 -0400
Date: Thu, 29 Apr 2004 15:32:57 -0700
From: Tim Hockin <thockin@hockin.org>
To: Marc Boucher <marc@linuxant.com>
Cc: koke@sindominio.net, Paul Wagland <paul@wagland.net>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Rik van Riel <riel@redhat.com>,
       David Gibson <david@gibson.dropbear.id.au>,
       Timothy Miller <miller@techsource.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040429223257.GA25166@hockin.org>
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net> <4091757B.3090209@techsource.com> <200404292347.17431.koke_lkml@amedias.org> <0CAE0144-9A2C-11D8-B83D-000A95BCAC26@linuxant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0CAE0144-9A2C-11D8-B83D-000A95BCAC26@linuxant.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 06:24:58PM -0400, Marc Boucher wrote:
> The inherent instability of binary modules is a religious myth. Any 

No, it's REAL, unless VERY CAREFULLY handled.  If your binary uses a
spinlock, it either works only on SMP or only on UP.  If your binary uses
any number of kernel structures and interfaces, you are subject to the
whims of whomever compiled the kernel.  spinlock debuging changes the
sizeof(spinlock_t).  Some APIs become macros or inlines depending on
config options.

You have to toally separate all the kernel code from the binary code. If
you can't do that, you end up with a kernel module that works ONLY on a
very small subset of kernels.  And that sucks.  We don't want to encourage
that.  If your driver manages to cleanly pull out all the binary gunk from
the kernel gunk, then kudos to you.

I still don't like it, but at least it has a chance of running.

