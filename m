Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318083AbSFTA4Q>; Wed, 19 Jun 2002 20:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318084AbSFTA4Q>; Wed, 19 Jun 2002 20:56:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59404 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318083AbSFTA4P>;
	Wed, 19 Jun 2002 20:56:15 -0400
Message-ID: <3D1127D6.F6988C4B@zip.com.au>
Date: Wed, 19 Jun 2002 17:54:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mgross@unix-os.sc.intel.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, richard.a.griffiths@intel.com
Subject: Re: ext3 performance bottleneck as the number of spindles gets large
References: <200206200022.g5K0MKP27994@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mgross wrote:
> 
> ...
> Has anyone done any work looking into the I/O scaling of Linux / ext3 per
> spindle or per adapter?  We would like to compare notes.

No.  ext3 scalability is very poor, I'm afraid.  The fs really wasn't
up and running until kernel 2.4.5 and we just didn't have time to
address that issue.
 
> I've only just started to look at the ext3 code but it seems to me that replacing the
> BKL with a per - ext3 file system lock could remove some of the contention thats
> getting measured.  What data are the BKL protecting in these ext3 functions?  Could a
> lock per FS approach work?

The vague plan there is to replace lock_kernel with lock_journal
where appropriate.  But ext3 scalability work of this nature
will be targetted at the 2.5 kernel, most probably.

I'll take a look, see if there's any low-hanging fruit in there,
but I doubt that the results will be fantastic.

-
