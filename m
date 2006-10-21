Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992784AbWJUSOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992784AbWJUSOq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993114AbWJUSOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:14:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53161 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S2992784AbWJUSOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:14:45 -0400
Date: Sat, 21 Oct 2006 14:14:40 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [patches] Re: [PATCH] [14/19] i386: Disable nmi watchdog on all ThinkPads
Message-ID: <20061021181440.GG30758@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	patches@x86-64.org, linux-kernel@vger.kernel.org
References: <20061021651.356252000@suse.de> <20061021165134.7ADBB13CB4@wotan.suse.de> <20061021172401.GD30758@redhat.com> <200610212011.56215.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610212011.56215.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 08:11:56PM +0200, Andi Kleen wrote:
 > 
 > >  > -	if (nmi_watchdog == NMI_DEFAULT && dmi_get_year(DMI_BIOS_DATE) >= 2004)
 > >  > +	   Probably safe on most older systems too, but let's be careful.
 > >  > +	   IBM ThinkPads use INT10 inside SMM and that allows early NMI inside SMM
 > >  > +	   which hangs the system. Disable watchdog for all thinkpads */
 > >  > +	if (nmi_watchdog == NMI_DEFAULT && dmi_get_year(DMI_BIOS_DATE) >= 2004 &&
 > >  > +		!dmi_name_in_vendors("ThinkPad"))
 > >  >  		nmi_watchdog = NMI_LOCAL_APIC;
 > > 
 > > This is going to get some people scratching their heads wondering
 > > why it isn't working if they ever try nmi_watchdog on one of these.
 > > How about adding an explanitory printk ?
 > 
 > When you enable it manually then NMI_DEFAULT won't be set and this code
 > is never executed.
 > 
 > BTW their machines will likely not stay up long enough that they can
 > see the printk (unless Lenovo fixes that particular bug in the future,
 > they are aware of it)

Ouch, nasty.  I'm surprised no-one complained about this earlier.

	Dave


-- 
http://www.codemonkey.org.uk
