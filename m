Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUBQEOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 23:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUBQEOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 23:14:15 -0500
Received: from c-67-169-7-208.client.comcast.net ([67.169.7.208]:50304 "EHLO
	beeble.homelinux.net") by vger.kernel.org with ESMTP
	id S265955AbUBQEON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 23:14:13 -0500
Message-ID: <4031950F.2040406@lbl.gov>
Date: Mon, 16 Feb 2004 20:14:07 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix make rpm in 2.6 when using RH9 or Fedora..
References: <402BD507.2040201@lbl.gov> <402EE151.4000807@tmr.com> <403008C0.1070806@lbl.gov> <20040216210121.GD2977@mars.ravnborg.org>
In-Reply-To: <20040216210121.GD2977@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
>
> Please forward the original patch to Andrew for inclusion.
> 
> 	Sam

Andrew; Sam asked me to forward this to you for inclusion into the next 2.6 kernel.

thanks!

Short description:

Doing a 'make rpm' with any linux-2.6 (or probably, even linux-2.4 kernel) will fail with the current RH9/Fedora RPM macros.

The failure message is this:

Processing files: kernel-debuginfo-2.6.3rc1mm1-12
error: Could not open %files file /usr/src/redhat/BUILD/kernel-2.6.3rc1mm1/debugfiles.list: No such file or directory


RPM build errors:
   Could not open %files file /usr/src/redhat/BUILD/kernel-2.6.3rc1mm1/debugfiles.list: No such file or directory
make: *** [rpm] Error 1


The fix is this patch:

--- linux-2.6/scripts/mkspec    2004-01-08 22:59:04.000000000 -0800
+++ linux-2.6.3-rc1-mm1/scripts/mkspec  2004-02-12 00:02:55.000000000 -0800
@@ -37,6 +37,7 @@
 echo "BuildRoot: /var/tmp/%{name}-%{PACKAGE_VERSION}-root"
 echo "Provides: $PROVIDES"
 echo "%define __spec_install_post /usr/lib/rpm/brp-compress || :"
+echo "%define debug_package %{nil}"
 echo ""
 echo "%description"
 echo "The Linux Kernel, the operating system core itself"

