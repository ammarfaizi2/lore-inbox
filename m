Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUH0OSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUH0OSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUH0OSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:18:41 -0400
Received: from forte.mfa.kfki.hu ([148.6.72.11]:14027 "EHLO forte.mfa.kfki.hu")
	by vger.kernel.org with ESMTP id S265331AbUH0OSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:18:33 -0400
Date: Fri, 27 Aug 2004 16:18:28 +0200
From: Gergely Tamas <dice@mfa.kfki.hu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, Ram Pai <linuxram@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: data loss in 2.6.9-rc1-mm1
Message-ID: <20040827141828.GA19272@mfa.kfki.hu>
References: <200408271455.03733.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0408271448041.4725-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408271448041.4725-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Hmm, 2.6.9-rc1-mm1 looks like not a release to trust your (page
 > size multiple) data to!  You should find the patch below fixes it
 > (and, I hope, the issue the erroneous patches were trying to fix).
 > 
 > Signed-off-by: Hugh Dickins <hugh@veritas.com>

$ dd if=/dev/zero of=testfile bs=$((1024*1024)) count=10
10+0 records in
10+0 records out
10485760 bytes transferred in 0.028393 seconds (369307252 bytes/sec)

$ du -sb testfile
10485760        testfile

$ cat testfile > testfile.1

$ du -sb testfile.1
10485760        testfile.1

Seems to be working fine now, thanks.
Gergely
