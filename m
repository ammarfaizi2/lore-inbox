Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288936AbSBZPt1>; Tue, 26 Feb 2002 10:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289114AbSBZPtR>; Tue, 26 Feb 2002 10:49:17 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:43240 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S288936AbSBZPtI>;
	Tue, 26 Feb 2002 10:49:08 -0500
Subject: Re: linux-2.5.5-xfs-dj1 troubles (raid0_make_request bug)
From: Steve Lord <lord@sgi.com>
To: svetljo <galia@st-peter.stw.uni-erlangen.de>
Cc: linux-xfs@oss.sgi.com, Linux Kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
In-Reply-To: <3C7B6FDE.4090308@st-peter.stw.uni-erlangen.de>
In-Reply-To: <3C7B6FDE.4090308@st-peter.stw.uni-erlangen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 26 Feb 2002 09:44:42 -0600
Message-Id: <1014738282.5993.2.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-26 at 05:22, svetljo wrote:
> Hi
> i'd like to ask you to CC me because i'm not subscribed to the lists
> 
> i'm having some interesting troubles
> i have lvm over soft RAID-0 with LV's formated with XFS and JFS
> i can work with the JFS LV's,
>  but i can not with the XFS one's, i can not mount them ( no troubles 
> with XFS normal partitions)
> 
> so
> i'd like to ask is this problem with XFS or with raid or lvm
> and is there a way to fix it
> 
> thanks for your help
> 
> here is what i found in dmesg
> 

> 
> XFS mounting filesystem lvm(58,2)
> raid0_make_request bug: can't convert block across chunks or bigger than 
> 16k 8323317 64
> raid0_make_request bug: can't convert block across chunks or bigger than 
> 16k 8323445 64
> I/O error in filesystem ("lvm(58,2)") meta-data dev 0xc0223a02 block 
> 0x601f7d
>        ("xlog_bread") error 5 buf count 131072
> raid0_make_request bug: can't convert block across chunks or bigger than 
> 16k 8324829 29
> I/O error in filesystem ("lvm(58,2)") meta-data dev 0xc0223a02 block 
> 0x602565
>        ("xlog_bread") error 5 buf count 30208

XFS is sending a 64K request down to the driver, and raid0 is bouncing
it as too large. Jens, I thought you said requests which were too large
for underlying layers would get chopped up?

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
