Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261422AbSIZAWC>; Wed, 25 Sep 2002 20:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbSIZAWC>; Wed, 25 Sep 2002 20:22:02 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:26121 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261422AbSIZAWB>;
	Wed, 25 Sep 2002 20:22:01 -0400
Date: Wed, 25 Sep 2002 17:25:54 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pci and usb
Message-ID: <20020926002554.GB518@kroah.com>
References: <20020925212955.GA32487@kroah.com> <3D9250CD.7090409@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9250CD.7090409@pacbell.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 05:11:57PM -0700, David Brownell wrote:
> 
> >+	/* stuff we want to pass to /sbin/hotplug */
> >+	envp[i++] = scratch;
> >+	scratch += sprintf (scratch, "PCI_CLASS=%04X", pdev->class) + 1;
> >+
> >+	envp[i++] = scratch;
> >+	scratch += sprintf (scratch, "PCI_ID=%04X:%04X",
> >+			    pdev->vendor, pdev->device) + 1;
> 
> And so forth.  Use "snprintf" and prevent overrunning those buffers...

Doh, will do.

I also found the unload USB module problem.  The driver core was calling
hotplug after the device was already removed.  Made it a bit difficult
to be able to describe the device that way :)

thanks,

greg k-h
