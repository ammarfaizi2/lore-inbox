Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWHWKjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWHWKjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWHWKjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:39:16 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:62437 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964825AbWHWKjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:39:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aqlwbWdEht/VI5dBqDsxS/ZSd347jaQwEDu16mmNO9+StGgaUpasgseXcOm0oFLcy6F0rvnPFkhfbihfxeNydT/lxMyD6O548rkbBNTxiV6WHGPoNL/HKJIq4RIvHAwhaEuPKVEvYpq2a8arveNoG7nUQua2EbzitM1hmP/BMIo=
Message-ID: <4df04b840608230339q1e0f3ce3y846dc40c0cf40299@mail.gmail.com>
Date: Wed, 23 Aug 2006 18:39:14 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Improvement on memory subsystem
In-Reply-To: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New design has been appended into my OS, it's mainly focused on how to
allocate swap pages for each PrivateVMA efficiently in swap daemon.

Let's first see the PTE array snapshot of a PrivateVMA,
           U-U-P-P-P-S-S
U: UnmappedPTE; P: PTE; S: SwappedPTE.

The snapshot shows that the pages of the PrivateVMA has an
access-affinity. The 3rd, 4th and 5th have been accessed since last
scanning on the PrivateVMA, other PTEs aren't still touched.

A concept is introduced here to describe the accessed PTEs -- series.
So we've got three series (1st and 2nd), (3rd, 4th and 5th) and (6th
and 7th) from the snapshot.

The design is allocating swap pages by series. It should be more
efficient for future page-fault to page-in them.

Further discussion in my new documentation
http://www.cublog.cn/u/21764/upfile/060823181124.zip.  In section
"Memory Daemons >> SwapDaemon and PrivateVMA" and "Class Repository >>
SwapDaemon". There's also sample code in Implementation subdirectory
of the archives.
