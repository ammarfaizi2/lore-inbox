Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSFYRFC>; Tue, 25 Jun 2002 13:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSFYRFB>; Tue, 25 Jun 2002 13:05:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58886 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315629AbSFYRFB>;
	Tue, 25 Jun 2002 13:05:01 -0400
Message-ID: <3D18A26A.73E6DD07@zip.com.au>
Date: Tue, 25 Jun 2002 10:03:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mala Anand <manand@us.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: efficient copy_to_user and copy_from_user routines in Linux Kernel
References: <OFCB119CD8.D6AE7B3D-ON85256BE2.006AC911@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mala Anand wrote:
> 
> Here is a 2.5.19 patch that improves the performance of IA32 copy_to_user
> and copy_from_user routines used by :
> 
> (1) tcpip protocol stack
> (2) file systems
> 


This came up about a year back when zerocopy networking was merged.
Intel boxes started running more slowly purely because of the 8+8
alignment thing.

I changed tcp to use a different copy if either source or dest were
not eight-byte aligned, and found that the resulting improvement
across a mixed networking load was only 1%.  Your numbers are higher,
so perhaps there are different alignments in the mix...

One question:  have you tested on other CPU types?  This problem is
very specific to Intel hardware.  On AMD, the eight-byte alignement
artifact does not exist at all.  It could be that your patch is not
desirable on such CPUs?

-
