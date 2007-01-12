Return-Path: <linux-kernel-owner+w=401wt.eu-S1751469AbXALACH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbXALACH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 19:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbXALACH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 19:02:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:29306 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbXALACF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 19:02:05 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nveun8BIaegRLK88jWj9uXxSICdfBZ2NGhBSrHonO/oMwgcaMLmCS7AHRswY+YaqatVNP/K72Q72ILFmyr5hKMgeKUJ4WtG7ofR2AgkNMcdFfZzetRnFBr9t3PXLSj7tK745rzDi/H9X/C1Jvn5j1Wy+IZDEK/MPlGjxXUyK+AY=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Frank van Maarseveen <frankvm@frankvm.com>
Subject: Re: Finding hardlinks
Date: Fri, 12 Jan 2007 01:00:21 +0100
User-Agent: KMail/1.8.2
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Pavel Machek <pavel@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
References: <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0701032027330.6871@artax.karlin.mff.cuni.cz> <20070103202641.GA3510@janus>
In-Reply-To: <20070103202641.GA3510@janus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701120100.21672.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 January 2007 21:26, Frank van Maarseveen wrote:
> On Wed, Jan 03, 2007 at 08:31:32PM +0100, Mikulas Patocka wrote:
> > 64-bit inode numbers space is not yet implemented on Linux --- the problem 
> > is that if you return ino >= 2^32, programs compiled without 
> > -D_FILE_OFFSET_BITS=64 will fail with stat() returning -EOVERFLOW --- this 
> > failure is specified in POSIX, but not very useful.
> 
> hmm, checking iunique(), ino_t, __kernel_ino_t... I see. Pity. So at
> some point in time we may need a sort of "ino64" mount option to be
> able to switch to a 64 bit number space on mount basis. Or (conversely)
> refuse to mount without that option if we know there are >32 bit st_ino
> out there. And invent iunique64() and use that when "ino64" specified
> for FAT/SMB/...  when those filesystems haven't been replaced by a
> successor by that time.
> 
> At that time probably all programs are either compiled with
> -D_FILE_OFFSET_BITS=64 (most already are because of files bigger than 2G)
> or completely 64 bit. 

Good plan. Be prepared to redo it again when 64bits will feel "small" also.
Then again when 128bit will be "small". Don't tell me this won't happen.
15 years ago people would laugh about 32bit inode numbers being not enough.
--
vda
