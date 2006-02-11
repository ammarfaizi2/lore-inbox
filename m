Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWBKPCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWBKPCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWBKPBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:01:53 -0500
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:43916 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S932310AbWBKPBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:01:40 -0500
Date: Sat, 11 Feb 2006 15:52:27 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 0/9] isdn4linux: add drivers for Siemens Gigaset ISDN DECT PABX
Message-ID: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add drivers for the Siemens Gigaset 3070 family of
ISDN DECT PABXes connected via USB, either directly or over a DECT link
using a Gigaset M105 or compatible DECT data adapter. The devices are
integrated as ISDN adapters within the isdn4linux framework, supporting
incoming and outgoing voice and data connections, and also as tty
devices providing access to device specific AT commands.

Supported devices include models 3070, 3075, 4170, 4175, SX205, SX255,
and SX353 from the Siemens Gigaset product family, as well as the
technically identical models 45isdn and 721X from the Deutsche Telekom
Sinus series. Supported DECT adapters are the Gigaset M105 data and the
technically identical Gigaset USB Adapter DECT, Sinus 45 data 2, and
Sinus 721 data (but not the Gigaset M34 and Sinus 702 data which
advertise themselves as CDC-ACM devices).

These drivers have been developed over the last four years within the
SourceForge project http://sourceforge.net/projects/gigaset307x/. They
are being used successfully in several installations for dial-in
Internet access and for voice call switching with Asterisk.

This is our second attempt at submitting these drivers, taking into
account the comments we received to our first submission on 2005-12-11.

The patch set adds three kernel modules:

- a common module "gigaset" encapsulating the common logic for
  controlling the PABX and the interfaces to userspace and the
  isdn4linux subsystem.

- a connection-specific module "bas_gigaset" which handles
  communication with the PABX over a direct USB connection.

- a connection-specific module "usb_gigaset" which does the same
  for a DECT connection using the Gigaset M105 USB DECT adapter.

We also have a module "ser_gigaset" which supports the Gigaset M101
RS232 DECT adapter, but we didn't judge it fit for inclusion in the
kernel, as it does direct programming of a i8250 serial port. It
should probably be rewritten as a serial line discipline but so far we
lack the neccessary knowledge about writing a line discipline for that.

The drivers have been working with kernel releases 2.2 and 2.4 as well
as 2.6, and although we took efforts to remove the compatibility code
for this submission, it probably still shows in places. Please make
allowances.

The patch has been split into 9 parts to comply to size limits.
All of the parts are designed to be applied together.

The patches are based on kernel release 2.6.16-rc2, in particular with
respect to the recent tty changes. If it is more appropriate to base it
on 2.6.15 at this time please let us know.
