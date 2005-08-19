Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVHSU7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVHSU7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 16:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbVHSU7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 16:59:18 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:56531 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S932255AbVHSU7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 16:59:17 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Benoit Boissinot <bboissin@gmail.com>
Subject: Re: 2.6.13-rc6-mm1
Date: Fri, 19 Aug 2005 17:01:05 -0400
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050819043331.7bc1f9a9.akpm@osdl.org> <200508191145.58835.tomlins@cam.org> <40f323d0050819090473d2c268@mail.gmail.com>
In-Reply-To: <40f323d0050819090473d2c268@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508191701.05925.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Adding the include to dmi.h allows the compile to get past this point though I
wonder if this is the correct place to put it?  (Thanks Benoit)

I now get:

  CC [M]  net/ipv4/ipvs/ip_vs_ctl.o
net/ipv4/ipvs/ip_vs_ctl.c:1601: error: static declaration of 'ipv4_table' follows non-static declaration
include/net/ip.h:376: error: previous declaration of 'ipv4_table' was here
make[3]: *** [net/ipv4/ipvs/ip_vs_ctl.o] Error 1
make[2]: *** [net/ipv4/ipvs] Error 2
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2

Ideas?

TIA
Ed Tomlinson

On Friday 19 August 2005 12:04, Benoit Boissinot wrote:
> On 8/19/05, Ed Tomlinson <tomlins@cam.org> wrote:
> > On Friday 19 August 2005 07:33, Andrew Morton wrote:
> > > - Lots of fixes, updates and cleanups all over the place.
> > >
> > > - If you have the right debugging options set, this kernel will generate
> > > a storm of sleeping-in-atomic-code warnings at boot, from the scsi code.
> > > It is being worked on.
> > >
> > >
> > > Changes since 2.6.13-rc5-mm1:
> > >
> > 
> > Hi,
> > 
> > It does not compile here:
> > 
> >   CC      drivers/acpi/sleep/main.o
> > In file included from drivers/acpi/sleep/main.c:15:
> > include/linux/dmi.h:55: error: field 'list' has incomplete type
> > make[3]: *** [drivers/acpi/sleep/main.o] Error 1
> > make[2]: *** [drivers/acpi/sleep] Error 2
> > make[1]: *** [drivers/acpi] Error 2
> > make: *** [drivers] Error 2
> > ed@grover:/usr/src/13-6-1$
> > 
> > Probably a missing include?  Note that this is a non smp x86_64 build.
> > 
> including <linux/list.h> in dmi.h should work
> 
> regards,
> 
> Benoit
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
