Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbUANTuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbUANTt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:49:27 -0500
Received: from waste.org ([209.173.204.2]:64674 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264830AbUANTr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:47:26 -0500
Date: Wed, 14 Jan 2004 13:47:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: [patch] arch-specific cond_syscall usage issues
Message-ID: <20040114194706.GI28521@waste.org>
References: <20040110032915.GW18208@waste.org> <20040109193753.3c158b3b.akpm@osdl.org> <20040114161306.GA16950@stop.crashing.org> <20040114113107.786c237a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114113107.786c237a.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 11:31:07AM -0800, Andrew Morton wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> >  As has been previously noted, the cond_syscall is only ever cared about
> >  on PPC when you try for !PCI.  And this only happens realistically now,
> >  on MPC8xx (it's usually present on IBM 4xx, and lets ignore APUS).
> >  MPC8xx support has been broken for a while, but hopefully will get fixed
> >  'soon'.
> > 
> >  So can we please move this cond_syscall into kernel/sys.c ?
> 
> Spose so.  Are we sure it shouldn't be inside soem ppc-specfic ifdef?

Probably not worth the trouble as it's a weak symbol - it can't
interfere with anything. In the unlikely case that some other arch
intends to define it and fails to, well, they'll get sys_ni_syscall
instead. By that logic, I've done the same with some of the stuff I've
made conditional for x86, like sys_vm86 and the like.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
