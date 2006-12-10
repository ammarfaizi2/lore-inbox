Return-Path: <linux-kernel-owner+w=401wt.eu-S1761271AbWLJXSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761271AbWLJXSG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 18:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762254AbWLJXSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 18:18:06 -0500
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72]:46701 "EHLO
	hoboe1bl1.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761271AbWLJXSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 18:18:03 -0500
Date: Mon, 11 Dec 2006 00:18:01 +0100
From: Wouter Verhelst <wouter@grep.be>
To: Pavel Machek <pavel@ucw.cz>
Cc: Paul Clements <paul.clements@steeleye.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: show nbd client pid in sysfs
Message-ID: <20061210231801.GD29943@country.grep.be>
References: <45762745.7010202@steeleye.com> <20061208211723.GC4924@ucw.cz> <20061210180725.GA29943@country.grep.be> <20061210195819.GA32577@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210195819.GA32577@elf.ucw.cz>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 08:58:19PM +0100, Pavel Machek wrote:
> Hi!

Hi

> > > > This simple patch allows nbd to expose the nbd-client 
> > > > daemon's PID in /sys/block/nbd<x>/pid. This is helpful 
> > > > for tracking connection status of a device and for 
> > > > determining which nbd devices are currently in use.
> > > 
> > > Actually is it needed at all? Perhaps nbd clients should be modified
> > > to put nbdX in their process nam?
> > 
> > I don't think that's the right approach; only the kernel can guarantee
> > that a given process is actually managing a given nbd device (I could
> > have some rogue process running around announcing that it's managing
> > nbd2, and then what?)
> 
> I'd say "do not run rogue processes as root" :-).
> 
> nbd-client should run as root -- I do not think interface was
> carefully audited to run it as a user -- so rogue process should not
> really be a problem.

IOW, you're suggesting I walk the process list from userspace to find a
process for which a) it claims it's running for a given nbd device, and
b) I can verify that it actually has the permissions to do so. That's a
whole lot of code in comparison to

f=open("/sys/block/nbd2/pid", O_RDONLY);
read(f,buf,len);

I think I very much prefer the above two lines, not only for simplicity.

Also, your suggestion relies on users /only/ using the official
nbd-client, and is fragile in cases where that assumption is false
(i.e., it's susceptible to false negatives). The suggested patch does
not have that problem.

-- 
<Lo-lan-do> Home is where you have to wash the dishes.
  -- #debian-devel, Freenode, 2004-09-22
