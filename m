Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266633AbSKOUJY>; Fri, 15 Nov 2002 15:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266701AbSKOUJY>; Fri, 15 Nov 2002 15:09:24 -0500
Received: from pat.uio.no ([129.240.130.16]:14017 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S266633AbSKOUJX>;
	Fri, 15 Nov 2002 15:09:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15829.22032.166977.73195@helicity.uio.no>
Date: Fri, 15 Nov 2002 21:16:16 +0100
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, richard@bouska.cz
Subject: Re: NFS mountned  directory  and apache2 (2.5.47)
In-Reply-To: <79A23782BB8@vcnet.vc.cvut.cz>
References: <79A23782BB8@vcnet.vc.cvut.cz>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Petr Vandrovec <VANDROVE@vc.cvut.cz> writes:

     > It does not change anything on the brokeness of apache2 (or
     > maybe glibc). It must be able to revert to read/write loop if
     > sendfile fails with EINVAL. There is no guarantee that existing
     > sendfile() API means that you can use it with all filesystems.

I disagree. Sendfile can *always* be emulated using the standard file
'read' method.

For most filesystems, that means just reading directly from the page
cache, and that is precisely what generic_file_sendfile() does. IIRC,
the sendfile() inode op was added so that those few filesystems which
don't support direct reading of the page cache could roll their own.

Cheers,
  Trond
