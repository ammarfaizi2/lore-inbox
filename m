Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTJ3J7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 04:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTJ3J7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 04:59:08 -0500
Received: from pan.togami.com ([66.139.75.105]:24194 "EHLO pan.mplug.org")
	by vger.kernel.org with ESMTP id S262310AbTJ3J7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 04:59:03 -0500
Subject: 32bit agpgart + DRI on AMD64 K8 chipset
From: Warren Togami <warren@togami.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1067507896.26667.22.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Wed, 29 Oct 2003 23:58:16 -1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Software:
Fedora Core 0.95 x86
Hardware:
MSI Neo Athlon64 3200+
VIA north and southbridge
Built by ATI Radeon 9200 128MB

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=107805
Please read this report for lspci, dmesg, XFree86.0.log and other
information relating to this problem.

I was having trouble getting my Radeon 9200 working properly with DRI 3D
acceleration.  DRI reports as "Yes" by glxinfo, but upon closer
inspection, the rawhide 2.4.22 based kernel was failing to load agpgart,
thus XFree86 was falling back successfully to pcigart.

(This problem is due to the existence of more than one "northbridge",
and the correct northbridge is actually onboard the AMD64 processor
itself.)

Dave Jones suggested that I try the agpgart improvements in Marcelo's
2.4.23-pre8.  I merged in everything from that patch that seemed
relevant (although I did not look at the drm improvements), and agpgart
now successfully loads.  Strangely though XFree86 still behaved with
equally slow behavior.  Inspection of XFree86.0.log revealed that it was
failing to use agpgart, and again falling back to pcigart.

Just to confirm that I didn't make any mistakes while merging, vanilla
2.4.23-pre8 exhibits the same behavior.

My unskilled cursory inspection of the drivers/char/agp/* code makes it
appear that the AMD_8151 stuff is intended to work only in x86_64 mode,
and it wasn't designed with 32bit in mind?  I guess not though...
because it compiles fine in 32bit.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=107805
Please read this report for more details about my testing.

Any ideas of other things to try?

Thanks,
Warren Togami
warren@togami.com


