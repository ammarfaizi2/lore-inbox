Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVAUJAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVAUJAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 04:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVAUJAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 04:00:45 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14497 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261578AbVAUJAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 04:00:41 -0500
Date: Fri, 21 Jan 2005 10:00:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] to fix xtime lock for in the RT kernel patch
Message-ID: <20050121090014.GA30379@elte.hu>
References: <41F04573.7070508@mvista.com> <20050121063519.GA19954@elte.hu> <41F0BA56.9000605@mvista.com> <20050121082125.GA28267@elte.hu> <41F0BFA4.5030107@mvista.com> <20050121084557.GA29550@elte.hu> <41F0C33D.60908@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F0C33D.60908@mvista.com>
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


* George Anzinger <george@mvista.com> wrote:

> What I am suggesting is spliting the mark code so that it would only
> grap the offset (current TSC in most systems) during interrupt
> processing.  Applying this would be done later in the thread.  Since
> it is not applying the offset, the xtime_lock would not need to be
> taken.

ok, you are right, and this would be fine with me. Wanna take a shot at
it? I've uploaded the -03 patch which is my most current tree. (with the
do_timer() moving done already.) I've reviewed the TSC offset codepath
again and i'm not sure where i got the 10 usecs from ... it's a pretty
cheap codepath that can be done in the direct interrupt just fine.

	Ingo
