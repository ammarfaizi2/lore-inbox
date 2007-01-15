Return-Path: <linux-kernel-owner+w=401wt.eu-S1750725AbXAOOQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbXAOOQ2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 09:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbXAOOQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 09:16:28 -0500
Received: from [195.171.73.133] ([195.171.73.133]:38964 "EHLO
	pelagius.h-e-r-e-s-y.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750725AbXAOOQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 09:16:27 -0500
Message-ID: <45AB8CB9.2000209@walrond.org>
Date: Mon, 15 Jan 2007 14:16:25 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Initramfs and /sbin/hotplug fun
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the initramfs root filesystem contains /sbin/hotplug, the kernel 
starts calling it very early in the kernel boot process, well before 
/init has been called. In my case this resulted in lots of hotplug 
segfault messages as the kernel boots, followed by a thoroughly unhappy 
hotplug+udev once /init actually gets control.

To solve this, I deleted /sbin/hotplug from the initramfs archive and 
modified /init to reinstate it once it gets control. This works fine, 
but seems inelegant. Is there a better solution? Should sbin/hotplug be 
called at all before the kernel has passed control to /init?

Andrew Walrond
