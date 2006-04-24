Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWDXJMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWDXJMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 05:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWDXJMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 05:12:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46049 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751132AbWDXJMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 05:12:24 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Arjan van de Ven <arjan@infradead.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060424085456.GL440@marowsky-bree.de>
References: <20060417195146.GA8875@kroah.com>
	 <1145309184.14497.1.camel@localhost.localdomain>
	 <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
	 <4445484F.1050006@novell.com> <20060420211308.GB2360@ucw.cz>
	 <444AF977.5050201@novell.com>
	 <200604230933.k3N9XTZ8019756@turing-police.cc.vt.edu>
	 <20060423145846.GA7495@thorium.jmh.mhn.de>
	 <20060424082831.GI440@marowsky-bree.de>
	 <1145867837.3116.7.camel@laptopd505.fenrus.org>
	 <20060424085456.GL440@marowsky-bree.de>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 11:12:22 +0200
Message-Id: <1145869942.3116.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 10:54 +0200, Lars Marowsky-Bree wrote:
> > > Seriously, this is not helpful. Could we instead focus on the
> > > technical argument wrt the kernel patches?
> > I disagree with your stance here; trying to poke holes in the
> > mechanism IS useful and important. In addition to looking at the
> > kernel patches. 
> 
> I agree, sort-of. Yet, I'd argue that the holes tried to poke here rely
> on the admin being sloppish not with regular operation, but _while
> configuring the security policy_. The only way to protect against that
> is to shoot the admin on sight.

yet exploring this space is worthwhile to a certain degree to find the
edges and see if there's a valid issue. Killing the discussion
prematurely makes no sense (but giving too much value to it doesn't make
too much sense either)

> al will work to incorporate all feedback received. I don't think we're
> in any rush, and even if LSM _is_ ripped out, that just means that the
> patch series will be augmented with a further patch [01/xx] "Reinstate
> LSM hooks w/additional provisions to address code cleanliness."

Now that the second user is laid bare, I do think it's a valid thing to
at least reevaluate the current state of LSM. So far it appears to not
really be the right interface for AppArmor, and it's also not really the
right interface for SELinux. And it has downsides in its design (the
function pointer tree is just a major source for sucky performance;
processors regardless of vendor don't like function pointer calls much).

So at minimum a debate about most the hooks is in order, as well as the
mechanism; I'm increasingly getting convinced the 'security_ops' thing
is misdesigned. I rather have a setup where the hooks at compiletime
resolve to the function of the LSM you've chosen (be it SELinux or
AppArmor) rather than the current solution. It's not like you
realistically can or want to provide both SELinux and AppArmor with the
same kernel anyway.. 

