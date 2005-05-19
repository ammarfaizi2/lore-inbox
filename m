Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVESDJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVESDJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 23:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVESDJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 23:09:16 -0400
Received: from pat.uio.no ([129.240.130.16]:15313 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262459AbVESDJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 23:09:11 -0400
Subject: Re: why nfs server delay 10ms in nfsd_write()?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: steve <lingxiang@huawei.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "zhangtiger@huawei.com" <zhangtiger@huawei.com>
In-Reply-To: <0IGP00IZRULADZ@szxml02-in.huawei.com>
References: <0IGP00IZRULADZ@szxml02-in.huawei.com>
Content-Type: text/plain
Date: Wed, 18 May 2005 23:08:48 -0400
Message-Id: <1116472128.11340.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.623, required 12,
	autolearn=disabled, AWL 1.33, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 19.05.2005 Klokka 10:46 (+0800) skreiv steve:

> i have 2 questions:
> 1.i don't know why do we have to sleep for 10 ms, why not do sync immediately?
> 2.what will happen if we don't sleep for 10ms?
> when i delete these codes, i get a good result, and the write performace improved from 300KB/s to 18MB/s

See
http://www.usenix.org/publications/library/proceedings/sf94/full_papers/juszczak.a

Write gathering is basically a method for improving NFSv2 writes without
any protocol changes. Later, NFSv3 introduced the more efficient concept
of "unstable" writes into the protocol (see
http://www.netapp.com/ftp/NFSv3_Rev_3.pdf).

You can turn NFSv2 write gathering on and off using the wdelay/no_wdelay
export options ('man 5 exports')

Trond

