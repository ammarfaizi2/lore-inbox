Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUH0Lnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUH0Lnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 07:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUH0Lnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 07:43:41 -0400
Received: from forte.mfa.kfki.hu ([148.6.72.11]:42905 "EHLO forte.mfa.kfki.hu")
	by vger.kernel.org with ESMTP id S263775AbUH0Lng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 07:43:36 -0400
Date: Fri, 27 Aug 2004 13:43:35 +0200
From: Gergely Tamas <dice@mfa.kfki.hu>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: data loss in 2.6.9-rc1-mm1
Message-ID: <20040827114334.GB4467@mfa.kfki.hu>
References: <20040827105543.GA10563@mfa.kfki.hu> <Pine.LNX.4.53.0408271313200.9045@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0408271313200.9045@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

 > What does ls -l testfile.1 give?

$ ls -l testfile{,.1}
-rw-r--r--  1 dice users 10485760 Aug 27 13:25 testfile
-rw-r--r--  1 dice users 10481664 Aug 27 13:25 testfile.1

 > What you describe actually can be correct behaviour, since the file is
 > all zeros.

Same test with other source file...

$ dd if=linux-2.6.8.1.tar.bz2 of=testfile bs=$((1024*1024)) count=10
10+0 records in
10+0 records out
10485760 bytes transferred in 0.061916 seconds (169354917 bytes/sec)

$ du -sb testfile
10485760        testfile

$ cat testfile > testfile.1

$ du -sb testfile.1
10481664        testfile.1

 > Although yes, it seems highly improbable someone implemented an 
 > optimization that cuts away just one of 2560 pages.

Thanks,
Gergely
