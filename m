Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317865AbSGaVEQ>; Wed, 31 Jul 2002 17:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSGaVEQ>; Wed, 31 Jul 2002 17:04:16 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:13505 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S317865AbSGaVEP>; Wed, 31 Jul 2002 17:04:15 -0400
Date: Wed, 31 Jul 2002 17:07:40 -0400
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIG files & file systems
Message-ID: <20020731210739.GA15492@ravel.coda.cs.cmu.edu>
Mail-Followup-To: "Peter J. Braam" <braam@clusterfs.com>,
	linux-kernel@vger.kernel.org
References: <20020731131620.M15238@lustre.cfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020731131620.M15238@lustre.cfs>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 01:16:20PM -0600, Peter J. Braam wrote:
> Hi, 
> 
> I've just been told that some "limitations" of the following kind will
> remain:
>   page index = unsigned long
>   ino_t      = unsigned long

The number of files is not limited by ino_t, just look at the
iget5_locked operation in fs/inode.c. It is possible to have your own
n-bit file identifier, and simply provide your own comparison function.
The ino_t then becomes the 'hash-bucket' in which the actual inode is
looked up.

For the page_index, maybe at some point someone manages to cleanly mix
large pages (2MB?) with the current 4KB pages. Very large files could
then use the page_index as an index into these large pages which should
allow for 9PB files (or something close to that).

Jan
