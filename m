Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWJYXTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWJYXTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 19:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWJYXTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 19:19:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:31936 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030344AbWJYXTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 19:19:44 -0400
Subject: Re: [Cbe-oss-dev] [PATCH 12/16] cell: add temperature to SPU and
	CPU sysfs entries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: arnd@arndb.de, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org
In-Reply-To: <20061025080048.GB7090@osiris.boeblingen.de.ibm.com>
References: <20061024163113.694643000@arndb.de>
	 <20061024163816.851732000@arndb.de>
	 <20061025080048.GB7090@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 09:19:24 +1000
Message-Id: <1161818364.22582.145.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 10:00 +0200, Heiko Carstens wrote:
> On Tue, Oct 24, 2006 at 06:31:25PM +0200, arnd@arndb.de wrote:
> 
> > + * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
> 
> IBM Corp. instead of IBM DE? 2006?
> 
> > +static int __init thermal_init(void)
> > +{
> > +	init_default_values();
> > +
> > +	spu_add_sysdev_attr_group(&spu_attribute_group);
> > +	cpu_add_sysdev_attr_group(&ppe_attribute_group);
> > +
> > +	return 0;
> > +}
> 
> Same here: check for errors on spu_add_sysdev_attr_group and
> cpu_add_sysdev_attr_group.
> 
> > +static void __exit thermal_exit(void)
> > +{
> > +	spu_remove_sysdev_attr_group(&spu_attribute_group);
> > +	cpu_remove_sysdev_attr_group(&ppe_attribute_group);
> 
> Will crash if cpu_add_sysdev_attr_group failed...


Which is a total PITA. If this is the case, then we should modify the
add calls to at least initialize enough fields before they can fail for
the remove calls not to crash. You don't want to keep track precisely of
what file was added and what not and test all of that in your exit code
path, it's just insane.

Ben.


