Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268961AbUICO5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268961AbUICO5b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 10:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269056AbUICO5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 10:57:30 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:59423 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268961AbUICO5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 10:57:25 -0400
To: Andi Kleen <ak@suse.de>
Cc: jakub@redhat.com, ecd@skynet.be, pavel@suse.cz, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] fs/compat.c: rwsem instead of BKL around
 ioctl32_hash_table
X-Message-Flag: Warning: May contain useful information
References: <20040901072245.GF13749@mellanox.co.il>
	<524qmi2e1s.fsf@topspin.com> <20040902211448.GE16175@wotan.suse.de>
	<52isawtihi.fsf@topspin.com> <20040903143718.GB4699@wotan.suse.de>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 03 Sep 2004 07:55:23 -0700
In-Reply-To: <20040903143718.GB4699@wotan.suse.de> (Andi Kleen's message of
 "Fri, 3 Sep 2004 16:37:19 +0200")
Message-ID: <52r7pjs8pw.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Sep 2004 14:55:23.0731 (UTC) FILETIME=[0A674A30:01C491C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> The BKL couldn't protect again removal of sleeping compat
    Andi> handlers anyways because the BKL is dropped during a
    Andi> schedule, and they all can sleep in user accesses.  During
    Andi> this scheduling window the module could be unloaded if its
    Andi> count was zero. But with the assumption above this cannot
    Andi> happen.

    Andi> So basically the locking there is not to protect against
    Andi> running handlers, just to ensure consistency during the list
    Andi> walking. The list isn't touched anymore after the compat
    Andi> handler runs, so the sleeping in there is no problem.

    Andi> RCU could be used as well to protect the list because there
    Andi> is no sleep involved.

OK, good point.  My logic was wrong when I considered RCU.  But now I
don't understand what you meant by "it cannot work" when you wrote
this in your previous email:

    Andi> If you wanted to fix it properly better make it use RCU -
    Andi> but it cannot work for the case of calling a compat handler.

Based on what you just wrote, it seems to me like RCU would actually
work fine.  Is this wrong?

Thanks,
  Roland
