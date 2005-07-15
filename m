Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVGOXUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVGOXUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 19:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVGOXUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 19:20:00 -0400
Received: from hastings.mumak.ee ([194.204.22.4]:26560 "EHLO hastings.mumak.ee")
	by vger.kernel.org with ESMTP id S261722AbVGOXT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 19:19:59 -0400
Subject: reiserfs+acl makes processes hang?
From: Tarmo =?ISO-8859-1?Q?T=E4nav?= <tarmo@itech.ee>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 15 Jul 2005 23:19:56 +0000
Message-Id: <1121469596.17539.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think I've found a bug in reiserfs acls. If triggered
it means that any program trying to access the partition,
where the bug occured, will just hang in D state, with
no way to kill the program.

Here's how to reproduce:
1. mount a reiserfs volume (loopmount will do) with "-o acl".
2. create a directory "dir"
3. set some default acl: setfacl -d -m u:username:rwX dir
4. cd dir
5. dd if=/dev/zero of=somefile1 bs=4k count=100000
(the idea is to run out of space)
6. now df should show 0 free space, if not then repeat 5.
7. echo "1" > somefile2 # this should hang infinitely

Now no program will be able to access the partition.

I haven't tried to reproduce it, but the same problem also happened
when a user hit his hard quota limit on my server. Then no program
could access his homedir.


PS. I'm not subscribed to lkml so please CC

--
Tarmo Tänav
tarmo@itech.ee

