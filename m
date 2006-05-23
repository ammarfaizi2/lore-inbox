Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWEWU0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWEWU0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 16:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWEWU0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 16:26:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:40602 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932127AbWEWU0L (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 23 May 2006 16:26:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JsrnSrLRFqVNWNh6QyZlZZj3J1QOWTP9+oGHaNUqUN4VuoYYbatokPxVjB7VnfGT71RItUSGjVLCbFLKpwV7HHmcDlqVaj/mjVKTJ6iBQ4mVhqTFifakeTwk3n3KrSVgQmxvM75g2DHXndNCm6j6frgwjmMegAswoQKHB76akzg=
Message-ID: <b5d90b2a0605231326g5319fea8wb9efef34ee5f7ec6@mail.gmail.com>
Date: Wed, 24 May 2006 00:26:09 +0400
From: "Alexey Polyakov" <alexey.polyakov@gmail.com>
To: "Hans Reiser" <reiser@namesys.com>
Subject: Re: [PATCH] updated reiser4 - reduced cpu usage for writes by writing more than 4k at a time (has implications for generic write code and eventually for the IO layer)
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>,
       "Reiserfs developers mail-list" <Reiserfs-Dev@namesys.com>,
       "Reiserfs mail-list" <Reiserfs-List@namesys.com>,
       "Nate Diller" <ndiller@namesys.com>
In-Reply-To: <44736D3E.8090808@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44736D3E.8090808@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm actively using Reiser4 on a production servers (and I know a lot
of people that do that too).
Could you please release the patch against the vanilla tree?
I don't think there's a lot of people that will test -mm version,
especially on production servers - -mm is a little bit too unstable.

Thanks.


On 5/24/06, Hans Reiser <reiser@namesys.com> wrote:
> ftp://ftp.namesys.com/pub/reiser4-for-2.6/2.6.17-rc4-mm1/reiser4-for-2.6.17-rc4-mm1-2.patch.gz
>
> The referenced patch replaces all reiser4 patches to mm.  It revises the
> existing reiser4 code to do a good job for writes that are larger than
> 4k at a time by assiduously adhering to the principle that things that
> need to be done once per write should be done once per write, not once
> per 4k.  That statement is a slight simplification: there are times when
> due to the limited size of RAM you want to do some things once per
> WRITE_GRANULARITY, where WRITE_GRANULARITY is a #define that defines
> some moderate number of pages to write at once.  This code empirically
> proves that the generic code design which passes 4k at a time to the
> underlying FS can be improved.  Performance results show that the new
> code consumes  40% less CPU when doing "dd bs=1MB ....." (your hardware,
> and whether the data is in cache, may vary this result).  Note that this
> has only a small effect on elapsed time for most hardware.
>
> The planned future(as discussed with akpm previously):  we will ship
> very soon (testing it now) an improved reiser4 read code that does reads
> in more than little 4k chunks.  Then we will revise the generic code to
> allow an FS to receive the writes and reads in whole increments.  How
> best to revise the generic code is still being discussed.  Nate is
> discussing doing it in some way that improves code symmetry in the io
> scheduler layer as well, if there is interest by others in it maybe a
> thread can start on that topic, or maybe it can wait for him+zam to make
> a patch.
>
> Note for users: this patch also contains numerous important bug fixes.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Alexey Polyakov
