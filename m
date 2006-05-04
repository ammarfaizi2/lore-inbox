Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWEDViJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWEDViJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWEDViJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:38:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:17835 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030333AbWEDViH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:38:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JNQT08ziIRh3bKyM4E7NbnTvoS/jiErAAVOehtY2mfNDmzD/WFVk1RsA6tIe+UINpGvIW/1J1d+0jGBj3C9W6CRtTo+TgszGFm94R1WYd24mtkUD/ivWS3M/XxQKVEDY3erRu+GPmN6AeokEQgDofRBN4ADxZIElnh8MlyX3Mtc=
Message-ID: <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com>
Date: Thu, 4 May 2006 17:38:02 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Peter Jones" <pjones@redhat.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Martin Mares" <mj@ucw.cz>,
       "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, "Dave Airlie" <airlied@linux.ie>,
       "Andrew Morton" <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@linux.intel.com>
In-Reply-To: <1146778197.27727.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <200605041309.53910.bjorn.helgaas@hp.com>
	 <445A51F1.9040500@linux.intel.com>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
	 <mj+md-20060504.211425.25445.atrey@ucw.cz>
	 <1146778197.27727.26.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Peter Jones <pjones@redhat.com> wrote:
> On Thu, 2006-05-04 at 23:17 +0200, Martin Mares wrote:
> > Hello!
> >
> > > > This is yet another way that user space can mess up the kernel. If VGA
> > > > routing is changes under fbdev (my attribute notifies fbdev, the fbdev
> > > > code for processing the notification did get checked in) then the
> > > > console will screw up.
> > >
> > > And this change allows userland to avoid doing that.
> >
> > Could you explain how?  I don't see how adding a "enable" attribute
> > to sysfs can solve these problems.
>
> By allowing tools to read the rom from the pci device itself, instead of
> whichever device's rom happens to be at 0xC0000.  libx86emul allows you
> to define routines that it uses for memory access, so you can copy the
> ROM out to normal memory, and map that memory to the appropriate address
> that way.  X and vbetool both already have to do this, but without
> copying the firmware image, to do DDC probing on x86_64.

# cd /sys/bus/pci/devices/0000:01:00.0
# echo 1 >rom
# hexdump -C rom

As far as I know this works on every platform, not just the PC one.

Don't mess around with the hardware trying to get to the ROM. Use the
API provided by the kernel. Messing with the hardware will get it into
a state that the kernel doesn't know about and can ultimately crash
your system.

>
> > I agree with Arjan that the attribute could be useful for some special
> > tools, but using it in X is likely to be utterly wrong.
>
> I'm actually talking about vbetool here, though X could use these
> methods.  Indeed, libx86emul comes from X itself.
>
> --
>   Peter
>
>


--
Jon Smirl
jonsmirl@gmail.com
