Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131811AbRCUWzw>; Wed, 21 Mar 2001 17:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131813AbRCUWzn>; Wed, 21 Mar 2001 17:55:43 -0500
Received: from mail.missioncriticallinux.com ([208.51.139.18]:19465 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S131811AbRCUWzc>; Wed, 21 Mar 2001 17:55:32 -0500
Message-ID: <3AB9313C.1020909@missioncriticallinux.com>
Date: Wed, 21 Mar 2001 17:54:52 -0500
From: "Patrick O'Rourke" <orourke@missioncriticallinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-pre6 i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Prevent OOM from killing init
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the system will panic if the init process is chosen by
the OOM killer, the following patch prevents select_bad_process()
from picking init.

Pat

--- xxx/linux-2.4.3-pre6/mm/oom_kill.c  Tue Nov 14 13:56:46 2000
+++ linux-2.4.3-pre6/mm/oom_kill.c      Wed Mar 21 15:25:03 2001
@@ -123,7 +123,7 @@

         read_lock(&tasklist_lock);
         for_each_task(p) {
-               if (p->pid) {
+               if (p->pid && p->pid != 1) {
                         int points = badness(p);
                         if (points > maxpoints) {
                                 chosen = p;

-- 
Patrick O'Rourke
978.606.0236
orourke@missioncriticallinux.com

