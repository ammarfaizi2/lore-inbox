Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272512AbTGaPJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272511AbTGaPJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:09:37 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:34245
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272509AbTGaPIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:08:25 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test2-mm1 results
Date: Fri, 1 Aug 2003 01:13:02 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <5110000.1059489420@[10.10.2.4]> <200307310128.50189.kernel@kolivas.org> <58530000.1059663364@[10.10.2.4]>
In-Reply-To: <58530000.1059663364@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308010113.02866.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Aug 2003 00:56, Martin J. Bligh wrote:
> --Con Kolivas <kernel@kolivas.org> wrote (on Thursday, July 31, 2003 
01:28:49 +1000):
> > On Thu, 31 Jul 2003 01:01, Martin J. Bligh wrote:
> >> OK, so test2-mm1 fixes the panic I was seeing in test1-mm1.
> >> Only noticeable thing is that -mm tree is consistently a little slower
> >> at kernbench
> >
> > Could conceivably be my hacks throwing the cc cpu hogs onto the expired
> > array more frequently.
>
> Kernbench: (make -j vmlinux, maximal tasks)
>                               Elapsed      System        User         CPU
>               2.6.0-test2       46.05      115.20      571.75     1491.25
>           2.6.0-test2-con       46.98      121.02      583.55     1498.75
>           2.6.0-test2-mm1       46.95      121.18      582.00     1497.50
>
> Good guess ;-)
>
> Does this help interactivity a lot, or was it just an experiment?
> Perhaps it could be less agressive or something?

Well basically this is a side effect of selecting out the correct cpu hogs in 
the interactivity estimator. It seems to be working ;-) The more cpu hogs 
they are the lower dynamic priority (higher number) they get, and the more 
likely they are to be removed from the active array if they use up their full 
timeslice. The scheduler in it's current form costs more to resurrect things 
from the expired array and restart them, and the cpu hogs will have to wait 
till other less cpu hogging tasks run. 

How do we get around this? I'll be brave here and say I'm not sure we need to, 
as cpu hogs have a knack of slowing things down for everyone, and it is best 
not just for interactivity for this to happen, but for fairness.

I suspect a lot of people will have something to say on this one...

Con

