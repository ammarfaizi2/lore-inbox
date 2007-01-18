Return-Path: <linux-kernel-owner+w=401wt.eu-S1752088AbXARSX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbXARSX3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 13:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbXARSX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 13:23:29 -0500
Received: from outbound-mail-74.bluehost.com ([69.89.20.9]:48957 "HELO
	outbound-mail-74.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752088AbXARSX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 13:23:28 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] pci_bus conversion to struct device
Date: Thu, 18 Jan 2007 10:23:28 -0800
User-Agent: KMail/1.9.5
Cc: Martin Mares <mj@ucw.cz>, Matthew Wilcox <matthew@wil.cx>,
       colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
References: <20070118005344.GA8391@kroah.com> <mj+md-20070118.081204.18154.nikam@ucw.cz> <20070118090044.GA23596@kroah.com>
In-Reply-To: <20070118090044.GA23596@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701181023.28403.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.161.73.10 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 18, 2007 1:00 am, Greg KH wrote:
> On Thu, Jan 18, 2007 at 09:14:06AM +0100, Martin Mares wrote:
> > Hello!
> >
> > > I recommend we just delete the pci_bus class.  I don't think it
> > > serves any useful purpose.  The bridge can be inferred frmo the
> > > sysfs hierarchy (not to mention lspci will tell you).  The
> > > cpuaffinity file should be moved from the bus to the device -- it
> > > really doesn't make any sense to talk about which cpu a bus is
> > > affine to, only a device.
> >
> > It doesn't seem to serve any useful purpose other than the affinity
> > now, but I still think that it conceptually belongs there, because
> > it makes sense to have per-bus attributes. For example, in the
> > future we could show data width and signalling speed.
>
> So, if it were to stay, where in the tree should it be?  Hanging off
> of the pci device that is the bridge?  Or just placing these files
> within the pci device directory itself, as it is the bridge.
>
> There are also some "legacy io" binary sysfs files in these
> directories for those platforms that support it (#ifdef
> HAVE_PCI_LEGACY), and I'm guessing that there is some user for them
> out there, otherwise they would not have been added...
>
> Hm, only ia64 enables that option.  Matthew, do you care about those
> files?

Those interfaces could be supported on other platforms (iirc benh has 
been planning to add legacy_* support to ppc for awhile).  It would be 
great if they were supported everywhere to provide userspace with a 
fairly sane way to get at this stuff on all Linux systems...

Should be trivial on i386 I think.

Jesse
