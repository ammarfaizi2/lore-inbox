Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTEIJV7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 05:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTEIJV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 05:21:59 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:7886 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262410AbTEIJV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 05:21:58 -0400
Date: Fri, 9 May 2003 11:32:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: davem@redhat.com, kernel list <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: ioctl32_unregister_conversion & modules
Message-ID: <20030509093250.GA638@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...what is the problem?

It seems that function pointers into modules do not need any special
treatmeant [I *know* there was talk about this on l-k; but I can't
find anything in Documentation/]:

                if (!capable(CAP_SYS_ADMIN))
                        return -EACCES;
                if (disk->fops->ioctl) {
                        ret = disk->fops->ioctl(inode, file, cmd, arg);
                        if (ret != -EINVAL)
                                return ret;
                }

So... what's the problem with {un}register_ioctl32_conversion being
called from module_init/module_exit? Drivers in the tree do it
already...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
