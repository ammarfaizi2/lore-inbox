Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVFJQZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVFJQZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVFJQZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:25:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64012 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262602AbVFJQY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:24:27 -0400
Date: Fri, 10 Jun 2005 17:24:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       Frederik Deweerdt <dev.deweerdt@laposte.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [TTY] exclusive mode question
Message-ID: <20050610172420.B18927@flint.arm.linux.org.uk>
Mail-Followup-To: moreau francis <francis_moreau2000@yahoo.fr>,
	Denis Vlasenko <vda@ilport.com.ua>,
	Frederik Deweerdt <dev.deweerdt@laposte.net>,
	linux-kernel@vger.kernel.org
References: <200506101003.24835.vda@ilport.com.ua> <20050610093654.94565.qmail@web25806.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050610093654.94565.qmail@web25806.mail.ukl.yahoo.com>; from francis_moreau2000@yahoo.fr on Fri, Jun 10, 2005 at 11:36:54AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 11:36:54AM +0200, moreau francis wrote:
> 
> --- Denis Vlasenko <vda@ilport.com.ua> a écrit :
> 
> > On Thursday 09 June 2005 18:12, Russell King wrote:
> > > On Thu, Jun 09, 2005 at 04:22:49PM +0200, moreau francis wrote:
> > > > --- Frederik Deweerdt <dev.deweerdt@laposte.net> a écrit :
> > > > > Le 09/06/05 13:41 +0200, moreau francis écrivit:
> > > > > > 
> > > > > > oh ok...sorry I misunderstood TIOEXCL meaning ;)
> > > > > > Do you know how I could implement such exclusive mode (the one I
> > described)
> > > > > ?
> > > > > > 
> > > > > This is handled through lock files, google for LCK..ttyS0
> > > > >
> > > > 
> > > > This lock mechanism is a convention but nothing prevent a user
> > application to
> > > > issue a "echo foo > /dev/ttyS0" command while "LCK..ttyS0" file exists...
> > > 
> > > Which is absolutely necessary to work if you think about an application
> > > like minicom and its file transfer helpers, which may need to re-open
> > > the serial port.
> > > 
> > > TTY locking is done via lock files only, and all non-helper applications
> > > must coordinate their access via the lock files.  There is no other
> > > mechanism.
> > 
> > I think original reporter is saying that TIOEXCL is nearly useless then.
> >
> 
> Why not using mandatory locks instead of this "weak" user lock mechanism ?

As I've already said - helper applications.

There's another case as well.  Consider the following:

- getty is listening on the serial port for an incoming modem call
  (eg, mgetty)
- you want to make an outgoing call (eg, minicom)

Both have to co-operate with each other via the lock files to ensure
that they don't stomp on each other - and the point at which they claim
the lock is most definitely not at serial port open time.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
