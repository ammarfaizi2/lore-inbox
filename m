Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313591AbSDHISN>; Mon, 8 Apr 2002 04:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313590AbSDHISM>; Mon, 8 Apr 2002 04:18:12 -0400
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:12683
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id <S313587AbSDHISK>; Mon, 8 Apr 2002 04:18:10 -0400
Message-ID: <3CB15178.3020004@st-peter.stw.uni-erlangen.de>
Date: Mon, 08 Apr 2002 10:14:48 +0200
From: svetljo <galia@st-peter.stw.uni-erlangen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lord@sgi.com
CC: mkp.@mkp.net, linux-xfs@oss.sgi.com, linux-xfs
 <linux-xfs@thebarn.com>,
        linux-kernel@vger.kernel.org
Subject: Re: REPOST : linux-2.5.5-xfs-dj1 - 2.5.7-dj2  (raid0_make_request
 bug)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *16uUGy-0004bC-00*GxfOPdV3TEQ* (Studentenwohnanlage Nuernberg St.-Peter)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
 >
 > This is your problem, in the 2.5 code base, the bio infrastructure 
and the
 > raid code do not work well together. It is being worked on - slowly.
 >
 > If you want to dumb down xfs to make it function then I suspect you
 > can do it by editing
 >
 >     fs/xfs/pagebuf/page_buf.c
 >
 > looking for the line which uses BIO_MAX_SECTORS and replace
 >
 >     nr_pages = BIO_MAX_SECTORS >> (PAGE_SHIFT - 9);
 >
 > with
 >
 >     nr_pages = 1;
 >
 > And for extra bonus points, only do it when pb->pb_dev is on the
 > MD_MAJOR device.
 >
 > This will make xfs send smaller bio structures down to the block
 > layer and hopefully avoid the problem.
 >
 > I have not tested this - don't have any time right now, on a plane
 > in 6 hours and way too much to do.
 >
 > Steve
 >

that helped  a lot but i still have two LV's, witch i can not mount
the one complains again about raid0_make_request [lvm(58,1)], but the 
other does not  [lvm(58,5)]


XFS mounting filesystem lvm(58,5)
Starting XFS recovery on filesystem: lvm(58,5) (dev: 58/5)
XFS: xlog_recover_process_data: bad clientid
XFS: log mount/recovery failed
XFS: log mount failed
XFS mounting filesystem lvm(58,6)
XFS mounting filesystem lvm(58,2)
XFS mounting filesystem lvm(58,3)
XFS mounting filesystem lvm(58,1)
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23610013 4
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23610045 4
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23610077 4
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23610109 4
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23610141 4
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23610173 4
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23610205 4
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23610237 4
I/O error in filesystem ("lvm(58,1)") meta-data dev 0xc03d3a01 block 
0xa0210d
       ("xlog_bread") error 5 buf count 131072
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23611101 4
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23611133 4
I/O error in filesystem ("lvm(58,1)") meta-data dev 0xc03d3a01 block 
0xa02565
       ("xlog_bread") error 5 buf count 30208
XFS: failed to find log head
XFS: log mount/recovery failed
XFS: log mount failed
XFS mounting filesystem lvm(58,4)

