Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbTCVKtU>; Sat, 22 Mar 2003 05:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbTCVKtU>; Sat, 22 Mar 2003 05:49:20 -0500
Received: from mons.uio.no ([129.240.130.14]:62093 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262107AbTCVKtS>;
	Sat, 22 Mar 2003 05:49:18 -0500
To: Richard Curnow <Richard.Curnow@superh.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: struct nfs_fattr alignment problem in nfs3proc.c
References: <20030321175206.GA17163@malvern.uk.w2k.superh.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 22 Mar 2003 12:00:16 +0100
In-Reply-To: <20030321175206.GA17163@malvern.uk.w2k.superh.com>
Message-ID: <shs7karzmwv.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Richard Curnow <Richard.Curnow@superh.com> writes:

     > In the nfs3_proc_unlink_setup function, there appears to be a
     > bug with the way kmalloc is used to allocate storage for two
     > structs grouped together.  The second struct ends up with a non
     > 8-byte aligned pointer, which can cause trouble later (in
     > xdr_decode_fattr) when stores occur to the u64 fields inside
     > it.  The following patch (on 2.4.19) fixes this problem, though
     > I'm not sure if it's the cleanest fix.  (I hit this when
     > working on the port to SH-5, which is currently baselined on
     > 2.4.19).

Why not just define

struct {
        struct nfs3_diropargs   arg;
        struct nfs_fattr        res;
} unlinkxdr;

and then kmalloc that?

Cheers,
  Trond
