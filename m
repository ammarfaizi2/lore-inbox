Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWAEPZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWAEPZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWAEPZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:25:14 -0500
Received: from eremit.is-kassel.org ([212.202.104.39]:13071 "EHLO
	eremit.is-kassel.org") by vger.kernel.org with ESMTP
	id S932065AbWAEPZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:25:12 -0500
Message-ID: <43BD3AB7.9020003@is-kassel.org>
Date: Thu, 05 Jan 2006 16:26:47 +0100
From: =?ISO-8859-1?Q?j=FCrgen_baumann?= <jbaumann@is-kassel.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.33pre1 kernel/sysctl.c missing spin_unlock()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

possibly fixed yet, but maybe not:

in above patch there was a spinlock(&sysctl_lock) added in 
function do_register_sysctl_table(), but no corresponding 
spin_unlock() before return.

after starting the new kernel (unfortunately with further 
patches), it hangs on trying to start the kswapd-thread.

after inserting the spin_unlock() all run fine.
