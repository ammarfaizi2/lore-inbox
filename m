Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVBBS6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVBBS6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVBBSzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:55:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41349 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262510AbVBBStv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:49:51 -0500
Date: Wed, 2 Feb 2005 13:49:45 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-os@analogic.com
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Joe User DOS kills Linux-2.6.10
In-Reply-To: <Pine.LNX.4.61.0502021314340.5410@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0502021346150.14232@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0502021314340.5410@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, linux-os wrote:

> When I compile and run the following program:

> ./xxx `yes`

It looks like the program itself doesn't matter, since it's
bash that's eating up memory like crazy, until the point where
it is OOM killed.

   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
32191 riel      18   0  436m 126m  312 R 45.9 86.9   0:13.37 bash
32222 riel      15   0  3276  148  124 S 39.0  0.1   0:09.79 yes

> Additional sense: Peripheral device write fault
> end_request: I/O error, dev sdb, sector 34605780
> SCSI error : <0 0 1 0> return code = 0x8000002
> Info fld=0x2100101, Deferred sdb: sense key Medium Error

Looks like your SCSI disk has some problems, you may want
to try running 'badblocks' on the swap partition to verify
that.  The VM doesn't appear to have a problem with your
test program, in my quick runs here.

ObLKML: I was running the test inside Xen, and that seemed
to hold up fine too ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
