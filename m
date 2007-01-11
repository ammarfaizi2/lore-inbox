Return-Path: <linux-kernel-owner+w=401wt.eu-S965315AbXAKHfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965315AbXAKHfM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 02:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965318AbXAKHfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 02:35:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:60720 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965315AbXAKHfL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 02:35:11 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: kvm-devel@lists.sourceforge.net
Subject: Re: [kvm-devel] [RFC] Stable kvm userspace interface
Date: Thu, 11 Jan 2007 08:34:43 +0100
User-Agent: KMail/1.9.5
Cc: Jeff Garzik <jeff@garzik.org>, Avi Kivity <avi@qumranet.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <45A39A97.5060807@qumranet.com> <45A39D0D.7090007@garzik.org>
In-Reply-To: <45A39D0D.7090007@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701110834.43800.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 January 2007 14:47, Jeff Garzik wrote:
> Can we please avoid adding a ton of new ioctls?  ioctls inevitably 
> require 64-bit compat code for certain architectures, whereas 
> sysfs/procfs does not.

For performance reasons, an ascii string based interface is not
desireable here, some of these calls should be optimized to
the point of counting cycles.

Sysfs also does not fit the use case at all, and procfs only
makes sense if you really want to keep all information about the
guest as part of the process directory it belongs to.

I still think that in the long term, we should migrate to
new system calls and a special file system for kvm, which
might be non-mountable. Those will of course have the same
32 bit compat problems as the ioctl approach, but so far,
Avi has kept a good watch on avoiding these problems.

As long as we think the interface is likely to change (which it
certainly is right now), I believe that ioctl is the right
interface. We can think about retiring it when the interface has
stabilized enough to be converted to syscalls.

	Arnd <><
