Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbTLFIYq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 03:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264964AbTLFIYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 03:24:46 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:27661 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264963AbTLFIYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 03:24:45 -0500
Date: Sat, 6 Dec 2003 09:20:11 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Chuck Lever <cel@citi.umich.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 read ahead never reads the last page in a file
Message-ID: <20031206082011.GD11325@alpha.home.local>
References: <Pine.BSO.4.33.0312031800270.24127-100000@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.33.0312031800270.24127-100000@citi.umich.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuck,

I've run 2.4.23 both vanilla and patched, and I confirm a win on NFS reads.
I tested from 1 to 6 parallel reads consisting of md5sum of kernel includes :
  time find include -type f | xargs md5sum >/dev/null &
Results below :

processes   2.4.23       2.4.23-patched
    1       11.5         11.45
    2       12.82        12.68
    3       14.7         14.4
    4       17.8         17.3
    5       21.5         21.0
    6       25.7         25.0  => server is saturated 100% sys
    7       29.3         29.0  => server is saturated 100% sys

Fileset contain 7346 files totalizing 29952 kB.
So there's a gain of nearly 3% in the best case (6 processes). Not bad.
I suspect that I could also gain slightly more by patching the server too.

Cheers,
Willy

