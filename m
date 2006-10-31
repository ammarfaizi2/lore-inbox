Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423630AbWJaUyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423630AbWJaUyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423641AbWJaUyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:54:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:56624 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423630AbWJaUyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:54:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=WinH5SpDocjQNb08RdErLLjtK820bUXd9YWwwWNdJzIFNR61RRnW+yhh2BUUODcOEIkcTWFKAyqrCq7HEgTHExzb8YpCVFaKrUZGLuYOOoREY52jWjX+XyH49ruwYDAzMWtnhN3FTgkJoaFriUKzkhL9tieKmRS480DD5mABZGE=
Message-ID: <f46018bb0610311254u30063d57gebc2e0e190398c9@mail.gmail.com>
Date: Tue, 31 Oct 2006 15:54:46 -0500
From: "Holden Karau" <holden@pigscanfly.ca>
To: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised
Cc: "Holden Karau" <holdenk@xandros.com>,
       "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
In-Reply-To: <87slh4tesh.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454765AC.1050905@xandros.com> <87mz7cqvd8.fsf@duaron.myhome.or.jp>
	 <f46018bb0610311046t6aa969ccy60a2020f7e5a0ed9@mail.gmail.com>
	 <87slh4tesh.fsf@duaron.myhome.or.jp>
X-Google-Sender-Auth: a7cbdaf35892cf95
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keep in mind these results are with a slow external drive, but yah
fat32 sync performance is still really bad.

This patch is just meant to make fat32 sync performance better, not
necessarily make it usable for everyone [one step at a time and all
that]. FAT32 sync is quite slow (see
http://readlist.com/lists/vger.kernel.org/linux-kernel/22/111761.html
), so if you want fast performance [or have drives with limited write
cycles] async is almost definitely the way to go.

I have a patch [not this one] which adds a module param ("fast") which
syncs the FAT tables after 30 seconds of no write activity, but I
don't think the majority of people are interested in it.

On 10/31/06, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> "Holden Karau" <holden@pigscanfly.ca> writes:
>
> > The performance increase is pretty small. Using an old external dirve
> > I had lying around I got:
> > diff -y stock/10k modified/10k
> > 10240+0 records in                                            | 1024+0
> > records in
> > 10240+0 records out                                           | 1024+0
> > records out
> > 5242880 bytes transferred in 18.280922 seconds (286795 bytes/ | 524288
> > bytes transferred in 1.824985 seconds (287283 bytes/se
>
> 1024 records out 1.824985 seconds. Is there decrease case?  I assume
> the result is same. So, we would need different approach.
>
> > diff -y stock/1k modified/1k
> > 1024+0 records in                                               1024+0
> > records in
> > 1024+0 records out                                              1024+0
> > records out
> > 524288 bytes transferred in 1.777250 seconds (295000 bytes/se | 524288
> > bytes transferred in 1.764748 seconds (297089 bytes/se
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>


-- 
Cell: 613-276-1645
