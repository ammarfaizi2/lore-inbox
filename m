Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTEMQO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbTEMQO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:14:58 -0400
Received: from pat.uio.no ([129.240.130.16]:59894 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262297AbTEMQO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:14:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.7415.189762.803068@charged.uio.no>
Date: Tue, 13 May 2003 18:27:35 +0200
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
In-Reply-To: <20030513160948.GA6594@suse.de>
References: <20030512155417.67a9fdec.akpm@digeo.com>
	<20030512155511.21fb1652.akpm@digeo.com>
	<shswugvjcy9.fsf@charged.uio.no>
	<20030513135756.GA676@suse.de>
	<16065.3159.768256.81302@charged.uio.no>
	<20030513152228.GA4388@suse.de>
	<16065.4109.129542.777460@charged.uio.no>
	<20030513154741.GA4511@suse.de>
	<16065.5911.55131.430734@charged.uio.no>
	<20030513160948.GA6594@suse.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@codemonkey.org.uk> writes:

     > (16:30:08:root@tetrachloride:mesh)# ~/fsx voon truncating to
     > largest ever: 0x13e76 truncating to largest ever: 0x2e52c
     > truncating to largest ever: 0x3c2c2 truncating to largest ever:
     > 0x3f15f truncating to largest ever: 0x3fcb9 truncating to
     > largest ever: 0x3fe96 truncating to largest ever: 0x3ff9d Size
     > error: expected 0x2126e stat 0x21546 seek 0x21546 LOG DUMP
     > (7665 total operations): 7666(242 mod 256): READ 0x1b20b thru
     > 0x215b7 (0x63ad bytes) 7667(243 mod 256): MAPWRITE 0x247ef thru
     > 0x26e9f (0x26b1 bytes) 7668(244 mod 256): WRITE 0x26fc thru
     > 0x11d2f (0xf634 bytes) 7669(245 mod 256): TRUNCATE DOWN from
     > 0x3b18c to 0x1cbfc 7670(246 mod 256): MAPREAD 0x7f92 thru
     > 0xd860 (0x58cf byte ....  etc...

Ah... mmap()ed writes + truncate()...

OK. There's currently a known problem here which appears both in 2.4.x
and 2.5.x: we appear to be incapable of flushing out all the dirty
pages prior to truncating the file. The usual
filemap_fdatasync()/filemap_fdatawait() appears to be subject to races
with VM swapping.

Could we have some help from the VM experts on this one?

Cheers,
  Trond
