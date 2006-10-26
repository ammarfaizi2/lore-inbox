Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWJZHfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWJZHfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 03:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWJZHfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 03:35:17 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:28100 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751769AbWJZHfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 03:35:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 12/16] cell: add temperature to SPU and CPU sysfs entries
Date: Thu, 26 Oct 2006 09:35:00 +0200
User-Agent: KMail/1.9.5
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       Andrew Morton <akpm@osdl.org>
References: <20061024163113.694643000@arndb.de> <20061025080048.GB7090@osiris.boeblingen.de.ibm.com> <1161818364.22582.145.camel@localhost.localdomain>
In-Reply-To: <1161818364.22582.145.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610260935.01801.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 October 2006 01:19, Benjamin Herrenschmidt wrote:
> > 
> > Will crash if cpu_add_sysdev_attr_group failed...
> 
> 
> Which is a total PITA. If this is the case, then we should modify the
> add calls to at least initialize enough fields before they can fail for
> the remove calls not to crash. You don't want to keep track precisely of
> what file was added and what not and test all of that in your exit code
> path, it's just insane.

Heiko suggested that earlied in http://lkml.org/lkml/2006/10/9/22,
but Andrew didn't like it.

Currently, the worst is that sysfs_remove_file can be used
on a nonexisting file,  but sysfs_remove_group cannot, which is
inconsistent. Either sysfs_remove_file should WARN_ON or
sysfs_remove_group should silently return, and I'd prefer the
latter, as it makes users simpler.

	Arnd <><
