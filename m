Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWB0GYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWB0GYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWB0GYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:24:40 -0500
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:54495 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S1751038AbWB0GYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:24:39 -0500
Date: Mon, 27 Feb 2006 07:23:10 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 0/7] isdn4linux: add drivers for Siemens Gigaset ISDN DECT PABX
Message-ID: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de>
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

The patch set adds three kernel modules:

- a common module "gigaset" encapsulating the common logic for
  controlling the PABX and the interfaces to userspace and the
  isdn4linux subsystem.

- a connection-specific module "bas_gigaset" which handles
  communication with the PABX over a direct USB connection.

- a connection-specific module "usb_gigaset" which does the same
  for a DECT connection using the Gigaset M105 USB DECT adapter.

The drivers have been working with kernel releases 2.2 and 2.4 as well
as 2.6, and although we took efforts to remove the compatibility code
for this submission, it probably still shows in places. Please make
allowances.

This is our third take at submitting these drivers, based on kernel
release 2.6.16-rc4 and taking into account the comments we received
on the first two submissions. It supersedes the patchset
isdn4linux-siemens-gigaset-drivers-* in the -mm tree.

The patch has been split into 7 parts to comply to size limits.
All of the parts are designed to be applied in order. The last part
activates the set by adding a Makefile and Kconfig file and hooking
them into those of the isdn4linux subsystem.
