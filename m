Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUELUyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUELUyC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUELUyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:54:01 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63116 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263743AbUELUx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:53:57 -0400
Date: Wed, 12 May 2004 22:55:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: davidel@xmailserver.org, jgarzik@pobox.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512205538.GA19210@elte.hu>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com> <20040512200305.GA16078@elte.hu> <20040512132050.6eae6905.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512132050.6eae6905.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> #if HZ=1000
> #define	MSEC_TO_JIFFIES(msec) (msec)
> #define JIFFIES_TO_MESC(jiffies) (jiffies)
> #elif HZ=100
> #define	MSEC_TO_JIFFIES(msec) (msec * 10)
> #define JIFFIES_TO_MESC(jiffies) (jiffies / 10)
> #else
> #define	MSEC_TO_JIFFIES(msec) ((HZ * (msec) + 999) / 1000)
> #define	JIFFIES_TO_MSEC(jiffies) ...
> #endif

the HZ=100 define is broken. (it's correct in the -A2 patch i just
sent.)

why the +999 rounding up in the generic case?

	Ingo
