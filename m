Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268333AbUI2MWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268333AbUI2MWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268336AbUI2MWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:22:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14274 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268333AbUI2MWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:22:12 -0400
Date: Wed, 29 Sep 2004 13:22:11 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Subject: USER_DS vs oldfs
Message-ID: <20040929122211.GF16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A common idiom in the compat code is:

                old_fs = get_fs();
                set_fs(KERNEL_DS);
                ret = sys_fcntl(fd, (cmd == F_GETLK64) ? F_GETLK :
                                ((cmd == F_SETLK64) ? F_SETLK : F_SETLKW),
                                (unsigned long)&f);
                set_fs(old_fs);

Surely we know that the current 'fs' is USER_DS and so we could simply do:

                set_fs(KERNEL_DS);
                ret = sys_fcntl(fd, (cmd == F_GETLK64) ? F_GETLK :
                                ((cmd == F_SETLK64) ? F_SETLK : F_SETLKW),
                                (unsigned long)&f);
                set_fs(USER_DS);

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
