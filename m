Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbULJHg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbULJHg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 02:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbULJHg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 02:36:28 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39401 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261718AbULJHgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 02:36:25 -0500
Date: Fri, 10 Dec 2004 08:36:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [audit] Upstream solution for auditing file system objects
In-Reply-To: <20041209174610.K469@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.53.0412100832530.27203@yvahk01.tjqt.qr>
References: <f2833c760412091602354b4c95@mail.gmail.com>
 <20041209174610.K469@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Some notable design problems to introduce now are with the "identity"
>> of Y file/directory with respect to the kernel.  In fact, we only
>> really care about paths of which file/directory Y completes.  I.e: If
>> we want to audit /etc/shadow, we might not care if /etc/shadow is
>> moved to /tmp/shadow.  This means that any access/alteration of
>
>Of course you would.  A mv to /tmp/shadow includes an unlink, which
>should be an auditable event.

Does it really? If /etc and /tmp reside on the same filesystem, only a rename()
is done as to my knowledge (and possibly, an fs-specific rebalance). And if
they are on the same fs, they might even keep the inode number.

>> /tmp/shadow would go unnoticed (unless otherwise specified).  However,
>> if /tmp/shadow were a hardlink to /etc/shadow, we would then still
>> care, because we are still effectively /etc/shadow... if that makes
>> sense :-)

(Your mentioning of hardlinks proves my assumption of you having /etc and /tmp
on the same fs.)


Jan Engelhardt
-- 
ENOSPC
