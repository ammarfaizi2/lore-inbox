Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTFXRl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTFXRl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:41:56 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:20489 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262363AbTFXRlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:41:52 -0400
Date: Tue, 24 Jun 2003 19:43:31 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, marcelo@conectiva.com.br,
       kpfleming@cox.net, stoffel@lucent.com, gibbs@scsiguy.com,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <20030624174331.GA31650@alpha.home.local>
References: <20030509150207.3ff9cd64.skraw@ithnet.com> <41560000.1055306361@caspian.scsiguy.com> <20030611222346.0a26729e.skraw@ithnet.com> <16103.39056.810025.975744@gargle.gargle.HOWL> <20030613114531.2b7235e7.skraw@ithnet.com> <20030621105019.GA834@pcw.home.local> <20030623133053.30d6cb88.skraw@ithnet.com> <20030624131138.249fb7df.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030624131138.249fb7df.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

> Is it possible that the verification errors do not occur because of a read
> problem, but because of a page cached block getting trashed somehow between
> "tar to tape" and "read from tape". I would suspect that some blocks survive in
> memory and are re-used during verification. If for some reason this data is
> invalid or corrupted the verification fails although the read was correct.

That seems strange to me, I don't see how we could cache data from a char
device. It is possible that chkblk and tar don't use same block size and that
your problem only occurs on larger transfers, or particularly aligned ones.

You could try to increase the block size in chkblk to something bigger than a
page for example. I don't know if tar reads your tape at full speed, but it's
possible that if it doesn't cope with the tape speed, an overrun occurs and
something finally gets dropped :-/

> I know that this sounds weird, but nevertheless possible, or not?
> It may even be worse, the data may have also been left from the original nfs
> action, correct?
> Is there a way to completely invalidate/flush all cached blocks concerning this
> fs (besides umount)?

I don't believe in this. But as Justin says, this card can get very high
performances and hassle the hardware. Perhaps you have a rare weakness in your
hardware that only occurs under these conditions, although I don't know how
this could be checked.

IIRC, you said that it works flawlessly in UP and you need SMP to hit the bug.
Perhaps your second CPU is sometimes flaky (bad cache, etc...) :-/

Cheers,
Willy

