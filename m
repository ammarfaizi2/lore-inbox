Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTEGOxb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263630AbTEGOxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:53:31 -0400
Received: from pat.uio.no ([129.240.130.16]:4229 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263618AbTEGOxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:53:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16057.8409.117109.345706@charged.uio.no>
Date: Wed, 7 May 2003 17:06:01 +0200
To: Vladimir Serov <vserov@infratel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
In-Reply-To: <3EB91B6F.9020204@infratel.com>
References: <20030318155731.1f60a55a.skraw@ithnet.com>
	<3E79EAA8.4000907@infratel.com>
	<15993.60520.439204.267818@charged.uio.no>
	<3E7ADBFD.4060202@infratel.com>
	<shsof45nf58.fsf@charged.uio.no>
	<3E7B0051.8060603@infratel.com>
	<15995.578.341176.325238@charged.uio.no>
	<3E7B10DF.5070005@infratel.com>
	<15995.5996.446164.746224@charged.uio.no>
	<3E7B1DF9.2090401@infratel.com>
	<15995.10797.983569.410234@charged.uio.no>
	<3EB91B6F.9020204@infratel.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Vladimir Serov <vserov@infratel.com> writes:


     > when things are OK. Also the rpc client in this request is
     > c0d75060 which is mentioned in rpc queue status:

     > -pid- proc flgs status -client- -prog- --rqstp- -timeout
     > -rpcwait -action- --exit--
     > 09150 0001 0000 000000 c0d75060 100003 c8f99074 00000000
     > <NULL> c00f17b8 0


Looks like there is a hanging GETATTR call from another process that
is blocking your process.

Which procedure does c00f17b8 correspond to? You can use gdb on the
'vmlinux' file (NB!: *not* the compressed vmlinuz), then
'disassemble 0xc00f17b8').

Cheers,
  Trond
