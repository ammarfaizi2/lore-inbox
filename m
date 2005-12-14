Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVLNMNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVLNMNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 07:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVLNMNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 07:13:33 -0500
Received: from cantor2.suse.de ([195.135.220.15]:13294 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932483AbVLNMNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 07:13:33 -0500
Date: Wed, 14 Dec 2005 13:12:23 +0100
From: Karsten Keil <kkeil@suse.de>
To: Tilman Schmidt <tilman@imap.cc>
Cc: Greg KH <greg@kroah.com>, Hansjoerg Lipp <hjlipp@web.de>,
       Karsten Keil <kkeil@suse.de>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [linux-usb-devel] [PATCH 6/9] isdn4linux: Siemens Gigaset drivers - procfs interface
Message-ID: <20051214121223.GA19325@pingi3.kke.suse.de>
Mail-Followup-To: Tilman Schmidt <tilman@imap.cc>,
	Greg KH <greg@kroah.com>, Hansjoerg Lipp <hjlipp@web.de>,
	Karsten Keil <kkeil@suse.de>, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
References: <gigaset307x.2005.12.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.1@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.2@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.3@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.4@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.5@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.6@hjlipp.my-fqdn.de> <20051211183350.GA10329@kroah.com> <43A003C0.80207@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A003C0.80207@imap.cc>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15-default i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 12:36:32PM +0100, Tilman Schmidt wrote:
> Greg KH wrote:
> > Are there existing userspace tools that rely on proc files for isdn
> > control?  If not, please do not add new proc files, these should be in
> > sysfs instead.
> 
> Thanks for your comment. We'll move everything to sysfs. Most of it is
> done already, but there is a problematic case I'd like your advice on:
> the "info" and "hwinfo" entries, which emit several lines of status
> and statistics information.
> 

To solve this in sysfs, you could create a group (subdir) and there
use a entry with a value for every status item.
Same for statistics info.
See /sys/class/net/<netdevice>/statistics/ as example. 

> According to Documentation/filesystems/sysfs.txt:
> "Mixing types, expressing multiple lines of data, and doing fancy
> formatting of data is heavily frowned upon. Doing these things may get
> you publically humiliated and your code rewritten without notice."
> We certainly don't want to risk that. :-)
> 
> We have tentatively created an entry in /proc/tty/driver/ as proposed
> in LDD3 chapter 18, section "proc and sysfs Handling of TTY Devices"
> as a replacement. But that has the drawback of giving us only a
> single file per driver as opposed to one or two files per device.
> So the driver has to enumerate the devices and concatenate their data,
> which appears cumbersome, even though normal users will probably
> never connect more than one of these devices.
> 
> Is there a better alternative?

See above, I would drop procfs completly.

-- 
Karsten Keil
SuSE Labs
ISDN development
