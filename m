Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264133AbUDGHrP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 03:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264136AbUDGHrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 03:47:15 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:30427 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264133AbUDGHrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 03:47:13 -0400
Date: Wed, 7 Apr 2004 00:44:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, colpatch@us.ibm.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 17/23] mask v2 = [6/7] nodemask_t_ia64_changes
Message-Id: <20040407004437.3a078f28.pj@sgi.com>
In-Reply-To: <20040406235000.6c06af9a.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
	<20040401131240.00f7d74d.pj@sgi.com>
	<20040406043732.6fb2df9f.pj@sgi.com>
	<200404070855.03742.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040406235000.6c06af9a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several architectures have this large version of find_next_bit() code.

It may well make sense for the O(1) scheduler to be inlining this.

Perhaps these large versions should be renamed sched_find_next_bit(), as
is done for sched_find_first_bit(), and another, more space efficient
version provided under the name find_next_bit(), for use by others who
should prefer smaller code size.  The asm-generic version of this
smaller one might be something like [pseudo C]:

  int find_next_bit(addr, size, pos)
  {
	int i;
	for (i = pos; i < size; i++) {
		if (test_bit(i, addr))
			break;
	}
	return i;
  }

Arch's that have a reasonably tight version of find_next_bit() already
could use it for both sched_find_next_bit() and find_next_bit().

Just speculating ...

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
