Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265219AbSJWUDn>; Wed, 23 Oct 2002 16:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265218AbSJWUDn>; Wed, 23 Oct 2002 16:03:43 -0400
Received: from packet.digeo.com ([12.110.80.53]:7147 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265219AbSJWUDj>;
	Wed, 23 Oct 2002 16:03:39 -0400
Message-ID: <3DB70207.FBB38A0D@digeo.com>
Date: Wed, 23 Oct 2002 13:09:43 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Steven Cole <elenstev@mesatop.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.5.44-[mm3, ac2] time to tar zxf kernel tarball compared forvarious 
 fs.
References: <1035402133.13140.251.camel@spc9.esa.lanl.gov> <3DB6FF24.9B50A7C0@digeo.com> <20021023160450.E3750@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2002 20:09:43.0109 (UTC) FILETIME=[20283F50:01C27AD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> On Wed, Oct 23, 2002 at 12:57:24PM -0700, Andrew Morton wrote:
> > Steven Cole wrote:
> > >
> > > ext3
> > > tar zxf linux-2.5.44.tar.gz     2.5.44-mm3      2.5.44-ac2
> > > user                            4.42            4.39
> > > system                          4.09            4.05
> > > elapsed                         00:53.17        00:34.05
> > > % CPU                           16              24
> >
> > The smaller fifo_batch setting hurts when there are competing
> > reads and writes on the same disk.
> 
> Is the ext2/3 allocation heuristic fix in yet?  That might swing things
> around again too.
> 

Only for ext2, only in -mm.  I havben't submitted the Orlov allocator
because Ted is playing with it.

ext3's five-second commit interval and limited journal size really
bite in this test.  We end up doing most of the writeback within
the measurement period rather than after it.
