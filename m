Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUHQHru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUHQHru (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 03:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbUHQHrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 03:47:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39819 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264238AbUHQHrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 03:47:48 -0400
Date: Tue, 17 Aug 2004 09:48:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>, tytso@mit.edu
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040817074826.GA1238@elte.hu>
References: <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092374851.3450.13.camel@mindpipe> <1092375673.3450.15.camel@mindpipe> <20040813103151.GH8135@elte.hu> <1092699974.13981.95.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092699974.13981.95.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> I have attached a patch that effectively disables extract_entropy.  I
> am adding Theodore T'so to the cc: list as he is the author of the
> code in question.
> 
> For the time being this hack is required to avoid ~0.5 ms
> non-preemptible sections caused by the excessive memcpy's in
> extract_entropy.

i'm not 100% sure it's the memcpy's - but it's extract_entropy()
overhead. Might be the algorithmic slowness of SHATransform().

> +	return nbytes;
> +    

since this effectively disables the random driver i cannot add it to the
patch.

there's another thing you could try: various SHA_CODE_SIZE values in
drivers/char/random.c. Could you try 1, 2 and 3, does it change the
overhead as seen in the trace?

	Ingo
