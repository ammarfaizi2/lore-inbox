Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUG0Ue6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUG0Ue6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266614AbUG0Ue6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:34:58 -0400
Received: from gprs214-61.eurotel.cz ([160.218.214.61]:51072 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266619AbUG0Uex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:34:53 -0400
Date: Tue, 27 Jul 2004 22:34:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Avi Kivity <avi@exanet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS server on local NFS mount
Message-ID: <20040727203438.GB2149@elf.ucw.cz>
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4106B992.8000703@exanet.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>On heavy write activity, allocators wait synchronously for kswapd to
> >>free some memory. But if kswapd is freeing memory via a userspace NFS
> >>server, that server could be waiting for kswapd, and the system seizes
> >>instantly.
> >>
> >>This patch (against RHEL 2.4.21-15EL, but should apply either 
> >>literally
> >>or conceptually to other kernels) allows a process to declare itself 
> >>as
> >>kswapd's little helper, and thus will not have to wait on kswapd.
> >>   
> >>
> >
> >Ok, but what if its memory runs out, anyway?
> >
> > 
> >
> Tough. What if kswapd's memory runs out?

I'd hope that kswapd was carefully to make sure that it always has
enough pages...

...it is harder to do the same auditing with userland program.

> A more complete solution would be to assign memory reserve levels below 
> which a process starts allocating synchronously. For example, normal 
> processes must have >20MB to make forward progress, kswapd wants >15MB 
> and the NFS server needs >10MB. Some way would be needed to express the 
> dependencies.

Yes, something like that would be neccessary. I believe it would be
slightly more complicated, like

"NFS server needs > 10MB *and working kswapd*", so you'd need 25MB in
fact... and this info should be stored in some readable form so that
it can be checked.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
