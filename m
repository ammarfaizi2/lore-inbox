Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTDLMHd (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 08:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTDLMHd (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 08:07:33 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:42164 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263258AbTDLMHc (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 08:07:32 -0400
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: linux-kernel@vger.kernel.org, Steven Dake <sdake@mvista.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Sat, 12 Apr 2003 14:18:37 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304121418.37473.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Dake wrote:

> I have not tried it, but dnotify should be generic and not fs specific.  
> If it doesn't work, it could be fixed to match other filesystem types...

It currently does not work for files that are modified by sysfs itself,
because the generic dnotify mechanism only works for file system operations
initiated by the user.

I have verified that adding calls to dnotify_parent() to sysfs_create and
sysfs_hash_and_remove makes it work. I'm not sure about the locking rules
there, so I'm not sending a patch but it should be trivial to do for
someone more familiar with the sysfs code.

	Arnd <><
