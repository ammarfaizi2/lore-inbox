Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263119AbTCSTiZ>; Wed, 19 Mar 2003 14:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263120AbTCSTiZ>; Wed, 19 Mar 2003 14:38:25 -0500
Received: from mail-8.tiscali.it ([195.130.225.154]:57398 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263119AbTCSTiY>;
	Wed, 19 Mar 2003 14:38:24 -0500
Date: Wed, 19 Mar 2003 20:48:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4 delayed acks don't work, fixed
Message-ID: <20030319194859.GO30541@dualathlon.random>
References: <20030319002409.GI30541@dualathlon.random> <20030318.163701.56035556.davem@redhat.com> <20030319015517.GA15150@wotan.suse.de> <20030318.180219.91189534.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318.180219.91189534.davem@redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 06:02:19PM -0800, David S. Miller wrote:
> TCP needs at least a full window of data on the send side to clock
> things properly.  This streamer application doesn't give TCP that

the inflating doubling the ato is too slow after you destroyed the ato
info setting it to 4 this is why it takes so long for 2.4 to clock
things properly, at least you should inflate it with the average down.
the <= in the window raise check in recvmsg as well generate window
updates too early, I find better to wait two packets to be read before
sending the window update. Now that I understood better how the logic in
mainline works I'll try to make a better patch (not very soon though
since I'm busy with other stuff and next week I'll be offline most of
the time).

Andrea
