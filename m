Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWAGFp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWAGFp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 00:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWAGFp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 00:45:27 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:22429 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1030267AbWAGFp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 00:45:27 -0500
Date: Sat, 7 Jan 2006 00:47:52 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys	interface
Message-ID: <20060107054752.GA3184@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Pavel Machek <pavel@suse.cz>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>
References: <20060105221334.GA925@isilmar.linta.de> <20060105222338.GG2095@elf.ucw.cz> <20060105222705.GA12242@isilmar.linta.de> <20060105230849.GN2095@elf.ucw.cz> <20060105234629.GA7298@isilmar.linta.de> <20060105235838.GC3339@elf.ucw.cz> <Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net> <20060106001252.GE3339@elf.ucw.cz> <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net> <20060106085920.GI3339@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106085920.GI3339@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 09:59:21AM +0100, Pavel Machek wrote:
> On ??t 05-01-06 17:37:30, Patrick Mochel wrote:
> > +static ssize_t pm_possible_states_show(struct device * d,
> > +				       struct device_attribute * a,
> > +				       char * buffer)
> > +{
> > +	struct pci_dev * dev = to_pci_dev(d);
> > +	char * s = buffer;
> > +
> > +	s += sprintf(s, "d0");
> > +	if (dev->poss_states[PCI_D1])
> > +		s += sprintf(s, " d1");
> > +	if (dev->poss_states[PCI_D2])
> > +		s += sprintf(s, " d2");
> > +	if (dev->poss_states[PCI_D3hot])
> > +		s += sprintf(s, " d3");
> 
> Could we use same states as rest of code, i.e. "D2" instead of "d2"
> and "D3hot" instead of "d3"?

"D3hot" and "D3cold" most likely going to be removed and replaced with just
"D3" in my next set of changes.  Although this distinction is mentioned in
the spec, d3cold cannot actually be specified.  Rather, D3cold is entered when
the parent bridge is powered off.

Thanks,
Adam

