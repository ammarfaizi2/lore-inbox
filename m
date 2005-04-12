Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263030AbVDLXdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbVDLXdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbVDLXa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:30:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:65512 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263075AbVDLX04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:26:56 -0400
Date: Wed, 13 Apr 2005 01:26:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUGs in 2.6.12-rc2-RT-V0.7.45-01
Message-ID: <20050412232648.GB23341@elte.hu>
References: <Pine.LNX.4.58.0504121443310.3023@echo.lysdexia.org> <20050412230921.GA22360@elte.hu> <Pine.LNX.4.58.0504121619470.3023@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504121619470.3023@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

> > what are you using kprobes for? Do you get lockups even if you disable 
> > kprobes?
> 
> I'm not using kprobes currently.  I'll recompile and see if the 
> lockups go away.

ah - it's an 'empty' kprobes check, and python triggered a userspace 
int3. I think kprobes should really get some RCU locking to check its 
handler list, to not slow down normal int3 processing. Meanwhile, 
disabling kprobes in the .config will probably work around this 
particular problem.

	Ingo
