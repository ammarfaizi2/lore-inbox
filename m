Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265510AbSIRGpE>; Wed, 18 Sep 2002 02:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265671AbSIRGpE>; Wed, 18 Sep 2002 02:45:04 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:35846 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265510AbSIRGpD>;
	Wed, 18 Sep 2002 02:45:03 -0400
Date: Tue, 17 Sep 2002 23:50:12 -0700
From: Greg KH <greg@kroah.com>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux hot swap support
Message-ID: <20020918065012.GA6840@kroah.com>
References: <180577A42806D61189D30008C7E632E8793A60@boca213a.boca.ssc.siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180577A42806D61189D30008C7E632E8793A60@boca213a.boca.ssc.siemens.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 03:28:17PM -0400, Bloch, Jack wrote:
> I have a cPCI system running a Red Hat 2.4.18-3 Kernel. am running on a
> Pentium III 700Mhz machine, but we have some of our own cPCI HW. I wrote the
> drivers according to the Linux Device Driver 2nd edition (i.e. hot swap
> compliant). But what I am missing is :

Do your drivers tie into the existing pci_hotplug core?  If so, great,
then your userspace interaction is done.

Do you have a pointer to your driver?

> What SW will call my device insert/device remove routines?

If you use the pci_hotplug core, any userspace program can call them
through pcihpfs.

> Please CC me directly on anty response. By the way I read the PDF file  Hot
> Pluggable Devices And The Linux Kernel, but I am still not clear on the
> answerrs to the above questions.

Do you mean this document:
	http://www.kroah.com/linux/talks/ols_2001_hotplug_paper/hotplug.ps
?  That just details how individual drivers can specify the proper
information so that /sbin/hotplug will load them when hardware that they
support is recognized.  It has nothing to do with the pci hotplug core,
for that you might want to take a look at:
	http://linuxjournal.com/article.php?sid=5633
but to be honest, that article deals more with how to create a
filesystem for a driver.  Hopefully, you can glean some insight into how
the userspace interaction works from it.  If you still have questions,
please let me know..

I also have a very dumb program at:
	http://www.kroah.com/linux/hotplug/
that can power up and down slots in a pci hotplug system.  I have an
even simpler bash script that does the same thing around here somewhere,
if people are interested.

Hope this helps,

greg k-h
