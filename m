Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTILSWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTILSVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:21:08 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:17630 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S261838AbTILSUi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:20:38 -0400
Message-ID: <3F620E7B.4090706@cox.net>
Date: Fri, 12 Sep 2003 11:20:43 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5 _IOR/_IOW changes are breaking userspace
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to bring up this discussion again, but the situation is getting 
worse. Previously, it was only apps that needed to issue sysctls that 
would break with the new kernel headers.

As of 2.6.0-test5, many apps that issue ioctls can no longer be 
compiled using the kernel headers that they have always used. So far 
this morning I have found three parts of util-linux-2.12, and at least 
one in mdadm-1.3.0. As I continue my build I suspect device-mapper, 
xfsprogs, mt-st and others will also have failures. The worst part is 
that the changes required to get the apps to compile are incompatible 
with all previous kernel headers.

As things get closer to 2.6.0 (for real), this is going to become a 
larger and larger problem. Without a set of userspace-compatible 
kernel headers available (and it sounds like the project to do that 
for real is 2.7 material), userspace applications have to be compiled 
against older "sanitized" headers that may not include new kernel 
features at all.

In the particular case of the ioctls used by util-linux and mdadm, 
using the RedHat "sanitized" headers would not be a problem. However, 
I want to compile device-mappper using its new version 4 ioctls, which 
I suspect are not included in the sanitized headers because they are 
not in 2.4 at all. I also need my kernel header package to include XFS 
  headers, and they are not a standard part of 2.4 either.

