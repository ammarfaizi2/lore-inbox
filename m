Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292328AbSBBRc5>; Sat, 2 Feb 2002 12:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292329AbSBBRcq>; Sat, 2 Feb 2002 12:32:46 -0500
Received: from mailc.telia.com ([194.22.190.4]:29404 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S292328AbSBBRch>;
	Sat, 2 Feb 2002 12:32:37 -0500
Message-Id: <200202021732.g12HWMU25229@mailc.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: Errors in the VM - detailed (or is it Tux? or rmap? or those together...)
Date: Sat, 2 Feb 2002 18:29:19 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.30.0202021751430.11143-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0202021751430.11143-100000@mustard.heime.net>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Roy,

> er..
> 
> # grep queue_nr_requests /usr/src/packed/k/2.4.17-rmap-11c
> #
Andrew did supply a patch for Riel but he did not accept all of it?

Lets see again. Do I understand you correctly:
rmap 11c fixes the problem #1 but not 11b? are all later
rmaps good?

rmap 11c:
  - oom_kill race locking fix                             (Andres Salomon)
  - elevator improvement                                  (Andrew Morton)
  - dirty buffer writeout speedup (hopefully ;))          (me)
  - small documentation updates                           (me)
  - page_launder() never does synchronous IO, kswapd
    and the processes calling it sleep on higher level    (me)
  - deadlock fix in touch_page()                          (me)
rmap 11b:

Lets see, not oom condition, no dirty buffers (read "only"),
not documentation, page_launder (no dirty...), not deadlock.
Remaining is the elevator... And that can really be it!
(read ahead related too...)

and 2.4.18-pre2 (or later) does not fix it?

2.4.18-pre2:
- ...
- Fix elevator insertion point on failed
  request merge					(Jens Axboe)
- ...
pre1:

-- 
Roger Larsson
Skellefteå
Sweden
