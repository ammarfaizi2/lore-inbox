Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWBZQfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWBZQfv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 11:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWBZQfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 11:35:51 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:60811 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750811AbWBZQfu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 11:35:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gWgNx4N+z5aK0V/QOXztfp5yd1gAcbrP1lDjw6nRPpyrh2C+uF+dW5RDN1qE+7ceVJurkMgI4Pl3NXm91BMVU/CU/jGJIcDQV7jwNTfJBgTWW+diQIMAA4iSqV2RHjqZ+ZvTjh/6/rx4FMngl3DNY29YmR//AeaiAkZQECNcZQo=
Message-ID: <9a8748490602260835l2430e841p2bf02c1f99e55b91@mail.gmail.com>
Date: Sun, 26 Feb 2006 17:35:49 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
In-Reply-To: <9a8748490602260831l3338f03ew60f99648848aa177@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261721.17373.jesper.juhl@gmail.com>
	 <9a8748490602260831l3338f03ew60f99648848aa177@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 2/26/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > Hi everyone,
> >
> > I just sat down and build 100 kernels (2.6.16-rc4-mm2 kernels to be exact)
> >
> >         95 kernels were build with 'make randconfig'.
> >         1 kernel was build with the config I normally use for my own box.
> >         1 kernel was build from 'make defconfig'.
> >         1 kernel was build from 'make allmodconfig'.
> >         1 kernel was build from 'make allnoconfig'.
> >         1 kernel was build from 'make allyesconfig'.
> >
> > That was an interresting experience.
> >
> > First of all not very many of the kernels actually build correctly and
> > secondly, if I grep the build logs for warnings I'm swamped.
> >
> > Out of 100 kernels 82 failed to build - that's an 18% success rate people,
> > not very impressive.
> >
> > Some of the failed builds are due to things like CONFIG_STANDALONE that
> > will break the build if not set to Y (unless you have the firmware
> > available ofcourse), but looking at the config files I find that only 26
> > kernels have CONFIG_STANDALONE unset, so that only accounts for a quarter
> > of the kernels.
> >
> > A lot of failed builds are due to invalid combinations of some stuff
> > being build-in and some stuff being build as modules.
> > This, as far as I'm concerned, is something that the dependencies in
> > Kconfig should make impossible - hence my conclusion that we suck at deps.
> >
> > From 100 kernel builds there was a total of 16152 warnings and 645 of those
> > are unique warnings, the rest are duplicates.
> >
> > We are drowning in warnings people. Sure, many of the warnings are due to
> > gcc getting something wrong and shouldn't really be emitted, but a lot of
> > them point to actual problems or deficiencies (I obviously haven't looked
> > at them all in detail yet, so take that with a grain of salt please).
> >
> > In any case, it looks to me like we have some serious clean-up work to do.
> >
> > Unfortunately I don't have anywhere to put all the configs and logs online,
> > but I can send them on request, or if someone can point at a space to
> > upload them to I'll gladly make them available.
> >
> > That's it for now, I'll get to work trying to clean up some of the breakage
> > I've seen, if anyone wants to join in feel free :)
> >
> >
>
> For the interrested parties, here's a list of the unique warnings :
>
[snip list of warnings]

And for those who want to see a list of the unique errors, here they are :

make: *** [.tmp_vmlinux1] Error 1
make: *** [arch/i386/kernel] Error 2
make: *** [drivers] Error 2
make: *** [sound] Error 2
make: *** [vmlinux] Error 1
make[1]: *** [arch/i386/kernel/irq.o] Error 1
make[1]: *** [drivers/acpi] Error 2
make[1]: *** [drivers/atm] Error 2
make[1]: *** [drivers/isdn] Error 2
make[1]: *** [drivers/media] Error 2
make[1]: *** [drivers/mtd] Error 2
make[1]: *** [drivers/scsi] Error 2
make[1]: *** [drivers/usb] Error 2
make[1]: *** [sound/isa] Error 2
make[1]: *** [sound/oss] Error 2
make[2]: *** [drivers/acpi/numa.o] Error 1
make[2]: *** [drivers/acpi/numa.o] Error 1  LD [M]  fs/ext3/ext3.o
make[2]: *** [drivers/acpi/osl.o] Error 1
make[2]: *** [drivers/atm/fore200e_pca_fw.c] Error 254
make[2]: *** [drivers/isdn/hysdn] Error 2
make[2]: *** [drivers/media/dvb] Error 2
make[2]: *** [drivers/mtd/maps] Error 2
make[2]: *** [drivers/scsi/aic7xxx] Error 2
make[2]: *** [drivers/usb/net] Error 2
make[2]: *** [sound/isa/opti9xx] Error 2
make[3]: *** [drivers/isdn/hysdn/hysdn_net.o] Error 1
make[3]: *** [drivers/media/dvb/ttpci] Error 2
make[3]: *** [drivers/mtd/maps/nettel.o] Error 1
make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
make[3]: *** [drivers/usb/net/cdc_subset.o] Error 1
make[3]: *** [sound/isa/opti9xx/opti92x-ad1848.o] Error 1
make[3]: *** [sound/isa/opti9xx/opti93x.o] Error 1
make[4]: *** [aicasm] Error 1
make[4]: *** [drivers/media/dvb/ttpci/av7110_firm.h] Error 255


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
