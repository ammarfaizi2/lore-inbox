Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWI3Vzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWI3Vzu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 17:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWI3Vzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 17:55:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751347AbWI3Vzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 17:55:49 -0400
Date: Sat, 30 Sep 2006 14:55:44 -0700
From: Bryce Harrington <bryce@osdl.org>
To: "Moore, Eric" <Eric.Moore@lsil.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [OOPS] -git8,9:  NULL pointer dereference in mptspi_dv_renegotiate_work
Message-ID: <20060930215544.GB7957@osdl.org>
References: <664A4EBB07F29743873A87CF62C26D70350500@NAMAIL4.ad.lsil.com> <20060930002755.GI12968@osdl.org> <664A4EBB07F29743873A87CF62C26D702A994F@NAMAIL4.ad.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <664A4EBB07F29743873A87CF62C26D702A994F@NAMAIL4.ad.lsil.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 10:22:50PM -0600, Moore, Eric wrote:
> On Fri 9/29/2006 6:27 PM, Bryce Harrington wrote:
> 
> > Does this look better?
> >
> >    http://crucible.osdl.org/runs/2265/sysinfo/amd01.3.console
> 
> 
> It appears that the problem is we're not receiving interrupts.
> The first command after interrupts enabled is not getting a response
> back from firmware, thus timing out.   I noticed in the log its
> saying interrupt is at 185, but apparently the INT line is not getting
> raised.  
> 
> In addition, I understand why the panic.  You've compiled the drivers
> into the kernel, instead of module.  i.e. if you compiled as module, 
> mptspi wouldn't been called while mptbase is loaded, as in your case.
> I guess we would need to add sanity check for that case. I'm usually
> testing as modules.

Ah, that could explain it; when doing testing we do compile everything
in.  So it sounds like we could eliminate the panic by compiling as a
module, however is it intended that the driver should work when compiled
in as well?  If so, I'd be happy to do additional testing to verify any
fixes worth trying out.

> Besides, we need to undertand why your interrupt controller is not
> generating interrupts.

We typically boot every -mm, -git, -rc and mainline kernel on this
machine, but it's only been relatively recently that this particular
behavior has occurred.  Could this suggest that there was a regression
due to recent changes?

Thanks,
Bryce
