Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVJFQrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVJFQrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVJFQrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:47:13 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:31201 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751142AbVJFQrL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:47:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AQie2BUiWDTSvnhpmTHETY5s36SgJhMJ2v0oOXARmqsTH0hPdhzzytor30FwxQIFtnMnSJ6L+6XDX4a9geNnulYSS1aNGqmU01ZINQDm0elX7emapMxr24NWgtsz1XlHSvRgYoA5KJtLXwszp5iMl0nZ8qMTBAm17D4v+NOKlLg=
Message-ID: <1c190f10510060947s5e6099d4pe9bed56e360551f4@mail.gmail.com>
Date: Thu, 6 Oct 2005 09:47:11 -0700
From: Todd Kneisel <todd.kneisel@gmail.com>
Reply-To: Todd Kneisel <todd.kneisel@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt2
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
In-Reply-To: <20051004084405.GA24296@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051004084405.GA24296@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> i have released the 2.6.14-rc3-rt2 tree, which can be downloaded from
> the usual place:
>
>   http://redhat.com/~mingo/realtime-preempt/
>
> the biggest change in this release is the long-anticipated merge of a
> streamlined version of the "robust futexes/mutexes with priority
> queueing and priority inheritance" code into the -rt tree. The original
> upstream patch is from Todd Kneisel, with further improvements, cleanups
> and -RT integration done by David Singleton.
>

My original patch implemented robust futexes using the existing futex
wait queue mechanisms, because the project I'm working on does not
need priority inheritance or other realtime features. David's changes
replaced the wait queue mechanisms with rt_mutexes. I'm working on
a patch to add my implementation back in, so the kernel will support
both robust wait-queue futexes and robust rt_mutex futexes. Does
anyone else see the need for this?

Also, my patch implemented only shared robust futexes. David's work
was based on mine, so the current code only supports shared robust
futexes that may or may not be priority inheritance. It doesn't support
priority inheritance mutexes that are not robust, or that are not shared.

Todd.
