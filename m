Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261672AbTCKXI3>; Tue, 11 Mar 2003 18:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261673AbTCKXI3>; Tue, 11 Mar 2003 18:08:29 -0500
Received: from users.ccur.com ([208.248.32.211]:58554 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S261672AbTCKXI2>;
	Tue, 11 Mar 2003 18:08:28 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200303112319.XAA15215@rudolph.ccur.com>
Subject: Re: [RFC] 2.4.20-rc3 change broke NFS
To: trond.myklebust@fys.uio.no
Date: Tue, 11 Mar 2003 18:19:03 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <15982.23313.285256.769067@charged.uio.no> from "Trond Myklebust" at Mar 11, 2003 10:54:25 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You are actually probably hitting a hole in the file. If the client
> has written beyond the eof, but not yet transmitted the data to the
> server, then you would indeed probably see an EIO.
> 
> Your fix is probably correct, but could you just cross-check by seeing
> if the appended patch also fixes the problem?



Hi Trond,
Your fix to nfs_readpage_result worked.  There may be a small hole
remaining, which the following closes.  This also worked.

- if (data->res.eof || page_index(page) <= inode->i_size >> PAGE_CACHE_SHIFT)
+ if (data->res.eof || page_index(page) < PAGE_CACHE_ALIGN(inode->i_size) >> PAGE_CACHE_SHIFT)

Thanks for your help,
(I'll leave it to you to submit the patch you think best to Marcello and/or Linus).       
Joe
