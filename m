Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUJAXqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUJAXqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 19:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUJAXqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 19:46:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:27339 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266810AbUJAXqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 19:46:01 -0400
Date: Fri, 1 Oct 2004 16:49:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4 ps hang ?
Message-Id: <20041001164938.3231482e.akpm@osdl.org>
In-Reply-To: <1096672002.12861.84.camel@dyn318077bld.beaverton.ibm.com>
References: <1096646925.12861.50.camel@dyn318077bld.beaverton.ibm.com>
	<20041001120926.4d6f58d5.akpm@osdl.org>
	<1096666140.12861.82.camel@dyn318077bld.beaverton.ibm.com>
	<20041001145536.182dada9.akpm@osdl.org>
	<1096672002.12861.84.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Here is the full sysrq-t output.

What's this guy up to?

db2fmcd       D 0000000000000000     0 11032      1          1373 11031 (NOTLB)
00000101b9b9bef8 0000000000000002 0000003700000037 00000101c13608a0 
       000000010000009f 0000010199649250 0000010199649588 0000000000000000 
       0000000000000206 ffffffff801353db 
Call Trace:<ffffffff801353db>{try_to_wake_up+971} <ffffffff80445570>{__down_write+128} 
       <ffffffff80125e7f>{sys32_mmap+143} <ffffffff80124b01>{ia32_sysret+0} 
       

Something is seriously screwed up if it's stuck in try_to_wake_up().  Tried
generating a few extra traces?

Then again, maybe we're missing an up_read() somewhere.  hrm, I'll check.
