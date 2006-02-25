Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWBYNVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWBYNVv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWBYNVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:21:51 -0500
Received: from ns.kam-telecom.ru ([86.109.192.26]:4485 "EHLO
	kt-sv-1.kam-telecom.ru") by vger.kernel.org with ESMTP
	id S1030232AbWBYNVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:21:49 -0500
X-Mailer: XFMail 1.5.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Date: Sat, 25 Feb 2006 18:21:28 +0500 (YEKT)
From: Victor Porton <porton@ex-code.com>
To: linux-kernel@vger.kernel.org
Subject: New reliability technique
Message-Id: <E1FCzMX-0000Ym-00@porton.narod.ru>
X-URL: http://porton.ex-code.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A minute ago I invented a new reliability enhancing technique.

In idle cycles (or periodically in expense of some performance) Linux can
calculate MD5 or CRC sums of _unused_ (free) memory areas and compare these
sums with previously calculated sums.

Additionally it can be done for allocated memory, if it will be write
protected before the first actual write. Moreover, all memory may be made
write-protected if it is not written e.g. more than a second. (When it
is written kernel would unlock it and allow to write, by a techniqie like
to how swap works.) If write-protected memory appears to be modified by
a check sum, this likewise indicates a bug.

If a sum is inequal, it would notice a bug in kernel or in hardware.

I suggest to add "Check free memory control sums" in config.

-- 
Victor Porton (porton@ex-code.com) - http://porton.ex-code.com
