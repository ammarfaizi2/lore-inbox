Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWFWPxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWFWPxI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWFWPxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:53:08 -0400
Received: from mail.gmx.de ([213.165.64.21]:17893 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751482AbWFWPxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:53:07 -0400
X-Authenticated: #704063
Date: Fri, 23 Jun 2006 17:52:22 +0200
From: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linas Vepstas <linas@austin.ibm.com>, Greg KH <greg@kroah.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Eric Sesterhenn <snakebyte@gmx.de>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Fault tolerance/bad patch, [was Re: [PATCH 29/30] [PATCH] PCI Hotplug: fake NULL pointer dereferences in IBM Hot Plug Controller Driver]
Message-ID: <20060623155222.GA1461@whiterabbit>
References: <11507534883521-git-send-email-greg@kroah.com> <11507534914002-git-send-email-greg@kroah.com> <11507534953044-git-send-email-greg@kroah.com> <11507534983982-git-send-email-greg@kroah.com> <11507535021937-git-send-email-greg@kroah.com> <11507535054091-git-send-email-greg@kroah.com> <11507535082418-git-send-email-greg@kroah.com> <11507535123764-git-send-email-greg@kroah.com> <20060623150442.GK8866@austin.ibm.com> <1151076504.4549.51.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151076504.4549.51.camel@localhost.localdomain>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snake-basket.de
X-Operating-System: Linux/2.6.15-1-686 (i686)
X-Uptime: 17:49:50 up 5 days, 23:40,  1 user,  load average: 0.00, 0.03, 0.01
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> Ar Gwe, 2006-06-23 am 10:04 -0500, ysgrifennodd Linas Vepstas:
> > If someone in the future changes the hotplug core so that it 
> > sometimes returns a null value, this code will potentially crash
> > and/or do other bad things (corrupt, invalid state, etc.)
> > This means that this routine will no longer be "robust" in the face of
> > changes in other parts of the kernel. 
> 
> "Potentially".
> 
> But if you replaced it with
> 
> BUG_ON(value == NULL);
> 
> you'd both clean up the if and improve the reliability even more
> 
> > I can hear the objections:
> > -- Performance. B.S. This routine is not performance critical, it will
> >    get called once a week, once a month or less often; a few extra
> >    cycles are utterly irrelevant.
> 
> (and half the time gcc eliminates the test itself)
> 

I guess the BUG_ON makes more sense than keeping the
check, the reason coverity stumbled across this,
is the debug("get_attention_status - Exit rc[%d] value[%x]\n", rc,
*value); call some lines later, which uses the pointer.
If we just keep the check, we should also put one
around the debug statement

Greetings, Eric
