Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUFUFrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUFUFrb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 01:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUFUFrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 01:47:31 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:62429 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266127AbUFUFr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 01:47:27 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Takao Indoh <indou.takao@soft.fujitsu.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function 
In-reply-to: Your message of "Thu, 17 Jun 2004 14:13:56 +0200."
             <20040617121356.GA24338@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 Jun 2004 15:46:11 +1000
Message-ID: <1642.1087796771@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 14:13:56 +0200, 
Ingo Molnar <mingo@elte.hu> wrote:
>but there's another possible method (suggested by Alan Cox) that
>requires no changes to the timer API hotpaths: 'clear' all timer lists
>upon a crash [once all CPUs have stopped and irqs are disabled] and just
>let the drivers use the normal timer APIs. Drive timer execution via a
>polling method.
>
>this basically approximates your polling based implementation but uses
>the existing kernel timer data structures and timer mechanism so should
>be robust and compatible. It doesnt rely on any previous state (because
>all currently pending timers are discarded) so it's as crash-safe as
>possible.

Don't forget live crash dumping.  The system is running and is behaving
strangely so you want to take a dump for investigation, but you do not
want to kill the system afterwards.  Live crash dumping is very useful
for problem diagnosis.

It is a little more complex than dumping after an oops because you must
not destroy any kernel data, including timer lists.

