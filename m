Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280612AbRKNOpq>; Wed, 14 Nov 2001 09:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280618AbRKNOpg>; Wed, 14 Nov 2001 09:45:36 -0500
Received: from quark.didntduck.org ([216.43.55.190]:56338 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S280612AbRKNOpY>; Wed, 14 Nov 2001 09:45:24 -0500
Message-ID: <3BF2837B.4B63FBA5@didntduck.org>
Date: Wed, 14 Nov 2001 09:45:15 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Willi =?iso-8859-1?Q?N=FC=DFer?= <wilhelm.nuesser@sap.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Comparison of PAE and Non-PAE 2..4.14 (p8) in high load
In-Reply-To: <3BF27557.30007@sap.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willi Nüßer wrote:
> 
> Hi,
> 
> after my first posting to lkml where we compared distributor
> provided kernels vs. a plain 2.4.14-pre8 it was pointed
> out that between PAE and non-PAE kernels some performance
> differences might exist.
> 
> We checked this last night and here are the first results.
> Again,
> a) the relevant quantity dialog steps per second is a
> measure for the throughput our application servers runs.
> b) our application server and the corresponding database
> (SAP DB) run on 4 way Dell, 1 GB at boot time enabled.
> 
> Results:
> ---------
> 
> 2.4.7
>         2.4.14p8 PAE            2.4.14p4 non- PAE
> -------------------------------------------------------------
>    1.80         13.42                   15.47
>    1.10         13.28                   14.76
>    1.20                 14.08                   14.63
>    1.26         13.17                   15.30
>    1.35         13.41                   14.51
> 
> This means that we did see a performance decrease of about
> 6 % compared to 2.4.14p8 nonPAE but still 2.4.14p8 is an order
> of magnitude faster than 2.4.7

PAE mode increases the size of the page table entries to 64-bits, and
the x86 doesn't do 64-bit operations very well.  Plus it has three
levels of tables to work with instead of two.  It is the only way to
support more than 4GB of memory so it's a tradeoff between high memory
support and performance.  If you have less memory, don't run a PAE
kernel.

--

				Brian Gerst
