Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVLEMfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVLEMfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 07:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVLEMfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 07:35:41 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:18150 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932398AbVLEMfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 07:35:40 -0500
Message-ID: <044801c5f998$5cb99aa0$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Andreas Dilger" <adilger@clusterfs.com>
Cc: "Dave Kleikamp" <shaggy@austin.ibm.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>
References: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp> <1133447539.8557.14.camel@kleikamp.austin.ibm.com> <041701c5f742$d6b0a450$4168010a@bsd.tnes.nec.co.jp> <20051202185805.GS14509@schatzie.adilger.int> <02cd01c5f809$95a94620$4168010a@bsd.tnes.nec.co.jp> <20051205081121.GU14509@schatzie.adilger.int>
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
Date: Mon, 5 Dec 2005 21:35:18 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Dec 03, 2005  22:00 +0900, Takashi Sato wrote:
>> Andreas Dilger wrote:
>> >Actually, it should probably be "sector_t", because it isn't really
>> >possible to have a file with more blocks than the size of the block
>> >device.  This avoids memory overhead for small systems that have no
>> >need for it in a very highly-used struct.  It may be for some network
>> >filesystems that support gigantic non-sparse files they would need to
>> >enable CONFIG_LBD in order to get support for this.
>> 
>> I think sector_t is ok for local filesystem as you said.  However,
>> on NFS, there may be over 2TB file on server side, and inode.i_blocks
>> for over 2TB file will become invalid on client side in case CONFIG_LBD
>> is disabled.
> 
> I don't know the exact specs of NFS v2 and v3, but I doubt they can have
> single files larger than 2TB.  Even if they could then this is not a

I believe NFS v3 can handle over 2TB file. :-)

> very common situation and if someone is running in such an environment
> then they can easily enable CONFIG_LBD (or make e.g. CONFIG_NFS_V4 have
> a dependency to enable this if it is important enough).  What I'd rather
> avoid is needless growth of heavily-used structures for rather uncommon
> cases (at the current time at least, this can be re-examined later).

I agree above.

> It might also be possible to have a separate CONFIG_LSF (or whatever)
> that enables support for large single files, maybe enabled by default
> with CONFIG_LBD and also configurable separately for clients of network
> filesystems with large single files.  Someone who cares more about the
> proliferation of configuration options than I can decide whether it
> makes sense to keep these as separate options.

I don't think CONFIG_LBD should determine whether large single
files is enabled.  So, I agree your suggestion basically.
It would be nice if there was a suitable configuration option for it.
I will examine the implementation in detail.

-- Takashi Sato
