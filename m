Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265749AbUEZRwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265749AbUEZRwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 13:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265757AbUEZRwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 13:52:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:40846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265749AbUEZRvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 13:51:48 -0400
Date: Wed, 26 May 2004 10:51:47 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org, bridge@osdl.org
Subject: [announce] bridge-utilities 1.0
Message-Id: <20040526105147.650ddfa9@dell_ss3.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released a new version of the bridge-utilities to go with the recent
kernel changes.  The utilities have certainly matured enough to earn the
1.0 moniker. This release is fixes the internal issues that broke running 
32 bit utilities on 64bit systems, and fixes scaling issues.

The tarball can be downloaded from:
	http://prdownloads.sourceforge.net/bridge

Changes:
	- Uses sysfs for bridge and port parameter changes.
	- Uses new ioctl's for add/delete bridges and interfaces
	  that are 32/64bit compatible. 
	- Allows 1000's of interfaces in a bridge.
	- Performance improvement with lots of bridges/interfaces
	- Better error handling
	- More complete configuration and build

Getting full functionality requires a build system with:
	- libsysfs from the sysfsutils package 
	  http://linux-diag.sourceforge.net/Sysfsutils.html
	- kernel (and headers) from 2.6.7-rc1 or later

Note: libsysfs has not been fully integrated by the main linux vendors.
So producing a full functional package is not possible with the default spec 
file.

The utilities will build (and run) on earlier systems it will just default to 
the old interface and which doesn't have 32/64 bit compatibility.

The API in libbridge changed, because it didn't scale to lots of interfaces. 
Previously, the library would read the status of all bridges and interfaces
when initialized. The new interface takes names (not objects) and looks more
like syscalls. Since libbridge is shipped as a static library, it will not
break binary utilities, but anything compiled from source would break.
Not a big issue because there is no existing standard package using the
bridge API anyway.

Ethernet bridging mailing list is bridge@osdl.org, to sign up
please use http://lists.osdl.org/mailman/listinfo/bridge


