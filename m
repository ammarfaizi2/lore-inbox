Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbUKDCNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbUKDCNg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUKDCJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:09:49 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:24193 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262067AbUKDB7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:59:18 -0500
Date: Thu, 04 Nov 2004 10:59:08 +0900 (JST)
Message-Id: <20041104.105908.18574694.t-kochi@bq.jp.nec.com>
To: steiner@sgi.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
From: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
In-Reply-To: <20041103205655.GA5084@sgi.com>
References: <20041103205655.GA5084@sgi.com>
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For wider audience, added LKML.

From: Jack Steiner <steiner@sgi.com>
Subject: Externalize SLIT table
Date: Wed, 3 Nov 2004 14:56:56 -0600

> The SLIT table provides useful information on internode
> distances. Has anyone considered externalizing this
> table via /proc or some equivalent mechanism.
> 
> For example, something like the following would be useful:
> 
> 	# cat /proc/acpi/slit
> 	010 066 046 066
> 	066 010 066 046
> 	046 066 010 020
> 	066 046 020 010
> 
> If this looks ok (or something equivalent), I'll generate a patch....

For user space to manipulate scheduling domains, pinning processes
to some cpu groups etc, that kind of information is very useful!
Without this, users have no notion about how far between two nodes.

But ACPI SLIT table is too arch specific (ia64 and x86 only) and
user-visible logical number and ACPI proximity domain number is
not always identical.

Why not export node_distance() under sysfs?
I like (1).

(1) obey one-value-per-file sysfs principle

% cat /sys/devices/system/node/node0/distance0
10
% cat /sys/devices/system/node/node0/distance1
66

(2) one distance for each line

% cat /sys/devices/system/node/node0/distance
0:10
1:66
2:46
3:66

(3) all distances in one line like /proc/<PID>/stat

% cat /sys/devices/system/node/node0/distance
10 66 46 66

---
Takayoshi Kochi
