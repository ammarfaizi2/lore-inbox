Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261656AbTCKXSo>; Tue, 11 Mar 2003 18:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261671AbTCKXSo>; Tue, 11 Mar 2003 18:18:44 -0500
Received: from pat.uio.no ([129.240.130.16]:57218 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261656AbTCKXSo>;
	Tue, 11 Mar 2003 18:18:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15982.29010.906012.186099@charged.uio.no>
Date: Wed, 12 Mar 2003 00:29:22 +0100
To: joe.korty@ccur.com (Joe Korty)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.4.20-rc3 change broke NFS
In-Reply-To: <200303112319.XAA15215@rudolph.ccur.com>
References: <15982.23313.285256.769067@charged.uio.no>
	<200303112319.XAA15215@rudolph.ccur.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Joe Korty <jak@rudolph.ccur.com> writes:

    >> You are actually probably hitting a hole in the file. If the
    >> client has written beyond the eof, but not yet transmitted the
    >> data to the server, then you would indeed probably see an EIO.
    >>
    >> Your fix is probably correct, but could you just cross-check by
    >> seeing if the appended patch also fixes the problem?



     > Hi Trond, Your fix to nfs_readpage_result worked.  There may be
     > a small hole remaining, which the following closes.  This also
     > worked.

     > - if (data->res.eof || page_index(page) <= inode->i_size >>
     >   PAGE_CACHE_SHIFT)
     > + if (data->res.eof || page_index(page) <
     >   PAGE_CACHE_ALIGN(inode->i_size) >> PAGE_CACHE_SHIFT)

Thanks.

Cheers,
  Trond
