Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWBTKjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWBTKjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWBTKjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:39:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14255 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964861AbWBTKjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:39:09 -0500
Date: Mon, 20 Feb 2006 11:38:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp/pm: refuse to suspend devices if wrong console is active
Message-ID: <20060220103855.GD16042@elf.ucw.cz>
References: <200602192326.37265.rjw@sisk.pl> <20060219213526.45efd900.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219213526.45efd900.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 19-02-06 21:35:26, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > 1) Remove the console-switching code from the suspend part of the swsusp
> > userland interface and let the userland tools switch the console.
> > 
> > 2) It is unsafe to suspend devices if the hardware is controlled by X.  Add
> > an extra check to prevent this from happening.
> > 
> > ...
> > @@ -82,6 +85,12 @@ int device_suspend(pm_message_t state)
> >  {
> >  	int error = 0;
> >  
> > +	/* It is unsafe to suspend devices while X has control of the
> > +	 * hardware. Make sure we are running on a kernel-controlled console.
> > +	 */
> > +	if (vc_cons[fg_console].d->vc_mode != KD_TEXT)
> > +		return -EINVAL;
> > +
> >  	down(&dpm_sem);
> 
> Does this mean that swsusp simply won't work if invoked while X is running
> and being displayed?  If so, that sounds like a pretty severe limitation.

No, no. Kernel with switch to text console before doing this in swsusp
case, and userspace has to switch to text console before doing this in
uswsusp case.

This is just a sanity check, to guard against misuse by uswsusp
program.

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
