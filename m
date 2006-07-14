Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbWGNQL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbWGNQL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbWGNQL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:11:58 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:64735 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1161147AbWGNQL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:11:57 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
To: Eric Dumazet <dada1@cosmosbay.com>, Jeff Mahoney <jeffm@suse.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Reply-To: 7eggert@gmx.de
Date: Fri, 14 Jul 2006 18:10:49 +0200
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G1QFx-0001IO-K6@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
> On Wednesday 12 July 2006 18:42, Jeff Mahoney wrote:

>>  On systems with block devices containing slashes (virtual dasd, cciss,
>>  etc), reiserfs will fail to initialize /proc/fs/reiserfs/<dev> due to
>>  it being interpreted as a subdirectory. The generic block device code
>>  changes the / to ! for use in the sysfs tree. This patch uses that
>>  convention.
>>
>>  Tested by making dm devices use dm/<number> rather than dm-<number>
> 
> Your patch handles at most one slash. But the description mentions 'slashes'
> (ie several slashes)

Besides that, there is no reason to prevent the user from using many slashes.
OTOH, I'd prefer propper quoting, but having each driver do this would be
insane.

> Maybe you need a loop
> 
> while (s) {
[...]

s = bdev;
while (s = strchr(s, '/'))
        *s = '!';
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
