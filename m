Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVJJUvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVJJUvb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 16:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVJJUvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 16:51:31 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:31098 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751228AbVJJUvb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 16:51:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GXrsmdspU51+uXY8r1ljYCG1r5cLgqwbRiorr9L4o5vGP2RlRXLjM0NXcn8iPpb6W9rcStHKqLjHk86XkSdFgbEa6SueLBWdJ0JhPXXQof7kViN8j4EYsui4KXY9x4FyGG9zvMMty0QzLv5K69nDZmvn7MxLxVD42XIop+XlVVQ=
Message-ID: <ecb4efd10510101351q7264f104gdfd1b03085b42062@mail.gmail.com>
Date: Mon, 10 Oct 2005 16:51:30 -0400
From: Clem Taylor <clem.taylor@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: mq_open() fails with ENOMEM for 'large' message sizes?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having problems with mq_open() returning ENOMEM when trying
to allocate a large message queue (I want to open a queue with 3
1mbyte messages).

I increased the size of the sysctl limits:
fs.mqueue.msgsize_max = 1052672 (1M+4K)
fs.mqueue.msg_max = 256
fs.mqueue.queues_max = 256

On a 2.6.12 (i686) system with 2G of memory (with large swap), I can't
seem to create a single message queue with a message larger then 799K
and a 3 message queue with a message larger then 266K.

On a 2.6.13 (mips32) system with 64M of memory (no swap), I can't seem
to create a single message queue with a message larger then about
606K.

Any ideas where this limit is coming from? The maximum message size
doesn't seem to be proportional to the amount of physical memory. Is
there some additional tunable I need to adjust that would allow me to
create a message queue with larger messages?

                        Thanks,
                        Clem Taylor
