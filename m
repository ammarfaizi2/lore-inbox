Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbUCSRw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 12:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbUCSRw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 12:52:28 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:23708 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263031AbUCSRw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 12:52:26 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Exporting physical topology information
Date: Fri, 19 Mar 2004 09:51:52 -0800
User-Agent: KMail/1.6.1
References: <20040317213714.GD23195@localhost> <20040318232139.GA17586@kroah.com>
In-Reply-To: <20040318232139.GA17586@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403190951.52899.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 March 2004 3:21 pm, Greg KH wrote:
> > If we could physically locate a PCI bus, then it would be much easier
> > to (for example) locate our defective SCSI disk that is target4 on the
> > SCSI controller that is on pci bus 0000:20.
> 
> Um, what's wrong with the current /sys/class/pci_bus/*/cpuaffinity files
> for determining this topology information?  That is why it was added.

Nothing, except that it only provides logical information.  In a large
system, it's really useful to be able to physically locate a component
somehow.  That was the idea behind adding 'physid'.  For example:

[jbarnes@spamtin pci0000:02]$ pwd
/sys/devices/pci0000:02
[jbarnes@spamtin pci0000:02]$ cat physid
rack: 5
module: 12
slot: 3

or for nodes:

[jbarnes@spamtin node2]$ cat physid
rack: 1
module: 3
slot: 1

Then you could walk into the lab and know exactly which device to
kick.  Obviously, these values would be platform specific, though on
ia64 and some x86 platforms, we could probably use the ACPI namespace
to access some of the info, and on ppc the OF namespace might have it.

Thanks,
Jesse

