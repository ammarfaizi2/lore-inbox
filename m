Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316198AbSEKDEj>; Fri, 10 May 2002 23:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSEKDEi>; Fri, 10 May 2002 23:04:38 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:47501 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S316198AbSEKDEh>; Fri, 10 May 2002 23:04:37 -0400
Date: Fri, 10 May 2002 23:04:37 -0400
To: linux-kernel@vger.kernel.org
Cc: kaos@ocs.com.au
Subject: Re: [PATCH] iget-locked [2/6]
Message-ID: <20020511030437.GA29392@ravel.coda.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org, kaos@ocs.com.au
In-Reply-To: <Pine.LNX.4.44.0205102120210.11642-100000@chaos.physics.uiowa.edu> <3950.1021085326@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 12:48:46PM +1000, Keith Owens wrote:
> On Fri, 10 May 2002 21:21:16 -0500 (CDT), 
> Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
> >This is not true anymore in 2.5, this limitation was removed when ALSA 
> >went in.
> 
> True, but if the iget change goes into 2.5 it will probably be
> backported to 2.4 later, 2.4 still has the restriction.
> 
> As for modversions on 2.5, well you know my opinion ;).

A backport is not that likely. The patch removes iget4 and as a result
breaks compatibility for binary-only kernel modules that use iget and/or
iget4. So, I don't believe this patch is appropriate for a stable series.

I'm going to fix the iget4 race in 2.4 by adding a per-superblock
semaphore around the call to iget4 in Coda. My guess is that NFS and
ReiserFS will have to do something similar. Filesystems that do not
use a special 'find_actor' (i.e. iget) don't have a problem in 2.4.

Jan

