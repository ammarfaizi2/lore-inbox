Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUAPOsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbUAPOsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:48:54 -0500
Received: from gprs214-224.eurotel.cz ([160.218.214.224]:7296 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265141AbUAPOsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:48:14 -0500
Date: Fri, 16 Jan 2004 15:47:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       kgdb-bugreport@lists.sourceforge.net, mpm@selenic.com,
       discuss@x86-64.org, george@mvista.com
Subject: Re: [discuss] KGDB 2.0.3 with fixes and development in ethernet interface
Message-ID: <20040116144736.GF2535@elf.ucw.cz>
References: <200401161759.59098.amitkale@emsyssoft.com> <20040116140551.2da2815b.ak@suse.de> <200401161951.51597.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401161951.51597.amitkale@emsyssoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > > KGDB 2.0.3 is available at
> > > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> > >
> > > Ethernet interface still doesn't work. It responds to gdb for a couple of
> > > packets and then panics. gdb log for ethernet interface is pasted below.
> >
> > Did you add the fix for netpoll Jim posted?
> 
> I am not using netpoll (yet). My patch doesn't require any driver 
> modifications, that the mm ethernet patch required.

int kgdbeth_event(struct notifier_block * self, unsigned long val,
void * data)
{
        if (strcmp(((struct net_device *)data)->name, "eth0")) {
                goto out;
        }
        if (val!= NETDEV_UP)
                goto out;

Do I read it correctly as "eth0 is not to be used for debugging"? So
if I only have eth0 here, I have to comment it out, right?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
