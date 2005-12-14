Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVLNLhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVLNLhI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVLNLhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:37:07 -0500
Received: from posthamster.phnxsoft.com ([195.227.45.4]:45324 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S932432AbVLNLhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:37:06 -0500
Message-ID: <43A003C0.80207@imap.cc>
Date: Wed, 14 Dec 2005 12:36:32 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Hansjoerg Lipp <hjlipp@web.de>, Karsten Keil <kkeil@suse.de>,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [linux-usb-devel] [PATCH 6/9] isdn4linux: Siemens Gigaset drivers
 - procfs interface
References: <gigaset307x.2005.12.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.1@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.2@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.3@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.4@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.5@hjlipp.my-fqdn.de> <gigaset307x.2005.12.11.001.6@hjlipp.my-fqdn.de> <20051211183350.GA10329@kroah.com>
In-Reply-To: <20051211183350.GA10329@kroah.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Are there existing userspace tools that rely on proc files for isdn
> control?  If not, please do not add new proc files, these should be in
> sysfs instead.

Thanks for your comment. We'll move everything to sysfs. Most of it is
done already, but there is a problematic case I'd like your advice on:
the "info" and "hwinfo" entries, which emit several lines of status
and statistics information.

According to Documentation/filesystems/sysfs.txt:
"Mixing types, expressing multiple lines of data, and doing fancy
formatting of data is heavily frowned upon. Doing these things may get
you publically humiliated and your code rewritten without notice."
We certainly don't want to risk that. :-)

We have tentatively created an entry in /proc/tty/driver/ as proposed
in LDD3 chapter 18, section "proc and sysfs Handling of TTY Devices"
as a replacement. But that has the drawback of giving us only a
single file per driver as opposed to one or two files per device.
So the driver has to enumerate the devices and concatenate their data,
which appears cumbersome, even though normal users will probably
never connect more than one of these devices.

Is there a better alternative?

Thanks
Tilman

-- 
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeöffnet mindestens haltbar bis: (siehe Rückseite)
