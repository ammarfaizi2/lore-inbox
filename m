Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTKTSJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 13:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTKTSJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 13:09:07 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:13840
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id S262687AbTKTSJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 13:09:03 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A34047@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org,
       "'Marek Michalkiewicz'" <marekm@amelek.gda.pl>,
       "'Russell King'" <rmk@arm.linux.org.uk>
Subject: RE: 2.4.x parport_serial link order bug (only works as a module)
Date: Thu, 20 Nov 2003 10:09:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

on Thu, November 20, 2003 at 7:23 AM, Marek Michalkiewicz wrote:
> I've just looked at the 2.4.x changelog (up to 2.4.23-rc2) and still
> don't see any fix for the parport_serial link order bug fix.  Without
> it, the driver (which handles various PCI multi I/O serial+parallel
> cards) only works as a module (broken when compiled into the kernel,
> because parport_serial must be initialised after serial).
> 
> I've tried to submit the fix a few times since 2.4.19 or so, with
> no success so far.  Is there any hope that it would go into 2.4.23?
> 
> The patch is here (can be updated to 2.4.23-rc if you are interested):
> 
> http://www.amelek.gda.pl/linux-patches/2.4.21/00_parport_serial
> 
> Quite big, but the largest part of it simply moves parport_serial.c
> from drivers/parport/ to drivers/char/ without changing a single line
> inside the file.  Really, no 2-line local root backdoors inserted ;-)
> 
> In the same directory, you can also find the NetMos patch, 
> which should
> be applied after the parport_serial link order bugfix patch.  Yes, I'm
> still using a few NM9835 cards, no problems except having to 
> patch each
> kernel version forever.  This boring task would be easier for me if at
> least the simple parport_serial link order fix would be accepted...

Russell King looked at this about a year ago and found no specific flaw with
moving the parport_serial.c file from drivers/parport/ to drivers/char to
solve the ordering issue: 

On Mon, Sep 30, 2002 at 2:49 AM, Russell King wrote:
[snip] 
> Other than it's a gross hack rather than a fix.  However, for 2.4, I
> think this is probably the best solution without creating a risk of
> other init ordering problems.  Ed, any comments?
> 
> In 2.5, its easier to solve; we just need to make sure serial is
> initialised before parport.  This is easy, since serial now has its
> own drivers/serial subdirectory.

I think it should go into 2.4. It fixes this particular ordering issue
without mucking about with the ordering mechanism or even adding code. I'm
sorry to say that I had forgotten about it. It's a good minimum-change
brute-force umm... solution. No bloat or complexity issues. 

At your convenience, please move the parport_serial.c file and apply the
corresponding Makefile changes. 

cheers,
Ed Vance
