Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269616AbUICKBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269616AbUICKBw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269589AbUICJ7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:59:17 -0400
Received: from holomorphy.com ([207.189.100.168]:43139 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269587AbUICJzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:55:41 -0400
Date: Fri, 3 Sep 2004 02:55:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [1/4] standardize bit waiting data type
Message-ID: <20040903095538.GQ3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin Wilck <martin.wilck@fujitsu-siemens.com>,
	linux-kernel@vger.kernel.org
References: <2xoKb-2Pa-27@gated-at.bofh.it> <2y3X5-73V-37@gated-at.bofh.it> <2y46A-798-17@gated-at.bofh.it> <2y4T1-7GM-17@gated-at.bofh.it> <2y52E-7Li-11@gated-at.bofh.it> <2y5ci-7Qz-7@gated-at.bofh.it> <2y5m3-7VH-5@gated-at.bofh.it> <2y7Hd-1aP-21@gated-at.bofh.it> <41383F33.4050503@fujitsu-siemens.com> <20040903094247.GP3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903094247.GP3106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 11:53:55AM +0200, Martin Wilck wrote:
>> Why don't you need a do..while loop any more ?
>> There is also no loop in __wait_on_bit() in the completed patch series.

On Fri, Sep 03, 2004 at 02:42:47AM -0700, William Lee Irwin III wrote:
> Part of the point of filtered waitqueues is to reestablish wake-one
> semantics. This means two things:
> (a) those waiting merely for a bit to clear with no need to set it,
> 	i.e. all they want is to know a transition from set to
> 	clear occurred, are only woken once and don't need to loop
> 	waking and sleeping
> (b) Of those tasks waiting for a bit to clear so they can set it
> 	exclusively, only one needs to be woken, and after the first
> 	is woken, it promises to clear the bit again, so there is no
> 	need to wake more tasks.

Also, (a) still works in the presence of signals with interruptible
waits (which the VM and VFS do not now use); the sleeping function is
required to return -EINTR or some other nonzero value to indicate
abnormal termination, which in turn must be checked by the caller.


-- wli
