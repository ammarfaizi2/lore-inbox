Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132756AbRDQQlc>; Tue, 17 Apr 2001 12:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132757AbRDQQlM>; Tue, 17 Apr 2001 12:41:12 -0400
Received: from arpa.it.uc3m.es ([163.117.139.120]:51984 "EHLO arpa.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S132756AbRDQQlD>;
	Tue, 17 Apr 2001 12:41:03 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200104171640.f3HGeRb32326@oboe.it.uc3m.es>
Subject: block devices don't work without plugging in 2.4.3
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Tue, 17 Apr 2001 18:40:27 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, anyway, as far as I can tell, the following has been lost from
__make_request() in ll_rw_blk.c since the 2.4.0 days:

 out:
-       if (!q->plugged)
-               (q->request_fn)(q);
        if (freereq)

The result appears to be that if a block device has called
blk_queue_pluggable() to register a no-op plug_fn, then
q->plugged will never be set (it's the duty of the plug_fn),
and the devices registered request function wil never be called.

This behaviour is distinct from 2.4.0, where registering a 
no-op made things work fine.

Is the policy now supposed to be that we do some more work
in the "no-op"?  What am I supposed to do if I don't want
plugging(1)(2)?

(1) goes away and looks ....
(2) actually, I do want plugging, but I like to keep the
    no-plug option around so that I can benchmark the difference
    and also provide a very conservative option setting.

Peter
