Return-Path: <SRS0=GIeg=ZU=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B71BC432C0
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 17:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF43C21771
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 17:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dlnOGDPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfK1RFg (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:05:36 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:38818 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1RFg (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 28 Nov 2019 12:05:36 -0500
Received: by mail-pj1-f48.google.com with SMTP id l4so762377pjt.5
        for <io-uring@vger.kernel.org>; Thu, 28 Nov 2019 09:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UTrbLlUU5oQGe5GDYk+NyCIAtZo35o2Te6th8V78ruw=;
        b=dlnOGDPZY1KX0aCASOArQF7EOwkUXohdOWQu+j9xHdDlK2Omgz+GlV8FrSz8k2MPR6
         xBHq0s+pdB5XcFTOKZP1oOBUUseYQtCpuQqfm0p8XMRrhlI638gPAn3ZEGdFwjsm0o37
         gSBap58X9VBlYk8mJ/3OevibWTU30gFqTiukSysneZ31rXeDXJdIdVqaBJKhjC+RjWZE
         2Q3nvIcBUjxG8tYkKmsLT0KH7KQjxUXDlbKWYrL9L+ho3U9FAPIoGeOwl2SQbG4S6P8I
         d62Eurqyo3HSml6chRjnXV5+r3zHyP3sLnDBHGJU7qhWTScGN54eyHbl243sFhvgdXL6
         +GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UTrbLlUU5oQGe5GDYk+NyCIAtZo35o2Te6th8V78ruw=;
        b=StxOA62Rk7p9GMCU5ltgqlJ5AcrF2k6Z/opxllfCMW+Ve/53VRi/lKR0CGMCYjNDSf
         d9u4FDutymnvULpDP+5II8JZuZIsl1ZbocIsJXKJVh7qUKznHsQFUh3q/0qmaevr/RSM
         FsO2DtB5i7/N564ToVNIocJwDatNJUFexeOI2q3aPx1AJIiwkiSWPFsOg0Qj1G7aLAyb
         FGYcJXoTAn9g4xL2Ipo2Mi2Q4n8h6oCsl23Eo/A9PUZBvl/fej7n0kI4dGH1wgrf1/q+
         GrD63vic3VvQ3AHomdbyjglXTrwwGB5Bd6HHjpC4I3mp3klhzqIJNDs9mu4fjso3a05i
         EKeQ==
X-Gm-Message-State: APjAAAVp4mrVJ9/M53Us3v104ehrvYHiw3N9FjDfKLsqWPtw/eB7OZAZ
        SFVKFlxNvSOg26hJnG2GLU2EhLPsz13iKw==
X-Google-Smtp-Source: APXvYqxerujh3tKSfyZyKbdeRF674f9+vi3rw9XAurvRzRZcw8PuYJF46wDXkIeECNpe5XeZ+7XZZA==
X-Received: by 2002:a17:902:68:: with SMTP id 95mr10411904pla.117.1574960733013;
        Thu, 28 Nov 2019 09:05:33 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:a930:60a8:686e:252a? ([2605:e000:100e:8c61:a930:60a8:686e:252a])
        by smtp.gmail.com with ESMTPSA id h5sm4742009pfk.30.2019.11.28.09.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 09:05:31 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Final io_uring bits for 5.5-rc1
Message-ID: <7976eeb9-b8b5-753b-0d8f-203a00fc1118@kernel.dk>
Date:   Thu, 28 Nov 2019 09:05:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi Linus,

As mentioned in the first pull request, there was a later batch as well.
This contains fixes to the stuff that already went in, cleanups, and a
few later additions. In particular, this pull request contains:

- Cleanups/fixes/unification of the submission and completion
   path (Pavel,me)

- Linked timeouts improvements (Pavel,me)

- Error path fixes (me)

- Fix lookup window where cancellations wouldn't work (me)

- Improve DRAIN support (Pavel)

- Fix backlog flushing -EBUSY on submit (me)

- Add support for connect(2) (me)

- Fix for non-iter based fixed IO (Pavel)

- creds inheritance for async workers (me)

- Disable cmsg/ancillary data for sendmsg/recvmsg (me)

- Shrink io_kiocb to 3 cachelines (me)

- NUMA fix for io-wq (Jann)

Please pull!


   git://git.kernel.dk/linux-block.git tags/for-5.5/io_uring-post-20191128


----------------------------------------------------------------
Dan Carpenter (1):
       io-wq: remove extra space characters

Hrvoje Zeba (1):
       io_uring: remove superfluous check for sqe->off in io_accept()

Jann Horn (2):
       io_uring: use kzalloc instead of kcalloc for single-element allocations
       io-wq: fix handling of NUMA node IDs

Jens Axboe (23):
       io_uring: io_async_cancel() should pass in 'nxt' request pointer
       io_uring: cleanup return values from the queueing functions
       io_uring: make io_double_put_req() use normal completion path
       io_uring: make req->timeout be dynamically allocated
       io_uring: fix sequencing issues with linked timeouts
       io_uring: remove dead REQ_F_SEQ_PREV flag
       io_uring: correct poll cancel and linked timeout expiration completion
       io_uring: request cancellations should break links
       io-wq: wait for io_wq_create() to setup necessary workers
       io_uring: io_fail_links() should only consider first linked timeout
       io_uring: io_allocate_scq_urings() should return a sane state
       io_uring: allow finding next link independent of req reference count
       io_uring: close lookup gap for dependent next work
       io_uring: improve trace_io_uring_defer() trace point
       io_uring: only return -EBUSY for submit on non-flushed backlog
       net: add __sys_connect_file() helper
       io_uring: add support for IORING_OP_CONNECT
       io-wq: have io_wq_create() take a 'data' argument
       io_uring: async workers should inherit the user creds
       net: separate out the msghdr copy from ___sys_{send,recv}msg()
       net: disallow ancillary data for __sys_{send,recv}msg_file()
       io-wq: shrink io_wq_work a bit
       io_uring: make poll->wait dynamically allocated

Pavel Begunkov (15):
       io_uring: break links for failed defer
       io_uring: remove redundant check
       io_uring: Fix leaking linked timeouts
       io_uring: Always REQ_F_FREE_SQE for allocated sqe
       io_uring: drain next sqe instead of shadowing
       io_uring: rename __io_submit_sqe()
       io_uring: add likely/unlikely in io_get_sqring()
       io_uring: remove io_free_req_find_next()
       io_uring: pass only !null to io_req_find_next()
       io_uring: simplify io_req_link_next()
       io_uring: only !null ptr to io_issue_sqe()
       io_uring: fix dead-hung for non-iter fixed rw
       io_uring: store timeout's sqe->off in proper place
       io_uring: inline struct sqe_submit
       io_uring: cleanup io_import_fixed()

  fs/io-wq.c                      | 187 ++++++----
  fs/io-wq.h                      |  63 +++-
  fs/io_uring.c                   | 776 ++++++++++++++++++++++------------------
  include/linux/socket.h          |   3 +
  include/trace/events/io_uring.h |  16 +-
  include/uapi/linux/io_uring.h   |   1 +
  net/socket.c                    | 214 +++++++----
  7 files changed, 757 insertions(+), 503 deletions(-)

-- 
Jens Axboe

