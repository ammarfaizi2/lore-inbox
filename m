Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265929AbUAMWi1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUAMWi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:38:26 -0500
Received: from amdext2.amd.com ([163.181.251.1]:47264 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S266136AbUAMWhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:37:54 -0500
Message-ID: <99F2150714F93F448942F9A9F112634C080EF392@txexmtae.amd.com>
From: paul.devriendt@amd.com
To: davej@redhat.com, pavel@ucw.cz
cc: cpufreq@www.linux.org.uk, linux@brodo.de, linux-kernel@vger.kernel.org
Subject: RE: Cleanups for powernow-k8
Date: Tue, 13 Jan 2004 16:37:13 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 6C1AAC9713165158-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 13, 2004 at 10:51:49PM +0100, Pavel Machek wrote:
> 
>  > powernow-k8 uses strange kind of comments
> 
> comments part I kinda agree with, though its not critical..

Ok, point taken.

>  > and is way too verbose.
> 
> I agree that something like that output belongs more in x86info,
> or a standalone tool, but I think Paul wanted to keep debugging stuff
> there for the time being. Maybe silence it, and have it enabled
> with a 'debug' module param ? Paul ?

In the early days of frequency management and K8, I really wanted the
debug stuff there to help with problems in the field - the debug spew
really did help out with all of the buggy BIOSs that reported bogus
data. Things are more stable now, and it has outlived its usefulness,
it will be majorly cleaned up in the new driver (see below).

Perhaps I will put out a separate debug utility or something like that.

>  >  
>  >  		if ((numps <= 1) || (batps <= 1)) {
>  > +			/* FIXME: Is this right? I can see one 
> state on battery, two states total as an usefull config */
>  >  			printk(KERN_ERR PFX "only 1 p-state to 
> transition\n");
>  >  			return -ENODEV;
>  >  		}
>  > the test probably should be numps <= 1 only, but it does 
> not matter as
>  > we force numps = batps]
> 
> 1 state on battery sounds odd. Buggy BIOS ?

No, it can be valid. The capability was put into the spec to allow
a platform manufacturer to have a system where the battery pack
could not power the system at full speed. It is legit (only the
platform manufacturer can say whether it is correct or not) to 
say that operation must be restricted to the lowest frequency when 
mains power is not available. Add up the current draw from all the
devices including the processor, and look at the current that the
battery is capable of supplying ...

I have a totally new driver, that I am hoping to release within about
a month. (I did target the end of the year, but I got distracted on
some other stuff). The new driver :
  - uses ACPI to figure out the available p-states. I have seen a *lot*
    of buggy BIOSs where the PSB/PST info is wrong or missing,
  - uses ACPI to handle battery / mains power transitions,
and some other clean ups.

I would appreciate some advice on a question ... should I leave the old
non-ACPI capability there for those people who do not want to enable ACPI
in the kernel ? If so, is this a big ifdef, or is there a better way to do
it ? Or should I just say that it is dependent on ACPI, got to have ACPI ?

Paul.


