Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293074AbSCHO3r>; Fri, 8 Mar 2002 09:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310877AbSCHO3i>; Fri, 8 Mar 2002 09:29:38 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:33439 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S293074AbSCHO3c>;
	Fri, 8 Mar 2002 09:29:32 -0500
Message-ID: <3C88CB1C.90203@sgi.com>
Date: Fri, 08 Mar 2002 08:30:52 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: svetljo <galia@st-peter.stw.uni-erlangen.de>
CC: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.18-rc4-aa1 XFS oopses caused by cpio
In-Reply-To: <1015580766.20800.3.camel@svetljo.st-peter.stw.uni-erlangen.de> <3C88B612.1070206@sgi.com> <3C88C9A1.5070502@st-peter.stw.uni-erlangen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

svetljo wrote:

>
> i just created LV, formated it with xfs , extended it , mounted it, 
> extended the fs , and started to transfer my old /opt to the LV with cpio
> there were no complains from mount or xfs_growfs
> and i have no the output from mkfs.xfs
>
> [root@svetljo log]# xfs_growfs -n /opt
> meta-data=/opt            isize=256    agcount=12, agsize=33024 blks
> data     =                       bsize=4096   blocks=393216, imaxpct=25
>            =                       sunit=4      swidth=12 blks, 
> unwritten=0
>            =                       imaxbits=24
> naming   =version 2     bsize=4096
> log      =internal           bsize=4096   blocks=1200
> realtime =none            extsz=49152  blocks=0, rtextents=0
>
>
Ah, so you ran growfs on the filesystem, thats the key here. It looks 
like the new code
does not handle growfs correctly, the structure which is null is not 
allocated in the
expansion case. I should have a fix shortly.

Steve


