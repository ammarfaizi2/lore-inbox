Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVEEQd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVEEQd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVEEQd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:33:57 -0400
Received: from animx.eu.org ([216.98.75.249]:12683 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261252AbVEEQdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:33:54 -0400
Date: Thu, 5 May 2005 12:33:16 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
Message-ID: <20050505163316.GB17861@animx.eu.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050505004854.GA16550@animx.eu.org> <58cb370e050505031041c2c164@mail.gmail.com> <20050505111324.GA17223@animx.eu.org> <58cb370e050505051360d0588c@mail.gmail.com> <1115304977.23360.83.camel@localhost.localdomain> <20050505153807.GB17724@animx.eu.org> <1115310081.19842.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115310081.19842.89.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > As stated in my last email, I am using EDD.  I only need the legacy heads
> > and sectors.  I can figure out the cylinders by that and the size of the
> > disk.
> 
> Which legacy size do you want though - the partition label, the disks
> opinion this week or the CMOS. They can all be different. Linux used to
> play "guess roughly what Windows might guess".

I think what I wanted got burried in a small geometry war.

> > I have some utils (mkdosfs comes to mind) that do not let the user specify
> > heads/sectors/cyls (it doesn't use cyl actually).
> 
> Presumably they need to follow the MS sequence of guesses then, even on
> non PC systems ? So partition table, cmos, drive in that order if I
> remember rightly.

Not the initial problem.

Let me try to state what I originally wanted.

I am currently using edd to get the legacy heads and sectors then using that
and the size of the disk, I deduce the cylinders.  Works great, no problems.
fdisk will let me specify and it works great.  Ok, so I can do this guessing
game just fine.

Now, i have programs that I can't tell it the geometry (which it does use
and requires to be correct.  My guesses using edd are correct).  I was using
/proc/ide/hdX/settings to tell the kernel what geometry I want so the
programs that can only ask the kernel can get it right.

2.6.12-rc2.  Works great.  But what's this?  it's obsolete?  Ok, it's
obsolete, what is the non-obsolete way of SETTING the geometry.  I looked at
ide.c and there's no HDSETGEO.  I considered writing this myself or
unobsolete the /proc interface for my kernels, but if there's a "right" way
of doing this, I'd rather do it.

If the "right" way is via IOCTL, my scripts are written in perl that do the
bulk of the guess work.

I did not want this to be a geometry flame war.  I realize linux doesn't
give a flying whatever about the geometry (only the number of sectors).  The
systems I'm doing this with run OSs other than linux and they do care (i
wish they didn't!)  I wasn't asking this for someone to tell me I didn't
need it.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
