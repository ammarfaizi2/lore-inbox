Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269866AbRHDVCa>; Sat, 4 Aug 2001 17:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269865AbRHDVCV>; Sat, 4 Aug 2001 17:02:21 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:63755 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269867AbRHDVCL>; Sat, 4 Aug 2001 17:02:11 -0400
Message-ID: <3B6C642F.D0358401@zip.com.au>
Date: Sat, 04 Aug 2001 14:07:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic 
 change patch)
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com>, <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org> <3B6B4B21.B68F4F87@zip.com.au>,
		<3B6B4B21.B68F4F87@zip.com.au> <20010804131904.E18108@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Fri, Aug 03, 2001 at 06:08:49PM -0700, Andrew Morton wrote:
> 
>     Ow.  You just crippled ext3.
> 
> How so? The Flush all transactions on fsync behaviour that resierfs
> did/does have at present too?  (There are 'fixes' to reiserfs for
> this).

Sorry, Chris - I was being even more than usually stupid.  All
you need do is overload the return value from file_operations.fsync().
It currently returns zero on success or negative error.  You can
just define a return value of "1" to mean that the fs has taken
care of syncing the directory info and no further action is needed
at the fs layer.
