Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVG0GBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVG0GBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 02:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVG0GBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 02:01:34 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:34117 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261972AbVG0GBV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 02:01:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IuUiS8kKEPXFreatggjmlsYFa1MUUvrx7P5CLNAUafKGKjamLR3vdw+HNpSvm121S4ytZofM/TWyID5xdUF0OneuflQzUMXaib/OY6Cczs6P8BhJmRC9XPugQlqMF6Ufcb3hb1ZOEZ+qkGq1Cki/rpSasr7mPm//lGIa75NYR6Y=
Message-ID: <b115cb5f05072623016a713629@mail.gmail.com>
Date: Wed, 27 Jul 2005 15:01:18 +0900
From: Rajat Jain <rajat.noida.india@gmail.com>
Reply-To: Rajat Jain <rajat.noida.india@gmail.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: Incorrect driver getting loaded for Qlogic FC-HBA
Cc: Greg KH <greg@kroah.com>, kernelnewbies@nl.linux.org,
       linux-scsi@vger.kernel.org, linux-newbie@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050726155253.GB8462@plap.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b115cb5f0507241902653b6f72@mail.gmail.com>
	 <20050726000600.GB23858@kroah.com>
	 <b115cb5f050725211615cfab78@mail.gmail.com>
	 <20050726155253.GB8462@plap.qlogic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/05, Andrew Vasquez <andrew.vasquez@qlogic.com> wrote:
> On Tue, 26 Jul 2005, Rajat Jain wrote:
> > On 7/26/05, Greg KH <greg@kroah.com> wrote:
> > > On Mon, Jul 25, 2005 at 11:02:39AM +0900, Rajat Jain wrote:
> > > > I'm using Kernel 2.6.9 and am having a Qlogic QLE2362 FC-HBA in my
> > > > system. I selected all the Qlogic SCSI drivers while buiding the
> > > > kernel. Now the problem is that every time I reboot, I have to
> > > > MANUALLY modprobe the qla2322.ko module in the kernel and only then my
> > > > HBA works. By default, the kernel loads qla2300.ko, which is not the
> > > > correct driver for the card, and hence the HBA does not work. Here is
> > > > the lspci output:
> > >
> > > "by default" the kernel does not load any modules.  That's up to the
> > > hotplug system, or some other package.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> >
> > Thanks. I just checked .. that is right. So let me put it this way.
> > When ever I hot-plug my HBA into the system, the driver "qla2300" gets
> > loaded. Where as the correct driver is "qla2322". This evident from
> > the output of "modules.pcimap" file and "lspci". The PCI device number
> > of HBA is 2322. and in modules.pcimap file, qla2322 is supposed to be
> > loaded when this HBA is hot-plugged. But module qla2300 is getting
> > loaded.
> >
> > Any pointers on where could the problem be? Or how should I approach
> > this problem?
> 
> A similar problem was noted with RHEL4, it seems the modules.pcimap
> and pci.ids file were correct, but the pcitable file contained entries
> for all ql[ae]23xx based HBAs to load qla2300.ko.
> 
> It's my understanding that this was fixed for RHEL4 U1.  Which distro
> are you using?  If you are using RHEL, and are still having problems,
> I'd suggest you file a report with Redhat.
> 
> Regards,
> Andrew Vasquez
> 

BINGO! I AM using RHEL 4. So does that mean I can rectify the problem
by making appropriate changes to "pcitable" file?

Thanks a Ton !

Rajat
