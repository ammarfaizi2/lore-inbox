Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbTIDUjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264837AbTIDUjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:39:13 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:13440 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S262077AbTIDUi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:38:56 -0400
Message-ID: <3F57A15F.4050804@kroon.co.za>
Date: Thu, 04 Sep 2003 22:32:31 +0200
From: Jaco Kroon <jaco@kroon.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ipt_ULOG.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem in ipt_ULOG.c on older kernel versions (2.4.18 
confirmed).

The problem is with shifting and not shifting of the nl groups.  This 
has already been fixed in later versions (Version 2.4.21 if I'm not 
mistaken).  It is also fixed in the 2.5 and 2.6 series of the kernel.

This problem can be used to execute a DOS attack on vulnerable servers. 
  Vulnerable servers are those that makes use of the ULOG target in 
netfilter with groups other than 1 (this just happens to work correctly 
since the group 1 also happens to shift into 1).  The other groups 
causes kernel memory corruption and in just about all my test cases to 
total system failure.  This can be triggered remotely by using hping to 
send a packet that will be logged by the ULOG target.

Also, not sure whether IPv6 is affected (I don't use it yet, so ...)

Jaco

