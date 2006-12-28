Return-Path: <linux-kernel-owner+w=401wt.eu-S964963AbWL1Wnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWL1Wnu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWL1Wnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:43:49 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:52175 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965027AbWL1Wns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:43:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nTyo4mJl0UbW6Sij1bQaVw3GG6dUq/50mMHqjPEbFB9H40f9Wdy4LShuIw5j0ABwyFZ9SdEjKzhrLhpalvv1rBjvcMFDAF8SDCTf5N7AVYzKiBC1cgEqnjLajMCu28idQZwy0v36SgApsXuLMH4OeWLDcNHPgxR+K1Zal4xxSz0=
Message-ID: <9e4733910612281443t53a1bbd8n97bbb35651cf6929@mail.gmail.com>
Date: Thu, 28 Dec 2006 17:43:48 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: BUG: scheduling while atomic, new libata code
Cc: "Randy Dunlap" <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200612282247.06127.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910612261747s4b32d6ben2e5a55f88f225edf@mail.gmail.com>
	 <20061226175559.e280e66e.randy.dunlap@oracle.com>
	 <9e4733910612271816x1ebc968auf94de2a84526aee0@mail.gmail.com>
	 <200612282247.06127.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/06, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 28 December 2006 03:16, Jon Smirl wrote:
> > BUG: scheduling while atomic: hald-addon-stor/0x20000000/5078
> > [<c02b0289>] __sched_text_start+0x5f9/0xb00
> > [<c024a623>] net_rx_action+0xb3/0x180
> > [<c01210f2>] __do_softirq+0x72/0xe0
> > [<c0105205>] do_IRQ+0x45/0x80
>
> This doesn't seem to be related to libata at all. Like your
> first trace, you call schedule from a softirq context, which
> is always atomic.
> The only place where I can imagine this happening is the
> local_irq_enable() in there, which can be defined in different
> ways.
> Are you running with paravirt_ops, CONFIG_TRACE_IRQFLAGS_SUPPORT
> and/or kernel preemption enabled?

This is set, although I don't recall setting it.
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y

Another odd thing I'm doing is simultaneously using a wired and
wireless net at the same time.

>
>         Arnd <><
>


-- 
Jon Smirl
jonsmirl@gmail.com
