Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280388AbRKEJBv>; Mon, 5 Nov 2001 04:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280392AbRKEJBl>; Mon, 5 Nov 2001 04:01:41 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41989 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280388AbRKEJBY>; Mon, 5 Nov 2001 04:01:24 -0500
Date: Mon, 5 Nov 2001 10:01:11 +0100
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: disk throughput
Message-ID: <20011105100111.A8161@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au> <20011105094701.H29577@atrey.karlin.mff.cuni.cz> <20011105005035.A18620@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011105005035.A18620@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Nov 05, 2001 at 09:47:01AM +0100, Jan Kara wrote:
> > If I understood well the code it tries to spread files uniformly over the
> > fs (ie. all groups equally full). I think that if you have filesystem like
> > /home where are large+small files changing a lot your change can actually
> > lead to more fragmentation - groups in the beginning gets full (files
> > are created in the same group as it's parent). Then if some file gets deleted
> > and new one created filesystem will try to stuff new file in the first
> > groups and that causes fragmentation.. But it's just an idea - some testing
> > would be probably more useful...
> > 
> 
> Shouldn't it choose another block group if the file won't fit in the current
> one?
  If I understand the code well: When ext2 creates new file it will try to
allocate data in the same group where it got inode. If there's no free block
(or better 8 blocks) in the group it will try another one etc (but it will
be probably also full - we will first try to spread file over half of full
groups (in average) before hitting the empty one). But I agree that this way it
will fill the holes with the file and next time it will start in empty
group. Anyway this allocation strategy will IMHO not keep inodes near data...

								Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs
