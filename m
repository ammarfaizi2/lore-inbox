Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVBFMau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVBFMau (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVBFMau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:30:50 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:33443 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261193AbVBFMa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:30:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=GWJ9ir78FcfkAy20eWH5BU/gRCfAFNuuh/+9WY5nt9YWeiPrs8KFzf2LbC20EYMSxWBrnf8nEZCfpN3mrahdU5gHcWLsqs1Ckvi1Ev7NLWXw0TXEmPdzBPn/ePoZuUFd3/dtKRXiujxsW5c54cA6V2Dzkl7rTgp2EPDfwT7z2H8=
Date: Sun, 6 Feb 2005 07:30:15 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Peter Osterlund <petero2@telia.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc3-mm1
Message-ID: <20050206123015.GA15836@caphernaum.rivenstone.net>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Peter Osterlund <petero2@telia.com>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20050204103350.241a907a.akpm@osdl.org> <m3d5vengs2.fsf@telia.com> <1107686024.30303.52.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107686024.30303.52.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 09:33:44PM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2005-02-06 at 11:07 +0100, Peter Osterlund wrote:
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/
> > 
> > It gives me a kernel panic at boot if I have CONFIG_FB_RADEON
> > enabled. If I also have CONFIG_FRAMEBUFFER_CONSOLE enabled, I get this
> > output:
> > 
> >         Unable to handle kernel NULL pointer dereference at virtual address 00000000
> >         ...
> >         PREEMPT
> >         ...
> >         EIP is a strncpy_from_user+0x33/0x47
> >         ...
> >         Call Trace:
> >          getname+0x69/0xa5
> >          sys_open+0x12/0xc6
> >          sysenter_past_esp+0x52/0x75
> >         ...
> >         Kernel panic - not syncing: Attempted to kill init!
> > 
> > If I don't have CONFIG_FRAMEBUFFER_CONSOLE enabled, I get a screen
> > with random junk and some blinking colored boxes, and the machine
> > hangs.
> 
> That's very strange... I don't see what in radeonfb could cause this.
> Just in case, can you try commenting out the call to radeon_pm_init() in
> radeon_base.c, see if it makes any difference (though I don't think so).

    Peter, do you maybe have CONFIG_CC_OPTIMIZE_FOR_SIZE=y?  I just rebuilt
-rc3-mm1 to turn that off, and an Oops in copy_to_user in the i810 DRM
module went away.  That could have just been that it forced a rebuild
with a cold ccache, I guess.

    The completely unrelated Oops in radeonfb I was seeing is gone
now, and it works fine here (BTW).

-- 
Joseph Fannin
jfannin@gmail.com
