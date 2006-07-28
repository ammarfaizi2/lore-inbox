Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751994AbWG1PAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbWG1PAP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWG1PAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:00:15 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:43678 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751994AbWG1PAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:00:13 -0400
Date: Fri, 28 Jul 2006 16:59:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH/RFC] kconfig/lxdialog: make lxdialof a built-in
Message-ID: <20060728145947.GA29095@mars.ravnborg.org>
References: <20060727202726.GA3900@mars.ravnborg.org> <Pine.LNX.4.64.0607281348420.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607281348420.6761@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 04:09:03PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 27 Jul 2006, Sam Ravnborg wrote:
> 
> > Dedided to take another stamp on an old TODO item of making lxdialog
> > a built-in. Following patch is first step to do so.
> > The patch makes it a built-in - but with two open issues that I yet
> > have to address.
> 
> Looks good. :)
> There is a NULL pointer problem with empty menus, item_cur is NULL and a 
> select or exit will cause a segfault in item_set_selected().
Fixed. Introduced a dummy variable "item_nil" that item_cur points to in
the empty case. So no need for special cases all over.

> 
> > I will during the weekend try to address the resize issue.
> 
> Wasn't it working at some point?
> Anyway, it doesn't has to be overly complex either, e.g. if you delay it 
> to the next key event, it's fine too. The signal handler would just set a 
> flag and when wgetch returns, the display is reinitialized.
My experiments so far tells me that a resize generates KEY_RESIZE so it
is a simple matter of handling KEY_RESIZE correct in the different
dialog_* functions - and no signal handler needed. Thats looks like the
approach taken in the dialog package too.


> 
> > The double ESC ESC thing I dunno how to fix.
> 
> I think the easiest would be to just ignore the first ESC, it matches the 
> documented behaviour and e.g. mc has the same behaviour. The delay of the 
> single ESC makes it a bit annoying/confusing to use, so that sticking to 
> the double ESC is IMO safer.
> I played with it a little and below is an example, which implements this 
> behaviour for the menu window. 

Thanks - will implment this for all the dialog_* functions.

	Sam
