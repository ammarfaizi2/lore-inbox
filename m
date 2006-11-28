Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934540AbWK1CjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934540AbWK1CjF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 21:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934541AbWK1CjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 21:39:05 -0500
Received: from tomts13.bellnexxia.net ([209.226.175.34]:54521 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S934540AbWK1CjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 21:39:02 -0500
Date: Mon, 27 Nov 2006 21:33:50 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 3/16] LTTng 0.6.36 for 2.6.18 : Linux Kernel Markers
Message-ID: <20061128023349.GA2964@Krystal>
References: <20061124215401.GD25048@Krystal> <y0mu00kpawa.fsf@ton.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <y0mu00kpawa.fsf@ton.toronto.redhat.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 21:26:45 up 96 days, 23:34,  3 users,  load average: 0.42, 0.25, 0.14
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Frank Ch. Eigler (fche@redhat.com) wrote:
> One question:
> 
> > [...]
> > +	/* Markers in modules. */ 
> > +	list_for_each_entry(mod, &modules, list) {
> > +		if (mod->license_gplok)
> > +			found += marker_set_probe_range(name, format, probe,
> > +				mod->markers, mod->markers+mod->num_markers);
> > +	}
> > [...]
> > +EXPORT_SYMBOL(marker_set_probe);
> 
> Are you sure the license_gplok check is necessary here?  We should
> consider encouraging non-gpl module writers to instrument their code,
> to give users a slightly better chance of debugging problems.
> 

Hi Frank,

I was kind of expecting this question. Well, it turns out that my markers module
modifies the struct module in module.h to add a few fields. Some drivers that I
won't name (ok, ok I will : clearcase) have the funny habit of distributing
their kernel modules as ".ko" files instead of sending a proper ".o" and later
link it against a wrapper.

The result is, I must say, quite bad : when I want to add a probe, I iterate on
each modules, verifying if there are any markers in the object. Things gets
really messy when the structure is corrupted.

The simplest way to work around this non-GPL problem is to completely disable
access to the marker infrastructure to non-GPL modules. I am not against
instrumentation of binary-only modules, but I don't think it is kernel
developer's job to support their broken binary blob distribution.

I thought that we might use the crc checksum as another criterion. As long as
the machines do not crash when adding markers when such modules are loaded.

Regards,

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
