Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316416AbSFUHDs>; Fri, 21 Jun 2002 03:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSFUHDr>; Fri, 21 Jun 2002 03:03:47 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:11539 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S316416AbSFUHDr>; Fri, 21 Jun 2002 03:03:47 -0400
Message-ID: <3D12CFC5.38DD9245@aitel.hist.no>
Date: Fri, 21 Jun 2002 09:03:33 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.22nopreempt i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
References: <20020619113734.D2658@redhat.com> <20020619234340.A24016@redhat.com> <20020620005452.M5119@redhat.com> <E17LF65-0001K4-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> I ran a bakeoff between your new half-md4 and dx_hack_hash on Ext2.  As
> predicted, half-md4 does produce very even bucket distributions.  For 200,000
> creates:
> 
>    half-md4:        2872 avg bytes filled per 4k block (70%)
>    dx_hack_hash:    2853 avg bytes filled per 4k block (69%)
> 
> but guess which was faster overall?
> 
>    half-md4:        user 0.43 system 6.88 real 0:07.33 CPU 99%
>    dx_hack_hash:    user 0.43 system 6.40 real 0:06.82 CPU 100%
> 
> This is quite reproducible: dx_hack_hash is always faster by about 6%.  This
> must be due entirely to the difference in hashing cost, since half-md4
> produces measurably better distributions.  Now what do we do?

No surprise that the worse distribution is faster - you get less
io when fewer blocks are used.  Which means a bad distribution beats 
a good one _until_ blocks start to really fill up and collide. 2.8K per
4K block is only 70% full.  I guess the better hash wins
if you force a higher fill rate?

Helge Hafting
