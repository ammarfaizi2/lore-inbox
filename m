Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268468AbUJOVj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268468AbUJOVj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268467AbUJOVj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:39:27 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:64265 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S268468AbUJOVjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:39:13 -0400
Date: Fri, 15 Oct 2004 23:44:51 +0200
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       penguinppc-team@lists.penguinppc.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041015214451.GA4739@hh.idb.hist.no>
References: <416E6ADC.3007.294DF20D@localhost> <416FB624.31033.1D23BE5@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416FB624.31033.1D23BE5@localhost>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 11:36:04AM -0700, Kendall Bennett wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> 
[...]
> > Having video BOOT would be great, and please make it independent of
> > the framebuffer drivers.  
> 
> Right now it is independent but I added a single line of code to the 
> Radeon driver to init the card prior to initing the rest of the driver. 

That's fine.  What I meant, was please make it independent
of the VESA framebuffer driver, because one might want to use an
acellerated driver when one is available.

> It can be done earlier than that inside fbmem.c, but I wasn't sure how to 
> set up the code so it would only POST each card as it is needed as I 
> don't want to bring up secondary controllers unless the user actually 
> wants this.
> 
Selecting which cards to "boot" can probably be done with a
kernel parameter?  The default could be to bring up all cards
except the one the bios brought up already.  Wanting to _not_
bring up some cards seems to be the unusual case to me.

> How does the framebuffer console system handle secondary controllers 
> right now? It seems from my look at the code that it only brings up the 
> primary and not the secondary?
> 
The stock 2.6.x fbcon only use one framebuffer console.  I use the ruby
patch which supports multiple consoles.  The ruby patch for
2.6.7 support multiple fbcons so you can have several keyboards
attached to separate framebuffers thus supporting several users.
(VT1-VT16 is the first kbd on the first fbcon,
VT17-VT32 is the second kbd on the second fbcon, and so on.)

The ruby patch for 2.6.8.1 is somewhat broken, and doesn't work with fbcon.
It still support multiple keyboards and multiple framebuffers, so
I can support several users with separate xservers but currently not
gettys on separate fbcons.

Note that soft-booting the "extra" video card in order to support
a framebuffer driver is nice even if it doesn't attach to 
the console, because there is other software that can utilize
a framebuffer.  X is the most well-known of them.

Helge Hafting

