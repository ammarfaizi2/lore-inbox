Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVFNI55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVFNI55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 04:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVFNI55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 04:57:57 -0400
Received: from postman4.arcor-online.net ([151.189.20.158]:50891 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261197AbVFNI5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 04:57:55 -0400
Date: Tue, 14 Jun 2005 10:57:44 +0200
From: quade <quade@hsnr.de>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: latency error (~2ms) with nanosleep
Message-ID: <20050614085744.GA10668@hsnr.de>
References: <20050613133047.GA11979@hsnr.de> <42ADB8D1.9090503@nortel.com> <29495f1d05061309543a88f9bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d05061309543a88f9bb@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 09:54:47AM -0700, Nish Aravamudan wrote:
> On 6/13/05, Chris Friesen <cfriesen@nortel.com> wrote:
> > quade wrote:
> > > Playing around with the (simple) measurement of latency-times
> > > I noticed, that the systemcall "nanosleep" has always a minimal
> > > latency from about ~2ms (haven't run it all night, so...). It
> > > seems to be a systematical error.
> > 
> > Known issue.  The x86 interrupt usually has a period of slightly less
> > than a ms.  It will therefore generally add nearly a whole ms to ensure
> > that it does not ever wait for *less* than specified.
> 
> Exactly. And the sys_nanosleep() code adds one more if the parameter
> has any positive value at all:
> 
>         expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);


>         current->state = TASK_INTERRUPTIBLE;
>         expire = schedule_timeout(expire);
> 
> Thanks,
> Nish
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
