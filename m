Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVBXH3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVBXH3A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVBXH1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:27:19 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:36765 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261881AbVBXHZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:25:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=flsNZE2FZUFaHIqE2/mm52xElI8uLfHb1KvWsAJtAXJ8h3DNuUI2TiHjenfdVSu87njCzO9hPUnOXqyz+bviq7SdrBJfJ1cveiwZR7T/OvxYVdpmkcu03L0XOUrxmvGxu1M6B3kDaGA4Iu2CbZVbGBdiT9tU3kWZzBehCqlwxKQ=
Message-ID: <9e4733910502232325118c9ff3@mail.gmail.com>
Date: Thu, 24 Feb 2005 02:25:12 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Adam Belay <abelay@novell.com>
Subject: Re: [RFC] PCI bridge driver rewrite
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <1109228638.28403.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1109226122.28403.44.camel@localhost.localdomain>
	 <9e473391050223224532239c9d@mail.gmail.com>
	 <1109228638.28403.71.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you start writing the PCI root bridge driver you'll run into the
AGP drivers that are already attached to the bridge. I was surprised
by this since I expected AGP to be attached to the AGP bridge but now
I learned that it is a root bridge function.

An ISA LPC bridge driver would be nice too. It would let you turn off
serial ports, etc and let other systems know how many ports there are.
No real need for this, just a nice toy.

Does this work to cause a probe based on PCI class?
static struct pci_device_id p2p_id_tbl[] = {
       { PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI << 8, 0xffff00) },
       { 0 },
};

I would like to install a driver that gets called whenever new
CLASS_VGA hardware shows up via hotplug. It won't attach to the
device, it will just add some sysfs attributes. The framebuffer
drivers need to attach the device. If I add attributes this way how
can I remove them?

-- 
Jon Smirl
jonsmirl@gmail.com
