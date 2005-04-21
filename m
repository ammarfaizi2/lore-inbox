Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVDUPfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVDUPfF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 11:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVDUPfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 11:35:05 -0400
Received: from ns1.coraid.com ([65.14.39.133]:3768 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261442AbVDUPex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 11:34:53 -0400
To: Greg KH <greg@kroah.com>
Cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc2] aoe [1/6]: improve allowed interfaces
 configuration
References: <3VqSf-2z7-15@gated-at.bofh.it>
	<E1DOVtj-0003bF-6c@be1.7eggert.dyndns.org> <87y8bcjlpq.fsf@coraid.com>
	<20050421145658.GA27263@kroah.com>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 21 Apr 2005 11:30:06 -0400
In-Reply-To: <20050421145658.GA27263@kroah.com> (Greg KH's message of "Thu,
 21 Apr 2005 07:56:58 -0700")
Message-ID: <87pswoi1vl.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Greg KH <greg@kroah.com> writes:

> On Thu, Apr 21, 2005 at 09:36:17AM -0400, Ed L Cashin wrote:
>> "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" <7eggert@gmx.de> writes:
>> 
>> > Ed L Cashin <ecashin@coraid.com> wrote:
>> >
>> >> +++ b/Documentation/aoe/aoe.txt       2005-04-20 11:42:20.000000000 -0400
>> >
>> >> +  When the aoe driver is a module, use
>> >
>> > Is there any reason for this inconsistent behaviour?
>> 
>> Yes, the /sys/module/aoe area is only present when the aoe driver is a
>> module.
>
> Not true, have you looked in /sys/module lately?  :)
>
>> It would be nicer if there were a sysfs area where I could
>> put this file regardless of whether the driver is a module or built
>> into the kernel.  
>
> That's the place for it.  It will be there if the driver is built as a
> module or into the kernel.

Wow!  Well, that's very convenient for driver writers, so I'm pleased,
and I can update the docs.  It surprises me, though, to find out that
/sys/module is for things other than modules.

The correction below follows and depends on patch 1 of the six.


fix docs: built-in driver can use files in /sys/module

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>


--=-=-=
Content-Disposition: inline; filename=diff

diff -urNp a-exp/linux/Documentation/aoe/aoe.txt b-exp/linux/Documentation/aoe/aoe.txt
--- a-exp/linux/Documentation/aoe/aoe.txt	2005-04-21 11:25:48.000000000 -0400
+++ b-exp/linux/Documentation/aoe/aoe.txt	2005-04-21 11:25:49.000000000 -0400
@@ -102,12 +102,11 @@ USING SYSFS
       e4.8            eth1              up
       e4.9            eth1              up
 
-  When the aoe driver is a module, use
-  /sys/module/aoe/parameters/aoe_iflist instead of
-  /dev/etherd/interfaces to limit AoE traffic to the network
-  interfaces in the given whitespace-separated list.  Unlike the old
-  character device, the sysfs entry can be read from as well as
-  written to.
+  Use /sys/module/aoe/parameters/aoe_iflist (or better, the driver
+  option discussed below) instead of /dev/etherd/interfaces to limit
+  AoE traffic to the network interfaces in the given
+  whitespace-separated list.  Unlike the old character device, the
+  sysfs entry can be read from as well as written to.
 
   It's helpful to trigger discovery after setting the list of allowed
   interfaces.  The aoetools package provides an aoe-discover script

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

