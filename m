Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbUCMRCW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbUCMRCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:02:22 -0500
Received: from [213.227.237.65] ([213.227.237.65]:61848 "EHLO
	berloga.shadowland") by vger.kernel.org with ESMTP id S262688AbUCMRCV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:02:21 -0500
Subject: possible kernel bug in signal transit.
From: Alex Lyashkov <shadow@psoft.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: PSoft
Message-Id: <1079197336.13835.15.camel@berloga.shadowland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Sat, 13 Mar 2004 19:02:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All

I analyze kernel vanila 2.6.4 and found one possible bug in
__kill_pg_info function.

        for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
                err = group_send_sig_info(sig, info, p);
                if (retval)
                        retval = err;
        }
but I think if (retval) is incorrect check. possible this cycle must be
        for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
                err = group_send_sig_info(sig, info, p);
                if (ret) {
                        retval = err;
			break;
		}
        }
because in original variant me assign to retval only first value from
ret and other be ignored if this value be 0.


-- 
Alex Lyashkov <shadow@psoft.net>
PSoft
