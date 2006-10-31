Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423784AbWJaSqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423784AbWJaSqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423790AbWJaSqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:46:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:3125 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423784AbWJaSqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:46:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bXNpviz8iMfdTl7ynsZZFw01ZQlVhztgKarHcCgxSPh7LKk0UjTQLI+RkZfAIlV7MDnEbwW2ttkxOQ3OOBm+olqQND7ThffZakabwaswRkdQQW9sx2ZuTuT40Sjht0LRlPeE+7V9bN1XEHiMgvUaMq5WvwB76dhGHiBn69uLPFI=
Message-ID: <f46018bb0610311046t6aa969ccy60a2020f7e5a0ed9@mail.gmail.com>
Date: Tue, 31 Oct 2006 13:46:46 -0500
From: "Holden Karau" <holden@pigscanfly.ca>
To: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised
Cc: "Holden Karau" <holdenk@xandros.com>,
       "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
In-Reply-To: <87mz7cqvd8.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454765AC.1050905@xandros.com> <87mz7cqvd8.fsf@duaron.myhome.or.jp>
X-Google-Sender-Auth: 55c454e58649515a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The performance increase is pretty small. Using an old external dirve
I had lying around I got:
diff -y stock/10k modified/10k
10240+0 records in                                            | 1024+0
records in
10240+0 records out                                           | 1024+0
records out
5242880 bytes transferred in 18.280922 seconds (286795 bytes/ | 524288
bytes transferred in 1.824985 seconds (287283 bytes/se
diff -y stock/1k modified/1k
1024+0 records in                                               1024+0
records in
1024+0 records out                                              1024+0
records out
524288 bytes transferred in 1.777250 seconds (295000 bytes/se | 524288
bytes transferred in 1.764748 seconds (297089 bytes/se

The usual disclaimer of any benchmarking applies, YMMV.

Cheers,

Holden :-)

On 10/31/06, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> Holden Karau <holdenk@xandros.com> writes:
>
> > From: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com
> > This is an attempt at improving fat_mirror_bhs in sync mode [namely it
> > writes all of the data for a backup block, and then blocks untill
> > finished]. The old behavior would write & block in smaller chunks, so
> > this should be slightly faster. It also removes the fix me requesting
> > that it be fixed to behave this way :-)
>
> Please post the result of performance test.  If it's fairly big, we
> would be able to use async for mirror FAT. Instead, for hotplug device
> we can provide the another option.
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>


-- 
Cell: 613-276-1645
