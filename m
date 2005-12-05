Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVLERa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVLERa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVLERa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:30:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63207 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932480AbVLERay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:30:54 -0500
Date: Mon, 5 Dec 2005 12:30:41 -0500
From: Dave Jones <davej@redhat.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Add tainting for proprietary helper modules.
Message-ID: <20051205173041.GE12664@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	linux-kernel@vger.kernel.org
References: <20051203004102.GA2923@redhat.com> <Pine.LNX.4.61.0512050832290.27133@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512050832290.27133@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 08:41:57AM -0500, linux-os (Dick Johnson) wrote:
 > 
 > On Fri, 2 Dec 2005, Dave Jones wrote:
 > 
 > > Kernels that have had Windows drivers loaded into them are undebuggable.
 > > I've wasted a number of hours chasing bugs filed in Fedora bugzilla
 > > only to find out much later that the user had used such 'helpers',
 > > and their problems were unreproducable without them loaded.
 > >
 > > Acked-by: Arjan van de Ven <arjan@infradead.org>
 > > Signed-off-by: Dave Jones <davej@redhat.com>
 > >
 > > --- linux-2.6.14/kernel/module.c~	2005-11-29 16:44:00.000000000 -0500
 > > +++ linux-2.6.14/kernel/module.c	2005-11-29 17:03:55.000000000 -0500
 > > @@ -1723,6 +1723,11 @@ static struct module *load_module(void _
 > > 	/* Set up license info based on the info section */
 > > 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
 > >
 > > +	if (strcmp(mod->name, "ndiswrapper") == 0)
 > > +		add_taint(TAINT_PROPRIETARY_MODULE);
 > > +	if (strcmp(mod->name, "driverloader") == 0)
 > > +		add_taint(TAINT_PROPRIETARY_MODULE);
 > > +
 > > #ifdef CONFIG_MODULE_UNLOAD
 > > 	/* Set up MODINFO_ATTR fields */
 > > 	setup_modinfo(mod, sechdrs, infoindex);
 > 
 > So your are blacklisting certain drivers? If so, you probably
 > should have an array containing their names plus a header-file
 > into which the hundreds, perhaps thousands, of future module-
 > names can be added.
 > 
 > ... Not meant as a joke or an affront. User's should be able to
 > know what hardware to NOT purchase because of the proprietary
 > nature of their drivers. Putting a couple "exceptions" into
 > code as above is not good coding practice. If you need to
 > exclude stuff, there should be an exclusion procedure that
 > treats all that stuff equally, no?

There's a point where the effort of creating an array, and
loops to parse it isn't worth it. For two entries, this
seemed a lot simpler.

Though if there more additions, I'd agree.

		Dave

