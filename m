Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbUKIRnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUKIRnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 12:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbUKIRnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 12:43:43 -0500
Received: from mail.gmx.de ([213.165.64.20]:36239 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261595AbUKIRnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 12:43:40 -0500
X-Authenticated: #21910825
Message-ID: <419101BE.1070400@gmx.net>
Date: Tue, 09 Nov 2004 18:43:26 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: errors during umount make SysRq fail
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

having removed an USB disk while umount for it was still running (yes,
that was stupid) I noticed that umount for this device hangs forever in
D state. That would be ok (consequences for user error), however *all*
other umounts I attempt also hang in D state and SysRq-U also hangs,
resulting in a broken system on the next reboot.

I assume the locking against concurrent umount is there to protect
against non-trivial namespace problems and makes sense for normal
umounting, but IIRC SysRq-U is there to ensure consistent filesystems
on the next startup. Would it make sense to allow SysRq-U to break
these locks?

Similar problem exists with SysRq-S. If syncing of one device hangs,
it will never proceed to the next one in the list. I agree that one
is not trivial (stacked devices, loop et al), but can't we make a
best effort to sync at least the physical devices in the machine?
Please don't shoot me for talking about physical devices, I know
there are some really grey areas trying to define that.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
