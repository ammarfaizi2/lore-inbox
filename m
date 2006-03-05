Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751875AbWCEWDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbWCEWDx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCEWDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:03:53 -0500
Received: from AMarseille-252-1-25-171.w83-201.abo.wanadoo.fr ([83.201.170.171]:42989
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751875AbWCEWDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:03:52 -0500
To: torvalds@osdl.org (Linus Torvalds)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Organization: Uh?
Date: 05 Mar 2006 23:03:28 +0100
In-Reply-To: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
Message-ID: <m3wtf8tuq7.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@osdl.org (Linus Torvalds) writes:
> Have I missed anything? Holler. And please keep reminding about any 
> regressions since 2.6.15.

As reported yesterday [1], the generic irq framework for alpha introduced
in commit 0595bf3bca9d9932a05b06dd438f40f01d27cd33 kills my box under
fairly heavy disk usage. I got a md raid 0 array stripped accross 3 scsi
disks and any kind of relatively intensive IOs (like md5sum or sha1sum
against iso files) kill the box immediately; either it panics in
kernel/exit.c:do_exit - the first three "unlikely" - or in
arch/alpha/mm/fault.c:do_page_fault "Unable to handle paging reguest at
some address"...

Reverting it makes the box stable again (as it was under vanilla 2.6.15).

Here's the commit detail:

0595bf3bca9d9932a05b06dd438f40f01d27cd33 is first bad commit
diff-tree 0595bf3bca9d9932a05b06dd438f40f01d27cd33 (from eee45269b0f5979c70bc151c6c2f4e5f4f5ababe)
Author: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Date:   Fri Jan 6 00:12:22 2006 -0800

    [PATCH] Alpha: convert to generic irq framework (alpha part)

    Kconfig tweaks and tons of deletions.

    Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
    Cc: Christoph Hellwig <hch@lst.de>
    Cc: Richard Henderson <rth@twiddle.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 ac127f16325bb65941bd38208325ab7821877f52 15d7d4d17a7c8cfb8fe53c29ded31ff9cf287534 M      arch
:040000 040000 287f73cdf371b2b33cc48f1d876005aab29ff3de 29263093ae33ceccd6346b987870367bc8329f0a M      include


[1] Problem on Alpha with "convert to generic irq framework"
Message-Id: <20060304111219.GA10532@localhost>
http://lkml.org/lkml/2006/3/4/31

-- 
Mathieu Chouquet-Stringer
