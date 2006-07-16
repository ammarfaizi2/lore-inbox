Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWGPUgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWGPUgv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 16:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWGPUgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 16:36:51 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:57740 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751135AbWGPUgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 16:36:50 -0400
Date: Sun, 16 Jul 2006 13:36:00 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc2 | UTS Release version does not match current version
Message-ID: <20060716203600.GZ11640@ca-server1.us.oracle.com>
Mail-Followup-To: Michael Krufky <mkrufky@linuxtv.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0607151523180.5623@g5.osdl.org> <44BA4E5E.7060803@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BA4E5E.7060803@linuxtv.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 10:34:06AM -0400, Michael Krufky wrote:
> I get this when building using debian's make-kpkg:
> 
> The UTS Release version in include/linux/version.h
>     ""
> does not match current version:
>     "2.6.18-rc2"
> Please correct this.

	make-kpkg uses version.h to get UTS_RELEASE.  UTS_RELEASE has
moved to utsrelease.h.

Right after you get the error, modify
debian/ruleset/misc/version_vars.mk 

-UTS_RELEASE_VERSION=$(shell if [ -f include/linux/version.h ]; then	 \
-                 grep 'define UTS_RELEASE' include/linux/version.h | \
+UTS_RELEASE_VERSION=$(shell if [ -f include/linux/utsrelease.h ]; then	 \
+                 grep 'define UTS_RELEASE' include/linux/utsrelease.h | \


And rerun your make-kpkg.  The above is not a valid patch, you'll have
to hand change it.

Joel

-- 

"All alone at the end of the evening
 When the bright lights have faded to blue.
 I was thinking about a woman who had loved me
 And I never knew"

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
