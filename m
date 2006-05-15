Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWEOAOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWEOAOE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 20:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWEOAOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 20:14:04 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:1362 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750749AbWEOAOB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 20:14:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ibTwJMz6ozYunHlwIra6v0gJO3qGnunY/PmUivwiOI/CcoFWzZxOQfizFvzovr6zfKfBALR0rRh87K1zVKS0dQqgskP0/YBLAU8TpzKjUEi3PLE94wPXxEU9VciG4GAZC8sGSDI5V+SOMHAv6sISNNywbkdndGtbqItwlkEDlTw=
Message-ID: <9e4733910605141714w5f769933k12af4d5e221459cc@mail.gmail.com>
Date: Sun, 14 May 2006 20:14:01 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Peter Jones" <pjones@redhat.com>, "Martin Mares" <mj@ucw.cz>,
       "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, "Dave Airlie" <airlied@linux.ie>,
       "Andrew Morton" <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@linux.intel.com>
In-Reply-To: <1147651069.21291.63.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
	 <mj+md-20060504.211425.25445.atrey@ucw.cz>
	 <1146778197.27727.26.camel@localhost.localdomain>
	 <1147566572.21291.30.camel@localhost.localdomain>
	 <9e4733910605131756q50ad5686n4ca8d5a8d1f9e3e1@mail.gmail.com>
	 <1147651069.21291.63.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Sat, 2006-05-13 at 20:56 -0400, Jon Smirl wrote:
> > On 5/13/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > There are reasons why you may have to read the image at c0000... There's
> > > a bunch of laptops where it's in fact the only way to get to the video
> > > BIOS as it doesn't have a ROM attached to the video chip (it's burried
> > > in the main BIOS which thankfully copied it to c0000 when running it).
> > > In some cases, the BISO ROM self-modifies it's c0000 and it's that
> > > modified copy that the X (or fbdev) driver should get. Remeber that
> > > drivers needs access to the ROM for more than just POSTing the chip...
> >
> > Whenever klibc gets merged it would probably be good to add a
> > libemu86. Did you get one put together that you're happy with?
>
> No, not so far yet. Haven't had much time though. Did some expriments
> based on what you sent me back then, got it to work with loads of hacks,
> but I never properly cleaned it up.
>
> > Between the ROM attribute, klibc and libemu86 there will then be
> > enough support to write a tiny POST program that POSTs secondary and
> > non-x86 primary cards at boot. It will still need a little support in
> > sysfs for PCI bus VGA routing but we're almost there.
>
> And we need to "capture" the resulting BIOS image after POST and have a
> away to give that to the drivers as it will contain useful tables that
> the driver will need as well...

The ROM API already has support it in for storing a RAM based copy. I
believe it works but no one is using it so it is not well tested.
Something will need to be hooked up to get the copy from user space
back into the kernel. At one point I was working on generalizing
request_firmware to make it handle more that firmware downloads.

>
> Ben.
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
