Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135592AbRDSKkc>; Thu, 19 Apr 2001 06:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135596AbRDSKkV>; Thu, 19 Apr 2001 06:40:21 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:13582 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S135592AbRDSKkG>;
	Thu, 19 Apr 2001 06:40:06 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200104191039.f3JAdvq15198@oboe.it.uc3m.es>
Subject: block devices don't work without plugging in 2.4.3
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Thu, 19 Apr 2001 12:39:57 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to repeat .. I didn't see this go out on the list and I haven't
had any reply. So let's ask again. Is this a new coding error in ll_rw_blk?

 -----------------

The following has been lost from __make_request() in ll_rw_blk.c since
2.4.2 (incl):

 out:
-       if (!q->plugged)
-               (q->request_fn)(q);
        if (freereq)

The result is that a block device that doesn't do plugging doesn't
work.

If it has called blk_queue_pluggable() to register a no-op plug_fn,
then q->plugged will never be set (it's the duty of the plug_fn), and
the devices registered request function will never be called.

This behaviour is distinct from 2.4.0, where registering a no-op
plug_fn made things work fine.

Is this a coding oversight?

Peter (ptb@it.uc3m.es)
