Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbUBYBfD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbUBYBfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:35:03 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:42446 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262350AbUBYBev convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:34:51 -0500
Subject: [PATCH] request_firmware(): fixes and polishing.
In-Reply-To: Manuel Estrada Sainz <ranty@debian.org>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Feb 2004 02:34:48 +0100
Message-Id: <10776728882704@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, jt@hpl.hp.com,
       Simon Kelley <simon@thekelleys.org.uk>
Content-Transfer-Encoding: 7BIT
From: Manuel Estrada Sainz <ranty@ranty.pantax.net>
X-SA-Exim-Mail-From: ranty@ranty.pantax.net
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

 Please apply.

 Dmitry Torokhov has been criticizing my code for some days (Thanks Dmitry),
 and here is the result. It should be ready for -mm tree.
 
 Simon Kelly tested the patch series and reported improvement with some
 problems he was having.

On Fri, 06 Feb 2004 07:52:31 +0000, Simon Kelley wrote:
> I'm seeing problems when request_firmware() is called from the open()
> routine of the atmel driver if that is called as a result of  process
> which was started from /sbin/hotplug.
 
 Each patch starts with a changelog, but I'll write a full changelog
 here for the casual reader:

 - 01_request_firmware-misc-fix.diff
	- use vfree to free vmalloc memory.
	- Make sure fw_setup_class_device sets *class_dev_p to NULL in
	  all case of error.
	- Fix error handling in firmware_class_init.

 - 02_request_firmware-misc-polish.diff
	- Take advantage of strlcpy.
	- Extra error logging.
	- Use struct coping instead of memcpy.
	- Put all aborting code in a single place, and fully abort if
	  fw_realloc_buffer fails.
	- Abort on unexpected 'loading' values.

 - 03_request_firmware-state-tracking.diff
	- Make an status bitmap instead of using independent boolean
	  variables.  It will make things nicer later when new issues
	  need to be tracked.

 - 04_request_firmware-propper-release-1.diff
	- release 'struct firmware_priv' from class_dev->release.

 - 05_request_firmware-propper-release-2.diff
	- Remove races related to the handling and release of 'struct
	  firmware'

 - 06_request_firmware-rearrange.diff
	- Refactor fw_setup_class_device for readability and
	  maintainability.

 - 07_request_firmware-dont-remove-attr.diff
	- Don't remove attributes, they should be gone automatically.
 

 Have a nice day

 	Manuel

