Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVA0HGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVA0HGc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 02:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVA0HGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 02:06:32 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:1535 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262509AbVA0HG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 02:06:28 -0500
Date: Wed, 26 Jan 2005 23:05:50 -0800
From: "'Patrick Mansfield'" <patmans@us.ibm.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Greg KH'" <greg@kroah.com>,
       "'James Bottomley'" <James.Bottomley@steeleye.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'SCSI Mailing List'" <linux-scsi@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: How to add/drop SCSI drives from within the driver?
Message-ID: <20050127070550.GA18632@us.ibm.com>
References: <0E3FA95632D6D047BA649F95DAB60E5705B83A31@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5705B83A31@exa-atlanta>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[moving to hotplug list ...]

On Wed, Jan 26, 2005 at 06:23:16PM -0500, Mukker, Atul wrote:

> Or more likely, by placing our agent in /etc/dev.d directory. Unfortunately,
> there seems be not a consensus here as well. On system has "default" and
> "net" directories and other has "block", "input", "net", "tty"?

Those are all kernel subsystem names, and as such all are supported
directory structures for udev, the part that is distro specific is that
they supply different scripts.

There won't be any "scsi" devices since they have no dev (the upper level
drivers have them); sg shows up as scsi_generic. sd is block.

You will still have to figure out via sysfs if you want to run your agent
even for subsystem block (i.e. figure out the host/driver type, I assume
you don't want to run it on hd or standard scsi disk drives).

I don't know why this is an issue for "new" devices, this should be a
problem for you when they first show up; existing and new devs should be
handled the same way.

-- Patrick Mansfield
