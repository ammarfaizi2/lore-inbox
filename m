Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbRGCG5V>; Tue, 3 Jul 2001 02:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266454AbRGCG5M>; Tue, 3 Jul 2001 02:57:12 -0400
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:51215 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S266453AbRGCG5E>; Tue, 3 Jul 2001 02:57:04 -0400
Date: Tue, 3 Jul 2001 07:50:50 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: kaos@ocs.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5
Message-ID: <20010703075050.B15457@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>, kaos@ocs.com.au,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3B415489.77425364@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B415489.77425364@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Jul 03, 2001 at 01:13:45AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this defeat my favourite module-related gothcha, that the machine panics
if I have (say) a scsi driver builtin to the kernel and the same driver tries
to load itself as a module?

This normally happens when switching to a custom kernel after a fresh distro
install.  RedHat (and others, I think) use an initial ramdisk to make sure that
all the modules needed to mount the root fs get loaded at boot time.

If you build the drivers in, but forget to comment out the initrd line in
/etc/lilo.conf, the machine panics because it tries to load the module for
something that is already a builtin.

Make sense?

Sean

On Tue, Jul 03, 2001 at 01:13:45AM -0400, Jeff Garzik wrote:
> A couple things that would be nice for 2.5 is
> - let MOD_INC_USE_COUNT work even when module is built into kernel, and
> - let THIS_MODULE exist and be valid even when module is built into
> kernel
> 
> This introduces bloat into the static kernel for modules which do not
> take advantage of this, so perhaps we can make this new behavior
> conditional on CONFIG_xxx option.  Individual drivers which make use of
> the behavior can do something like
> 
> 	dep_tristate 'my driver' CONFIG_MYDRIVER $CONFIG_PCI
> 	if [ "$CONFIG_MYDRIVER" != "n" -a \
> 	     "$CONFIG_STATIC_MODULES" != "y" ]; then
> 	   define_bool CONFIG_STATIC_MODULES y
> 	fi
> 
> 
> 
> The reasoning behind this is that module use counts are useful sometimes
> even when the driver is built into the kernel.  Other facilities like
> inter_xxx are [obviously] useful when built into the kernel, so it makes
> sense to at least optionally support homogenous module treatment across
> static or modular builds.
> 
> -- 
> Jeff Garzik      | "I respect faith, but doubt is
> Building 1024    |  what gives you an education."
> MandrakeSoft     |           -- Wilson Mizner
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
