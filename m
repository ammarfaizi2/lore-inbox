Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266516AbTGEWHu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 18:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbTGEWHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 18:07:50 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:59345 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S266516AbTGEWHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 18:07:49 -0400
Message-ID: <3F074F74.2090308@hipac.org>
Date: Sun, 06 Jul 2003 00:21:40 +0200
From: Thomas Heinz <creatix@hipac.org>
Reply-To: Thomas Heinz <creatix@hipac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: tc stack overflow
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Have you already crashed your kernel today? No? Well, try this one:

# tc qdisc add dev eth0 root handle 1: prio \
   for i in `seq 500` ; do tc qdisc add dev eth0 \
       parent $i:1 handle `expr $i + 1`: prio ; done ; \
   ping 1.2.3.4

[replace eth0 by a device of your choice]


I think some of you are aware of the problem but strangely I didn't
find any mention on linux-kernel or linux-netdev or lartc.

The problem is that the depth of the classification tree is not limited
in any way and since for every qdisc the corresponding enqueue function
is called we have a stack overflow here.

IMO the problem could be fixed by adding a depth parameter to the
enqueue function. This way the function can decide whether it is save
to go deeper down the tree (maybe subject to a global policy).

So, what do you think about the issue? Do you care?


Regards,

Thomas

