Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVCIGnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVCIGnD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVCIGnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:43:03 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:61326 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262382AbVCIGmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:42:49 -0500
Subject: [RFC] Kdump: Dump Capture Mechanism
From: Vivek Goyal <vgoyal@in.ibm.com>
To: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 12:14:05 +0530
Message-Id: <1110350646.31878.8.camel@wks126478wss.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Well this discussion has been going on for quite sometime now that
what's the best way to capture the dump? There seems to be two lines of
arguments.

Export ELF view through /proc/vmcore
------------------------------------
This basically involves retrieving saved core image headers and
exporting those through /proc/vmcore interface. Further user space
applications can be built on top of it to do advanced processing.

Do Everything in user space
---------------------------
The whole idea is that do all the processing from user space (preferably
from ramdisk or so).

When it comes to requirements, Distros and developers seem to be having
somewhat different requirements.

Distros:
-------
- Fully automate the dump generation/capture process.
- Configure everything in advance (like, dump storage location).
- Upon crash, store dump image at pre-configured location and reboot
  into production kernel ASAP.

Developers:
----------
- Keyword is simple and easy to use solution.
- Should work well in a development environment where, not necessarily
  all the components (user space, kernel space) are in perfect harmony
  and things are yet to be stabilized.

IMO, exporting /proc/vmcore is a good idea. It offers wide variety of
choices to both developers and distros.

- It provides the basic dump capturing mechanism in kernel.

- Developers can store the dump image locally (cp) or transfer it over
  network (scp, ftp) using standard utilities and don't have to deal
  with additional user space utilites specifically designed for this
  purpose.

- Developers can directly run gdb on /proc/vmcore generated image and
  do the limited debugging without need of any other dump
  capture/analysis utility.

- Distros can build additional fully automated dump saving solutions on
  top of /proc/vmcore.  Be it a init script or a custom initial ramdisk
  or something else.......

So the whole idea is, that /proc/vmcore and user space solutions can co-
exist. And let the user/distros choose between these based on their
requirements.

I was planning to implement /proc/vmcore. Do you have any comments or
suggestions?

Thanks
Vivek

