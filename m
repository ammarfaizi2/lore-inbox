Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTJUVu5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbTJUVu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:50:57 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:55336 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263330AbTJUVu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:50:56 -0400
Date: Tue, 21 Oct 2003 14:45:55 -0700
To: linux-hotplug-devel@lists.sourceforge.net, gregkh@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 004 release
Message-ID: <20031021214554.GA7791@sgi.com>
Mail-Followup-To: linux-hotplug-devel@lists.sourceforge.net,
	gregkh@us.ibm.com, linux-kernel@vger.kernel.org
References: <20031021162856.GA1030@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021162856.GA1030@kroah.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the new release, Greg.  I just tried it out on a system with
some disks, but a bunch of udev processes ended up hanging.  Is there
something I'm missing or do you need a patch like this?

Thanks,
Jesse

--- udev-004/udev-add.c	Mon Oct 20 14:39:08 2003
+++ udev-004-working/udev-add.c	Tue Oct 21 14:42:27 2003
@@ -141,7 +141,7 @@
 	strcat(filename, path);
 	strcat(filename, "/dev");
 
-	while (loop < SECONDS_TO_WAIT_FOR_DEV) {
+	while (loop++ < SECONDS_TO_WAIT_FOR_DEV) {
 		dbg("looking for %s", filename);
 		retval = stat(filename, &buf);
 		if (retval == 0) {
