Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269247AbUJFOTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269247AbUJFOTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 10:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269248AbUJFOTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 10:19:40 -0400
Received: from main.gmane.org ([80.91.229.2]:17026 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269247AbUJFOTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 10:19:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: block till hotplug is done?
Date: Wed, 06 Oct 2004 20:19:32 +0600
Message-ID: <ck0utl$6o0$1@sea.gmane.org>
References: <1097005927.4953.4.camel@simulacron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 51-167.dial.utk.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
In-Reply-To: <1097005927.4953.4.camel@simulacron>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus wrote:
> Hi,
> 
> is there any way to block till all hotplug events are handled/
> the hotplug processes terminated?
> 
> For example
> 	fdisk
> 	mkfs
> fails, because after fdisk create a partition, and the kernel
> reread the partition table, called hotplug, hotplug called udev
> and udev created the matching /dev file, all of that might be
> too slow and mkfs might fail in the mean time.

You can't wait gracefully (i.e. without sleeping), but you can duplicate 
udev's work synchronously:

fdisk
udevstart
mkfs

I don't know if this is supposed to work (Greg KH: please comment on 
this). It _will_ work if sysfs entries are guaranteed to be created 
before the BLKRRPART ioctl returns.

-- 
Alexander E. Patrakov

