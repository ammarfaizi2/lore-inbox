Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289201AbSA3Ndw>; Wed, 30 Jan 2002 08:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289208AbSA3Ndg>; Wed, 30 Jan 2002 08:33:36 -0500
Received: from zero.tech9.net ([209.61.188.187]:54796 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289201AbSA3NdX>;
	Wed, 30 Jan 2002 08:33:23 -0500
Subject: Re: [PATCH] 2.5: push BKL out of llseek
From: Robert Love <rml@tech9.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <shs3d0oi7zp.fsf@charged.uio.no>
In-Reply-To: <Pine.GSO.4.21.0201292349260.11157-100000@weyl.math.psu.edu> 
	<shs3d0oi7zp.fsf@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 30 Jan 2002 08:39:12 -0500
Message-Id: <1012397957.3219.27.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-30 at 03:00, Trond Myklebust wrote:

>> " " == Alexander Viro <viro@math.psu.edu> writes:
> 
>      > So I'd prefer to do it in two stages - shift BKL into
>      > ->llseek() and then see where it can be dropped/replaced with
>      > ->i_sem.
> 
> Seconded. There are several filesystems out there for which i_sem does
> nothing to protect inode->i_size.

Then the first patch is the way to go.  We know generic_file_llseek is
safe and perhaps a few other of the llseek methods.  The remaining can
explicitly grab the bkl on their own, as Al suggested.

	Robert Love

