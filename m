Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbTENIxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTENIxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:53:16 -0400
Received: from pat.uio.no ([129.240.130.16]:49365 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261158AbTENIxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:53:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16066.1778.401988.753875@charged.uio.no>
Date: Wed, 14 May 2003 11:05:54 +0200
To: Andrew Morton <akpm@digeo.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] htree nfs fix
In-Reply-To: <20030513174425.2bc49803.akpm@digeo.com>
References: <16065.35997.348432.385925@charged.uio.no>
	<20030513174425.2bc49803.akpm@digeo.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@digeo.com> writes:

     > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
    >>
    >> If you're unhappy with the state of readdir, then fix the
    >> VFS/glibc.

     > What should be done?

Either we have to agree that we break legacy 32-bit getdents() and
treat all cookies as signed 32/64-bit, or we break getdents64(), and
treat all cookies as unsigned. (This applies to both 2.5.x and 2.4.x)

The former will (IIRC) break setups with those IRIX servers that like
to use 0xFFFFFFFF as an end-of-readdir marker. It also requires an
extra patch in order to mangle the otherwise unsigned NFS
cookies. (This patch has been ready but withheld from the official
kernel tree pending a decision on this issue for at least 2 years -
hence my irritation whenever this subject comes up)

The latter will break glibc, which likes to abuse getdents64() and
simply test for signed 32-bit overflow in place of using the 32-bit
getdents().

Cheers,
  Trond
