Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWGDSnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWGDSnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 14:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWGDSnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 14:43:32 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:14283 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932328AbWGDSnb (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 14:43:31 -0400
Message-ID: <44AAB6D4.1040101@namesys.com>
Date: Tue, 04 Jul 2006 11:43:32 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: "Vladimir V. Saveliev" <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
       lkml <Linux-Kernel@vger.kernel.org>, reiserfs-dev@namesys.com
Subject: Re: [PATCH 1/2] batch-write.patch
References: <44A42750.5020807@namesys.com>	 <20060629185017.8866f95e.akpm@osdl.org>	 <1152011576.6454.36.camel@tribesman.namesys.com>	 <1152012117.6454.41.camel@tribesman.namesys.com> <84144f020607040507u58489b8eqfe8f41ef0d76b369@mail.gmail.com>
In-Reply-To: <84144f020607040507u58489b8eqfe8f41ef0d76b369@mail.gmail.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

> On 7/4/06, Vladimir V. Saveliev <vs@namesys.com> wrote:
>
>> @@ -784,6 +786,8 @@ otherwise noted.
>>
>>    writev: called by the writev(2) system call
>>
>> +  batch_write: optional, if implemented called by writev(2) and
>> write(2)
>> +
>
>
> It'd be nice if you added some explanation here why a filesystem
> developer would want to implement it.
>
>                                       Pekka
>
>
Vladimir, it sounds like he found another place you might insert this
comment:

+/*
+ * When calling the filesystem for writes, there is processing
+ * that must be done:
+ * 1) per word
+ * 2) per page
+ * 3) per call to the FS
+ * If the FS is called per page, then it turns out that 3) costs more
+ * than 1) and 2) for sophisticated filesystems.  To allow the FS to
+ * choose to pay the cost of 3) only once we call batch_write, if the
+ * FS supports it.
+ */


Thanks Pekka!
