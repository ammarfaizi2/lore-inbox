Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266436AbRGCFOL>; Tue, 3 Jul 2001 01:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266414AbRGCFOB>; Tue, 3 Jul 2001 01:14:01 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28070 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265473AbRGCFNv>;
	Tue, 3 Jul 2001 01:13:51 -0400
Message-ID: <3B415489.77425364@mandrakesoft.com>
Date: Tue, 03 Jul 2001 01:13:45 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kaos@ocs.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RFC: modules and 2.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple things that would be nice for 2.5 is
- let MOD_INC_USE_COUNT work even when module is built into kernel, and
- let THIS_MODULE exist and be valid even when module is built into
kernel

This introduces bloat into the static kernel for modules which do not
take advantage of this, so perhaps we can make this new behavior
conditional on CONFIG_xxx option.  Individual drivers which make use of
the behavior can do something like

	dep_tristate 'my driver' CONFIG_MYDRIVER $CONFIG_PCI
	if [ "$CONFIG_MYDRIVER" != "n" -a \
	     "$CONFIG_STATIC_MODULES" != "y" ]; then
	   define_bool CONFIG_STATIC_MODULES y
	fi



The reasoning behind this is that module use counts are useful sometimes
even when the driver is built into the kernel.  Other facilities like
inter_xxx are [obviously] useful when built into the kernel, so it makes
sense to at least optionally support homogenous module treatment across
static or modular builds.

-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
