Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbSIWWrb>; Mon, 23 Sep 2002 18:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261437AbSIWWrb>; Mon, 23 Sep 2002 18:47:31 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:35567 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261436AbSIWWr1>;
	Mon, 23 Sep 2002 18:47:27 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200209232252.g8NMqN110401@eng2.beaverton.ibm.com>
Subject: Re: Bug in last night's bk test
To: akpm@digeo.com (Andrew Morton)
Date: Mon, 23 Sep 2002 15:52:23 -0700 (PDT)
Cc: plars@linuxtestproject.org (Paul Larson),
       pbadari@us.ibm.com (Badari Pulavarty),
       linux-kernel@vger.kernel.org (lkml), lse-tech@lists.sourceforge.net
In-Reply-To: <3D8F9047.B464ABD4@digeo.com> from "Andrew Morton" at Sep 23, 2002 02:05:59 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Paul Larson wrote:
> > 
> > The automated nightly testing turned up a bug on one of the test
> > machines last night.  The system that had the problem was running ltp
> > and was a 2-way PII-550, 2GB ram, ext2.  Here is the ksymoops dump:
> > 
> > ksymoops 2.4.5 on i686 2.4.18.  Options used
> >      -V (default)
> >      -K (specified)
> >      -L (specified)
> >      -O (specified)
> >      -m System.map (specified)
> > 
> > kernel BUG at ll_rw_blk.c:1802!
> 
> Ah, yes.
> 
> The direct-io code will build requests which are larger than
> the ips driver is prepared to accept, and the BIO layer correctly
> BUGs out over it.
> 
> We need to convert direct-io to use the bio_add_page() facility
> which Jens has recently added.
> 
> Until that's done you'll need to set BIO_MAX_PAGES to 16 in
> include/linux/bio.h
> 

I am little confused here. I thought IPS driver can handle 64K IO.
Infact, IPS_MAX_SG is set to 17. So it should be able to handle 68K.
I have been told that it can handle more than that.. but for some
reason it was set to 17.

Paul, what kernel are u running ? 2.5.38 ? 

- Badari
