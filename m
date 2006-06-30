Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWF3Xxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWF3Xxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 19:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWF3Xxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 19:53:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:27154 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751275AbWF3Xxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 19:53:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LkyJL3DLAi1wyh965KFU/FRgBtLkDTDIQQPeDG+wRR9CNwgcj1wV1iCsViMKyzHzNqUqbDzVGEaH7175TyZVsxXcu15L4WQfD4PBWS5mz0HlewTnfzy4k3ZBxq+p9xxjZjnG+0iJnDokO4ACSjuemwHRD9vqODKdgpg9A4i+eQ4=
Message-ID: <4807377b0606301653n68bee302t33c2cc28b8c5040@mail.gmail.com>
Date: Fri, 30 Jun 2006 16:53:34 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm4
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060629120518.e47e73a9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	 <4807377b0606291053g602f3413gb3a60d1432a62242@mail.gmail.com>
	 <20060629120518.e47e73a9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 29 Jun 2006 10:53:03 -0700
> "Jesse Brandeburg" <jesse.brandeburg@gmail.com> wrote:
>
> > can't boot 2.6.17-mm4 on x86_64 Intel 7520 platform.
> > instant reboot after printing:
> >   Booting 'Red Hat Enterprise Linux AS (2.6.17-mm4-jesse)'
> >
> > root (hd0,0)
> >  Filesystem type is ext2fs, partition type 0x83
> > kernel /vmlinuz-2.6.17-mm4-jesse ro root=LABEL=/1 rhgb hdc=none video=atyfb:102
> > 4x768M-32@70 console=ttyS0,115200n8 console=tty1 panic=30
> >    [Linux-bzImage, setup=0x1e00, size=0x199883]
> > initrd /initrd-2.6.17-mm4-jesse.img
> >    [Linux-initrd @ 0x37efd000, 0xf2da8 bytes]
> >
> > ie no kernel output
>
> Your .config works OK on my x86_64 box.  Wanna swap? ;)
>
> > where should i start to debug?  I can do a bisect pretty easily too
> > using git if necessary.
>
> That would be great, thanks.  Your options are to do a git bisect using
>
> git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git#v2.6.17-mm4
>
> (Beware that the mm-to-git trees have had a few problem reports and I'm not
> aware of anyone previously using them for a bisect).
>
> or to install quilt and use
> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

had to pull in linus' tree in order to get the latest 2.6.17 label,
bisect complete, this patch appeared to make the problem
ad596171ed635c51a9eef829187af100cbf8dcf7 is first bad commit
diff-tree ad596171ed635c51a9eef829187af100cbf8dcf7 (from
734efb467b31e56c2f9430590a9aa867ecf3eea1)
Author: john stultz <johnstul@us.ibm.com>
Date:   Mon Jun 26 00:25:06 2006 -0700

    [PATCH] Time: Use clocksource infrastructure for update_wall_time

    Modify the update_wall_time function so it increments time using the
    clocksource abstraction instead of jiffies.  Since the only
clocksource driver
    currently provided is the jiffies clocksource, this should result in no
    functional change.  Additionally, a timekeeping_init and timekeeping_resume
    function has been added to initialize and maintain some of the new
timekeping
    state.

    [hirofumi@mail.parknet.co.jp: fixlet]
    Signed-off-by: John Stultz <johnstul@us.ibm.com>
    Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 3ea3b4140ffa318c20513d596eb063430760822a
30d3669ec72a2a9edc69a72fadfb4158bd17d6fe M      include
:040000 040000 5c222365dd5b1fdbfebabd40106732b9bfcc3f0d
adbb7244617875fe7e0f3014e90808ddf6115976 M      init
:040000 040000 24c5fcb7f26396cf231c7ab06ddc8fb187ebe5d4
8157df180abe5f6f058c050f1d017b46334f5c8f M      kernel

however i cannot revert this patch from -mm4 because of conflicts ( i
might be able to revert a specific set of patches from mm)
