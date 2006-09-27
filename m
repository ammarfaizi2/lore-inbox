Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965365AbWI0GDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965365AbWI0GDW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965364AbWI0GDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:03:22 -0400
Received: from hera.kernel.org ([140.211.167.34]:50070 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965362AbWI0GDV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:03:21 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andrew Morton <akpm@osdl.org>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Wed, 27 Sep 2006 02:04:38 -0400
User-Agent: KMail/1.8.2
Cc: Ismail Donmez <ismail@pardus.org.tr>, Stelian Pop <stelian@popies.net>,
       Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <20060926135659.GA3685@jnb.gelma.net> <200609262056.32052.ismail@pardus.org.tr> <20060926221400.5da1b796.akpm@osdl.org>
In-Reply-To: <20060926221400.5da1b796.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609270204.38970.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 01:14, Andrew Morton wrote:
> On Tue, 26 Sep 2006 20:56:31 +0300
> Ismail Donmez <ismail@pardus.org.tr> wrote:
> 
> > 26 Eyl 2006 Sal 19:29 tarihinde şunları yazmıştınız:
> > > Andrea Gelmini a écrit :
> > > > Hi,
> > > > 	I've got a Sony Vaio VGN-SZ1VP (dmidecode[1] and lspci[2]).
> > > > 	Using default kernel (linux-image-2.6.15-27-686) of Ubuntu
> > > > 	Dapper I've got /proc/acpi/sony/brightness and it works well
> > > > 	(yes, Ubuntu drivers/char/sonypi.c is patched).
> > > > 	With any other newer vanilla kernel, 2.6.15/16/17/18, /proc/acpi/sony
> > > > 	doesn't appear, and it's impossibile to set brigthness, of
> > > > 	course. Same thing with Ubuntu kernel package
> > > > 	(linux-image-2.6.17-9-386).
> > > > 	I tried to port Ubuntu sonypi.c patches to 2.6.18, but it doesn't
> > > > 	work (I mean, it compiles clean, it "modprobes"[3] clean, but no
> > > > 	/proc/acpi/sony/ directory).
> > >
> > > /proc/acpi/sony comes from the sony_acpi driver, not sonypi.
> > >
> > > You should get the latest sony_acpi driver, preferably from the -mm tree
> > > which hosts the most up to date version.
> > 
> > Will sony_acpi ever make it to the mainline? Its very useful for new Vaio 
> > models.

Nope, not as it is.  Useful != supportable.

1. It must not create any files under /proc/acpi
    This is creating a machine-specific API, which
    is exactly what we don't want  Nobody can maintain
    50 machine specific APIs.

    These objects must appear generic and under sysfs
    as if acpi were not involved in providing them.

2. its source code shall not live in drivers/acpi
    it is not part of the ACPI implementation after all --
    it is a platform specific driver.

thanks,
-Len
