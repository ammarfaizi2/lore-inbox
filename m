Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWDKM1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWDKM1r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 08:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWDKM1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 08:27:47 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:59523 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750800AbWDKM1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 08:27:47 -0400
Message-ID: <443BA1D3.1070200@sw.ru>
Date: Tue, 11 Apr 2006 16:32:19 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, "Eric W. Biederman" <ebiederm@xmission.com>,
       xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 0/5] uts namespaces: Introduction
References: <20060407095132.455784000@sergelap>
In-Reply-To: <20060407095132.455784000@sergelap>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge,

> This patchset is based on Kirill Korotaev's Mar 24 submission, taking
> comments (in particular from James Morris and Eric Biederman) into
> account.
thanks a lot for doing this!

> Some performance results are attached.  I was mainly curious whether
> it would be worth putting the task_struct->uts_ns pointer inside
> a #ifdef CONFIG_UTS_NS.  The result show that leaving it in when
> CONFIG_UTS_NS=n has negligable performance impact, so that is the
> approach this patch takes.
Serge, your testing approach looks really strange for me.
First of all, you selected the worst namespace to check performance 
overhead on.
1) uts_ns is rarely used and never used on hot paths,
2) also all these test suites below doesn't test the code paths you 
modified.

So I wonder what was the goal of these tests, especially dbench?!

Thanks,
Kirill

> 
> -serge
> 
> Performance testing was done on a 2-cpu hyperthreaded
> x86 box with 16G ram.  The following tests were run:
> 	dbench (20 times, four clients, on reiser fs non-isolated partition)
> 	tbench (20 times, 5 connections)
> 	kernbench (20 times)
> 	reaim (20 times ranging from 1 to 15 users)
> 
> They were run on 2.6.17-rc1:
> 	pristine
> 	patched, but with !CONFIG_UTS_NS ("disabled")
> 	patched with CONFIG_UTS_NS=y ("enabled")
> 
> All results are presented as means +/- 95% confidence interval.
> 
> Dbench results:
> pristine:          387.080727 +/- 9.344585
> patched disabled:  389.524364 +/- 9.574921
> patched enabled:   370.155600 +/- 30.127808
> 
> Tbench results:
> pristine:         388.940100 +/- 18.095104
> patched disabled: 389.173700 +/- 23.658035
> patched enabled:  394.333200 +/- 25.813393
> 
> Kernbench results:
> pristine:          70.317500 +/- 0.210833
> patched, disabled: 70.860000 +/- 0.179292
> patched, enabled:  70.346500 +/- 0.184784
> 
> Reaim results:
> pristine:
>         Nclients      Mean         95% CI
>            1     106080.000000  11327.896029
>            3     236057.142000  18205.544810
>            5     247867.136000  23536.800062
>            7     265370.000000  21284.335743
>            9     262969.936000  18225.497529
>           11     278256.000000  6230.342816
>           13     284288.016000  8924.589388
>           15     286987.170000  7881.034658
> 
> patched, disabled:
>         Nclients      Mean         95% CI
>            1     105400.000000  8739.978241
>            3     229500.000000  0.000000
>            5     252325.176667  16685.663423
>            7     265125.000000  6747.777319
>            9     271258.645000  11715.635212
>           11     280662.608333  7775.229351
>           13     277719.706667  8173.390359
>           15     278515.421667  10963.211450
> 
> patched, enabled:
>         Nclients      Mean         95% CI
>            1     102000.000000  0.000000
>            3     224400.000000  14159.870036
>            5     242963.288000  40529.490781
>            7     255150.000000  8745.802081
>            9     270154.284000  8918.863136
>           11     283134.260000  12239.361252
>           13     288497.540000  11336.550964
>           15     280022.728000  8804.882369
> 
> 


