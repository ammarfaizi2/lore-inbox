Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWG3R20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWG3R20 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWG3R20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:28:26 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:21157 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S932376AbWG3R2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:28:25 -0400
Message-ID: <44CCEC96.3020607@yahoo.fr>
Date: Sun, 30 Jul 2006 19:29:58 +0200
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc3 does not like an old udev (071)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When updating only the kernel to 2.6.18-rc3 on Ubuntu Dapper/x86, 
/dev/usblp0
is no more created on boot. If I manually create it, it works fine.

Vanilla udev from Dapper: version 079 (Documentation/Changes requires
udev 071 ;-) ).

git-bisect told me the culprit was
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=bd00949647ddcea47ce4ea8bb2cfcfc98ebf9f2a

Reverting only this commit makes an Oopsing kernel.

This patch was next to last in its serie:
http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg44538.html

Reverting the last patch in the serie (as well as the culprit found by 
git bisect):
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=43104f1da88f5335e9a45695df92a735ad550dda
fixes the problem.

Updating udev to 096, and using a normal 2.6.18-rc3 kernel works too, so 
maybe
the correct (albeit unpopular) fix is to update the udev requirement in
Documentation/Changes?

Thanks.

-- 
Guillaume

