Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269160AbUIBWfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269160AbUIBWfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269158AbUIBWfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:35:08 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:47225 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S269160AbUIBWdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:33:35 -0400
To: Andi Kleen <ak@suse.de>
Cc: jakub@redhat.com, ecd@skynet.be, pavel@suse.cz, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/compat.c: rwsem instead of BKL around
 ioctl32_hash_table
X-Message-Flag: Warning: May contain useful information
References: <20040901072245.GF13749@mellanox.co.il>
	<524qmi2e1s.fsf@topspin.com> <20040902211448.GE16175@wotan.suse.de>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 02 Sep 2004 15:26:49 -0700
In-Reply-To: <20040902211448.GE16175@wotan.suse.de> (Andi Kleen's message of
 "Thu, 2 Sep 2004 23:14:48 +0200")
Message-ID: <52isawtihi.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Sep 2004 22:26:49.0392 (UTC) FILETIME=[F04D6B00:01C4913B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> It does not make much sense because the ioctl will take the
    Andi> BKL anyways.

True, but it seems pretty ugly to protect the ioctl32 hash with the
BKL.  I think the greater good of reducing use of the BKL should be
looked at.

    Andi> If you wanted to fix it properly better make it use RCU -
    Andi> but it cannot work for the case of calling a compat handler.

I'm not sure I follow what you're saying.  When I looked at this, at
first I thought RCU would be better for the hash lookup, but I didn't
see a way to prevent a compat handler from being removed while it was
running.  That's why I moved to a semaphore, which would hold off the
removal until the handler was done running.  Is this what you mean?
Do you see a way to use RCU here?

Thanks,
  Roland

