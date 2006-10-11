Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWJKFiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWJKFiP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 01:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWJKFiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 01:38:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26812 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932440AbWJKFiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 01:38:15 -0400
Date: Tue, 10 Oct 2006 22:38:01 -0700
From: Bryce Harrington <bryce@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Heiko Carstens <heiko.carstens@de.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.19-rc1-mm1:  fs/file.c138 on ia64
Message-ID: <20061011053801.GA16050@osdl.org>
References: <20060317010412.3243364c.akpm@osdl.org> <20061006231012.GH22139@osdl.org> <20061006162924.344090f8.akpm@osdl.org> <20061007000031.GI22139@osdl.org> <20061007103559.GC30034@elf.ucw.cz> <20061007204220.GB24743@osdl.org> <20061008182941.GA8308@osiris.ibm.com> <20061008191447.GD3788@elf.ucw.cz> <20061011010826.GA15741@osdl.org> <20061010181553.21a5141f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010181553.21a5141f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 06:15:53PM -0700, Andrew Morton wrote:
> On Tue, 10 Oct 2006 18:08:26 -0700
> Bryce Harrington <bryce@osdl.org> wrote:
> > We've noticed a new ia64 issue on the 2.6.19-rc1-mm1 kernel.  It has not
> > occurred on other 2.6.19 kernels we've tested.  We aslo encountered this
> > BUG only on ia64; the x86 and x86_64 systems booted without issue.
> > Apologies if this is already known; I didn't spot it in the list
> > archives.
> > 
> > http://crucible.osdl.org/runs/2511/sysinfo/ita01.console.log
> > 
> > Freeing unused kernel memory: 1840kB freed
> > kernel BUG at fs/file.c:138!
> 
> Was that with
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/hot-fixes
> applied?

Vadim Lobanov <vlobanov@speakeasy.net> writes:
> Dave, Olof, Linas, Bryce,
> 
> Could you please test the patch at the bottom of the email to see if it
> makes your computers happy again, if you have the time and inclination
> to do so?


I've run the tests with the hotfix and with Vadim's patch.  Here are the
results of compiling, booting, and running the hotplug-cpu test on it:

 run   patch(es)                                  result
 2511  2.6.19-rc1-mm1                             BUG at fs/file.c:138
 2519  2.6.19-rc1-mm1 + hot-fix                   PASS
 2521  2.6.19-rc1-mm1 + vadim's patch             PASS
 2520  2.6.19-rc1-mm1 + hot-fix + vadim's patch   patch doesn't apply

Results available at http://crucible.osdl.org/runs/$run/

Thanks,
Bryce


