Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935622AbWK1Fkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935622AbWK1Fkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 00:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935624AbWK1Fkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 00:40:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12522 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S935622AbWK1Fko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 00:40:44 -0500
Date: Tue, 28 Nov 2006 05:40:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 3/16] LTTng 0.6.36 for 2.6.18 : Linux Kernel Markers
Message-ID: <20061128054036.GA29273@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mathieu Desnoyers <compudj@krystal.dyndns.org>,
	"Frank Ch. Eigler" <fche@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <zanussi@us.ibm.com>,
	Karim Yaghmour <karim@opersys.com>,
	Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
	Richard J Moore <richardj_moore@uk.ibm.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Michel Dagenais <michel.dagenais@polymtl.ca>,
	Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
	systemtap@sources.redhat.com
References: <20061124215401.GD25048@Krystal> <y0mu00kpawa.fsf@ton.toronto.redhat.com> <20061128023349.GA2964@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128023349.GA2964@Krystal>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 09:33:50PM -0500, Mathieu Desnoyers wrote:
> * Frank Ch. Eigler (fche@redhat.com) wrote:
> > One question:
> > 
> > > [...]
> > > +	/* Markers in modules. */ 
> > > +	list_for_each_entry(mod, &modules, list) {
> > > +		if (mod->license_gplok)
> > > +			found += marker_set_probe_range(name, format, probe,
> > > +				mod->markers, mod->markers+mod->num_markers);
> > > +	}
> > > [...]
> > > +EXPORT_SYMBOL(marker_set_probe);
> > 
> > Are you sure the license_gplok check is necessary here?  We should
> > consider encouraging non-gpl module writers to instrument their code,
> > to give users a slightly better chance of debugging problems.
> > 
> 
> Hi Frank,
> 
> I was kind of expecting this question. Well, it turns out that my markers module
> modifies the struct module in module.h to add a few fields. Some drivers that I
> won't name (ok, ok I will : clearcase) have the funny habit of distributing
> their kernel modules as ".ko" files instead of sending a proper ".o" and later
> link it against a wrapper.
> 
> The result is, I must say, quite bad : when I want to add a probe, I iterate on
> each modules, verifying if there are any markers in the object. Things gets
> really messy when the structure is corrupted.
> 
> The simplest way to work around this non-GPL problem is to completely disable
> access to the marker infrastructure to non-GPL modules. I am not against
> instrumentation of binary-only modules, but I don't think it is kernel
> developer's job to support their broken binary blob distribution.
> 
> I thought that we might use the crc checksum as another criterion. As long as
> the machines do not crash when adding markers when such modules are loaded.

Please don't add hacks like that for non-GPL modules.  But neither
should we export any tracing functionality for them.  They;re not the
kind of people we want to help at all, and Frank just shows once again that
he should rather stay away from kernel stuff and keep on writing C++.
