Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264669AbUETInN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264669AbUETInN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 04:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbUETInN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 04:43:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:48330 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264669AbUETInK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 04:43:10 -0400
Date: Thu, 20 May 2004 10:41:43 +0200
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mulix@mulix.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Remove bogus WARN_ON in futex_wait
Message-Id: <20040520104143.6830f81b.ak@suse.de>
In-Reply-To: <1085013927.7624.5.camel@bach>
References: <20040519122350.2792e050.ak@suse.de>
	<20040519104339.GG31630@mulix.org>
	<20040519125001.3866f830.ak@suse.de>
	<1085013927.7624.5.camel@bach>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2004 10:52:46 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Which we've been trying to figure out.  We return -EINTR in this case
> even though it's a lie.  Don't know if it breaks anything, but I
> *really* want to know who the buggy waker is before pronouncing it
> harmless.

e.g. from ptrace, like Daniel said. I don't think it was from ptrace
in the case where I saw a report, but it shows that the WARN_ON is bogus.
If you really want to know what causes it you would need more debugging code
as Nick pointed out too. So, the WARN_ON in its current form
is known to trigger in a valid situation and not sufficient to find 
possible problems. I would remove it.

-Andi
