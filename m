Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267413AbUIAR3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUIAR3f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267403AbUIAR3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:29:18 -0400
Received: from holomorphy.com ([207.189.100.168]:57286 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267361AbUIAR1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:27:15 -0400
Date: Wed, 1 Sep 2004 10:27:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <kksx@mail.ru>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [1/7] make do_each_task_pid()/while_each_task_pid() typecheck
Message-ID: <20040901172710.GE5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <kksx@mail.ru>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1C2TZ1-000JZr-00.kksx-mail-ru@f7.mail.ru> <20040901153624.GA5492@holomorphy.com> <20040901165808.GD5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901165808.GD5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 08:36:24AM -0700, William Lee Irwin III wrote:
>> Could you not rename struct pid and not rename for_each_task_pid()?

On Wed, Sep 01, 2004 at 09:58:08AM -0700, William Lee Irwin III wrote:
> On closer examination for_each_task_pid() appears to need
> do { ... } while () -like semantics in your scheme, which is nasty
> as it allows a ne class of mismatching argument errors, but I suppose
> merits the renaming.

list_empty(&task->pids[type].hash_list) does not successfully typecheck;
while this does not correct its semantics, it at least restores
typechecking long enough for the code to be examined.

Index: kirill-2.6.9-rc1-mm2/include/linux/pid.h
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/include/linux/pid.h	2004-09-01 08:44:05.770684392 -0700
+++ kirill-2.6.9-rc1-mm2/include/linux/pid.h	2004-09-01 08:49:14.584737520 -0700
@@ -49,7 +49,7 @@
 			task = pid_task(task->pids[type].pid_list.next,	\
 						type);			\
 			prefetch(task->pids[type].pid_list.next);	\
-		} while (list_empty(&task->pids[type].hash_list));	\
+		} while (task->pids[type].hash_list.next);	\
 	}
 
 #endif /* _LINUX_PID_H */
