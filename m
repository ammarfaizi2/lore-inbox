Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129542AbQJ0IOr>; Fri, 27 Oct 2000 04:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129585AbQJ0IOh>; Fri, 27 Oct 2000 04:14:37 -0400
Received: from mail.zmailer.org ([194.252.70.162]:65284 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129542AbQJ0IO1>;
	Fri, 27 Oct 2000 04:14:27 -0400
Date: Fri, 27 Oct 2000 11:14:18 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test9 + LFS
Message-ID: <20001027111418.J3588@mea-ext.zmailer.org>
In-Reply-To: <20001026215606.A19958@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001026215606.A19958@animx.eu.org>; from wakko@animx.eu.org on Thu, Oct 26, 2000 at 09:56:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2000 at 09:56:06PM -0400, Wakko Warner wrote:
> I attempted to create a 4gb sparce file with dd.  It failed.
> I created one that was 2.1gb in size which worked.  Then I appeneded more
> junk to the end of the file making it over 2.2gb.
> 
> doing an ls -l shows:
> ls: x: Value too large for defined data type
> 
> NOTE: this worked in 2.4.0-test6 and I believe it stopped working around
> test8, but I'm not sure.  May have been around test7.

	Your userspace tools are not using LFS compliant
	open(O_LARGEFILE), and stat64()  methods.

	EXT2 got corrected to do LFS limited open() handling
	at correct limit (2G-1) at around that time.

	There still lurks some mis-compliance issues at
	read() and write() which are still allowed to
	go over 2G-1 marker without the fd having
	O_LARGEFILE flag.

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
