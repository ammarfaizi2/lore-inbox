Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWEDVsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWEDVsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWEDVsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:48:24 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:37154 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030262AbWEDVsX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:48:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h8sD5Bn8rb4p+Pm8x/MvlQExNpjmsmPkIE+1mou/yB7fuFDt4oOP2Zzal2MExT4ZMdWBcV27jpKTVrEzqN5/PFnBEtdf3sAsOuk1FiCQ54aqSJ53pjRPaOfDtaWX0euvb0CfmfiqajI2KuzRUsZf215RwymkEibmxYTNYySs5MY=
Message-ID: <9e4733910605041448j431266d5x8669f79bd1b36e18@mail.gmail.com>
Date: Thu, 4 May 2006 17:48:22 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Peter Jones" <pjones@redhat.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, "Dave Airlie" <airlied@linux.ie>,
       "Andrew Morton" <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@linux.intel.com>
In-Reply-To: <1146778720.27727.35.camel@localhost.localdomain>
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
	 <9e4733910605041418n2105e50bs8803cd6ac8407c48@mail.gmail.com>
	 <1146778720.27727.35.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Peter Jones <pjones@redhat.com> wrote:
> On Thu, 2006-05-04 at 17:18 -0400, Jon Smirl wrote:
> > On 5/4/06, Peter Jones <pjones@redhat.com> wrote:
>
> > > It doesn't matter -- you can accomplish the same thing with e.g.
> > > libx86emu and simply mapping the option rom to 0xc0000.  But you want to
> > > do that in userland, not in the kernel.
> >
> > It is much more complicated than than you describe.
>
> I didn't really feel like explaining the parts we both already know.
> I'll try to remember to do so in the future.
>
> > Go look at the ROM code already checked in. Laptop video ROMs are not
> > simple PCI devices that can be mapped around. They are stored in
> > compressed form inside the system ROM and expanded at boot.
>
> Yes, and this format is documented, too.  But right now there's no way
> to get access to it with tools to actually do anything.
>
> > If you lose the shadow copy in RAM there is no API for getting it back.
>
> Except to enable the BAR and read it from the assigned address...

Let me be clear here. A lot of laptop video hardware does not have a
video ROM. Therefore you can not enable the BAR and read it from an
assigned address since there is no ROM to be read.  Instead the video
ROM images are compressed and stored inside the system BIOS ROM. The
location of the image is not a public thing.  At boot time the
compressed video ROM is expanded out of the system ROM into shadow RAM
at C000:0. There is no real ROM there, it is only a copy in RAM. If
you lose that copy the only way to get it back is to reset the
machine. The ROM code already in the kernel knows about these shadow
copies and won't mess them up.


> > These compressed ROMs are the source of a lot of laptop user's
> > problems with suspend/resume on Linux.
>
> Absolutely.  That's why I want a method to access them, which this
> "enable" file provides.
>
> > VGA support for multiple cards is a very complicated problem.
>
> Please quit jumping up and down in the bicycle path telling everybody
> how hard it is to ride a bike.
>
> --
>   Peter
>
>


--
Jon Smirl
jonsmirl@gmail.com
