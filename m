Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09278C433DB
	for <io-uring@archiver.kernel.org>; Wed, 24 Feb 2021 18:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C1A64F0B
	for <io-uring@archiver.kernel.org>; Wed, 24 Feb 2021 18:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhBXSxR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 24 Feb 2021 13:53:17 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:58082 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbhBXSve (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 24 Feb 2021 13:51:34 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lEzF9-00BE5k-Cx; Wed, 24 Feb 2021 11:50:39 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lEzF8-0003fV-Ej; Wed, 24 Feb 2021 11:50:39 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        io-uring@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20210224051845.GB6114@xsang-OptiPlex-9020>
        <m1czwpl83q.fsf@fess.ebiederm.org>
        <20210224183828.j6uut6sholeo2fzh@example.org>
Date:   Wed, 24 Feb 2021 12:50:21 -0600
In-Reply-To: <20210224183828.j6uut6sholeo2fzh@example.org> (Alexey Gladkov's
        message of "Wed, 24 Feb 2021 19:38:28 +0100")
Message-ID: <m17dmxl2qa.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lEzF8-0003fV-Ej;;;mid=<m17dmxl2qa.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19uDlW3DrHDIu/oovVJEMOIV0VkW2WC9Yw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: d28296d248:  stress-ng.sigsegv.ops_per_sec -82.7% regression
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> On Wed, Feb 24, 2021 at 10:54:17AM -0600, Eric W. Biederman wrote:
>> kernel test robot <oliver.sang@intel.com> writes:
>> 
>> > Greeting,
>> >
>> > FYI, we noticed a -82.7% regression of stress-ng.sigsegv.ops_per_sec due to commit:
>> >
>> >
>> > commit: d28296d2484fa11e94dff65e93eb25802a443d47 ("[PATCH v7 5/7] Reimplement RLIMIT_SIGPENDING on top of ucounts")
>> > url: https://github.com/0day-ci/linux/commits/Alexey-Gladkov/Count-rlimits-in-each-user-namespace/20210222-175836
>> > base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
>> >
>> > in testcase: stress-ng
>> > on test machine: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 112G memory
>> > with following parameters:
>> >
>> > 	nr_threads: 100%
>> > 	disk: 1HDD
>> > 	testtime: 60s
>> > 	class: interrupt
>> > 	test: sigsegv
>> > 	cpufreq_governor: performance
>> > 	ucode: 0x42e
>> >
>> >
>> > In addition to that, the commit also has significant impact on the
>> > following tests:
>> 
>> Thank you.  Now we have a sense of where we need to test the performance
>> of these changes carefully.
>
> One of the reasons for this is that I rolled back the patch that changed
> the ucounts.count type to atomic_t. Now get_ucounts() is forced to use a
> spin_lock to increase the reference count.

Which given the hickups with getting a working version seems justified.

Now we can add incremental patches on top to improve the performance.


Eric

