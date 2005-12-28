Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVL1Mp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVL1Mp4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 07:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVL1Mp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 07:45:56 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:30591 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964801AbVL1Mpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 07:45:55 -0500
Message-ID: <43B28996.7060006@sw.ru>
Date: Wed, 28 Dec 2005 15:48:22 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, simon.derr@bull.net, pj@sgi.com,
       linux-kernel@vger.kernel.org, "Denis V. Lunev" <den@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: cpusets: BUG: cpuset_excl_nodes_overlap() may sleep under tasklist_lock
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, there is an obvious bug in cpusets in 2.6.15-rcX:
cpuset_excl_nodes_overlap() may sleep (as it takes semaphore), but is 
called from atomic context - select_bad_process() under tasklist_lock.
BUG. Found by Denis Lunev.

the same actually applies to cpuset_zone_allowed() which is called e.g. 
from __alloc_pages()->get_page_from_freelist() and doesn't check for 
GPF_NOATOMIC anyhow...

Kirill

