Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290228AbSB0AGK>; Tue, 26 Feb 2002 19:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSB0AGD>; Tue, 26 Feb 2002 19:06:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38923 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290228AbSB0AFQ>;
	Tue, 26 Feb 2002 19:05:16 -0500
Message-ID: <3C7C2264.7C255E9A@zip.com.au>
Date: Tue, 26 Feb 2002 16:03:48 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: assertion failure : ext3 & lvm , 2.4.17 smp & 2.4.18-ac1 smp
In-Reply-To: <3C7C1A88.AA6CE5DD@zip.com.au> <Pine.LNX.4.44.0202270141090.11106-100000@tassadar.physics.auth.gr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitris Zilaskos wrote:
> 
> On Tue, 26 Feb 2002, Andrew Morton wrote:
> 
> > Dimitris Zilaskos wrote:
> > >
> > > Assertion failure in do_get_write_access() at transaction.c:730: "(((jh2bh(jh))->b_state & (1UL << BH_Uptodate)) != 0)"
> >
> > This was fixed in the ext3 patch which went into 2.4.18-pre5
> 
> well i just got another one
> 
> Assertion failure in do_get_write_access() at transaction.c:730:
> "(((jh2bh(jh))->b_state & (1UL << BH_Uptodate)) != 0)"
> ...
> 
> uname -an :
> Linux test 2.4.18-ac1 #2 SMP Tue Feb 26 23:13:44 EET 2002 i686 unknown

blargh.  Possibly LVM tossed back an I/O error and ext3 fed
the result into journal_get_write_access(), which would be
an ext3 bug.

Please prepare a ksymoops trace.
