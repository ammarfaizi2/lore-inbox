Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbSJMTT2>; Sun, 13 Oct 2002 15:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbSJMTT2>; Sun, 13 Oct 2002 15:19:28 -0400
Received: from packet.digeo.com ([12.110.80.53]:63391 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261616AbSJMTT0>;
	Sun, 13 Oct 2002 15:19:26 -0400
Message-ID: <3DA9C896.621CC3D3@digeo.com>
Date: Sun, 13 Oct 2002 12:25:10 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [lart] /bin/ps output
References: <3DA798B6.9070400@us.ibm.com> <20021012035141.GC7050@krispykreme> <20021012035958.GD10722@holomorphy.com> <20021012040959.GE7050@krispykreme>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2002 19:25:10.0717 (UTC) FILETIME=[3F2816D0:01C272EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> 
> > Bah! I'm at a competitive disadvantage because I've got a lesser
> > BITS_PER_LONG. No matter, NR_CPUS > BITS_PER_LONG shall be conquered
> > and the explosion of kernel threads will be quite visible (though
> > unfortunately probably post-freeze).
> 
> Speaking of which, the recent CONFIG_NR_CPUS addition shows just how
> bloated all our [NR_CPU] structures are. We need to get serious about
> using the per cpu data stuff. Going from 32 to 64 was over 500kB on my
> ppc64 build.
> 

Half of which is in timer.c.

mnm:/usr/src/25> size kernel/timer.o
   text    data     bss     dec     hex filename
   4960     100  167648  172708   2a2a4 kernel/timer.o

That's with NR_CPUS=32.  Show me yours.

Using the percpu stuff will not significantly reduce this.  Some
new data structure might be needed.
