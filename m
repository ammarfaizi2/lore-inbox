Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWIODin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWIODin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 23:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWIODin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 23:38:43 -0400
Received: from gatekeeper.ncic.ac.cn ([159.226.41.188]:7377 "HELO ncic.ac.cn")
	by vger.kernel.org with SMTP id S1751554AbWIODin convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 23:38:43 -0400
Date: Fri, 15 Sep 2006 11:38:41 +0800
From: "Yingchao Zhou" <yc_zhou@ncic.ac.cn>
To: "Hugh Dickins" <hugh@veritas.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       "alan" <alan@redhat.com>, "zxc" <zxc@ncic.ac.cn>
Subject: Re: Re: Re: [RFC] PAGE_RW Should be added to PAGE_COPY ?
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <20060915033842.C205FFB045@ncic.ac.cn>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, 15 Sep 2006, Yingchao Zhou wrote:
>> >
>> >You want to mmap MAP_SHARED, which will use PAGE_SHARED instead,
>> >including the write bit, both before and after the mprotects.
>> >There should be no problem then: do you actually see a problem
>> >when MAP_SHARED is used?
>> It's ok to mmap MAP_SHARED. But is it not a normal way to malloc() a space and
>> then registered to NIC ?
>
>Not that I know of.  How would one register malloc()ed space to a NIC?
>Sorry, I may well be misunderstanding you.
The user-level NIC does this, eg. Myrinet...
>
>> >>      Adding PAGE_RW to PAGE_COPY will resolve this problem.  
>> >
>> >No!  That would give every user write access to shared files they
>> >should have no write access to.
>> I guess you refer to mmap a file MAP_READ|MAP_WRITE in MAP_PRIVATE way.
>> I think it is probably more logical to read the file data into an anoymous page and filled the pte with _PAGE_RW in the first time page-fault. It will probably reduce numbers of page fault interrupt.
>
>do_no_page() does just that when its fault demands write access; but
>doesn't waste memory and time on copying when it's only a read access.
>
Yeah, it is. But this is the source of the problem described above.
>Hugh
>
Yingchao Zhou


