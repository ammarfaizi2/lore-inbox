Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751740AbWF2FT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbWF2FT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 01:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWF2FT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 01:19:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5771 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751740AbWF2FT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 01:19:27 -0400
Date: Thu, 29 Jun 2006 01:19:23 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [PATCH] chardev: GPIO for SCx200 & PC-8736x: add proper Kconfig, Makefile entries
Message-ID: <20060629051923.GA6334@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jim Cromie <jim.cromie@gmail.com>
References: <200606280201.k5S21OY5014423@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606280201.k5S21OY5014423@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 02:01:24AM +0000, Linux Kernel wrote:
 > commit 7a8e2a5ea4cf43c0edd6db56a156549edb0eee98
 > tree 42a88e7f8de0c22011b8e75fb96255e5360380d8
 > parent 23916a8e3d8f41aa91474e834ac99808b197c39e
 > author Jim Cromie <jim.cromie@gmail.com> Tue, 27 Jun 2006 16:54:27 -0700
 > committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 28 Jun 2006 07:32:43 -0700
 > 
 > [PATCH] chardev: GPIO for SCx200 & PC-8736x: add proper Kconfig, Makefile entries
 > 
 > Replace the temp makefile hacks with proper CONFIG entries, which are also
 > added to Kconfig.
 >  ....
 > +
 > +config NSC_GPIO
 > +	tristate "NatSemi Base GPIO Support"
 > +	# selected by SCx200_GPIO and PC8736x_GPIO
 > +	# what about 2 selectors differing: m != y
 > +	help
 > +	  Common support used (and needed) by scx200_gpio and
 > +	  pc8736x_gpio drivers.  If those drivers are built as
 > +	  modules, this one will be too, named nsc_gpio
 
AFAICT, this is x86 only, so the patch below is needed to stop
this new option showing up on PPC, IA64, etc..

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/drivers/char/Kconfig~	2006-06-29 01:17:35.000000000 -0400
+++ linux-2.6.17.noarch/drivers/char/Kconfig	2006-06-29 01:17:55.000000000 -0400
@@ -963,6 +963,7 @@ config PC8736x_GPIO
 
 config NSC_GPIO
 	tristate "NatSemi Base GPIO Support"
+	depends on X86_32
 	# selected by SCx200_GPIO and PC8736x_GPIO
 	# what about 2 selectors differing: m != y
 	help

-- 
http://www.codemonkey.org.uk
