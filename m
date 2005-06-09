Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVFIPMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVFIPMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 11:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVFIPMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 11:12:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11788 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261535AbVFIPMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 11:12:30 -0400
Date: Thu, 9 Jun 2005 16:12:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: Frederik Deweerdt <dev.deweerdt@laposte.net>, linux-kernel@vger.kernel.org
Subject: Re: [TTY] exclusive mode question
Message-ID: <20050609161225.A14513@flint.arm.linux.org.uk>
Mail-Followup-To: moreau francis <francis_moreau2000@yahoo.fr>,
	Frederik Deweerdt <dev.deweerdt@laposte.net>,
	linux-kernel@vger.kernel.org
References: <20050609121638.GD507@gilgamesh.home.res> <20050609142250.80926.qmail@web25804.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050609142250.80926.qmail@web25804.mail.ukl.yahoo.com>; from francis_moreau2000@yahoo.fr on Thu, Jun 09, 2005 at 04:22:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 04:22:49PM +0200, moreau francis wrote:
> --- Frederik Deweerdt <dev.deweerdt@laposte.net> a écrit :
> > Le 09/06/05 13:41 +0200, moreau francis écrivit:
> > > 
> > > oh ok...sorry I misunderstood TIOEXCL meaning ;)
> > > Do you know how I could implement such exclusive mode (the one I described)
> > ?
> > > 
> > This is handled through lock files, google for LCK..ttyS0
> >
> 
> This lock mechanism is a convention but nothing prevent a user application to
> issue a "echo foo > /dev/ttyS0" command while "LCK..ttyS0" file exists...

Which is absolutely necessary to work if you think about an application
like minicom and its file transfer helpers, which may need to re-open
the serial port.

TTY locking is done via lock files only, and all non-helper applications
must coordinate their access via the lock files.  There is no other
mechanism.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
