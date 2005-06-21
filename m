Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVFUDbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVFUDbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVFUDYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:24:40 -0400
Received: from opersys.com ([64.40.108.71]:16146 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261723AbVFUCS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 22:18:59 -0400
Message-ID: <42B77B8C.6050109@opersys.com>
Date: Mon, 20 Jun 2005 22:29:32 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com>
In-Reply-To: <20050621015542.GB1298@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney wrote:
> It looks to me that I-PIPE is an example of a "nested OS", with
> Linux nested within the I-PIPE functionality. 

Sorry, the I-pipe is likely in the "none-of-the-above" category. It's
actually not much of a category itself. For one thing, it's clearly
not an RTOS in any sense of the word.

The I-pipe is just a layer that allows multiple pieces of code to
share an interrupt stream in a prioritized fashion. It doesn't
schedule anything or provide any sort of abstraction whatsoever.
Your piece of code just gets a spot in the pipeline and receives
interrupts accordingly. Not much nesting there. It's just a new
feature in Linux.

Have a look at the patches and description posted by Philippe last
Friday for more detail.

> One could take
> the RTAI-Fusion approach, but this measurement is of I-PIPE
> rather than RTAI-Fusion, right?  (And use of RTAI-Fusion might
> or might not change these results significantly, just trying to
> make sure I understand what these specific tests apply to.)

That's inconsequential. Whether Fusion is loaded or not doesn't
preclude a loaded driver to have a higher priority than
Fusion itself and therefore continue receiving interrupt even if
Fusion itself has disabled interrupts ...

The loading of Fusion would change nothing to these measurements.

> Also, if I understand correctly, the interrupt latency measured
> is to the Linux kernel running within I-PIPE, rather than to I-PIPE
> itself.  Is this the case, or am I confused?

What's being measured here is a loadable module that allocates an
spot in the ipipe that has higher priority than Linux and puts
itself there. Therefore, regardless of what other piece of code
in the kernel disables interrupts, that specific driver still
has its registered ipipe handler called deterministically ...

Don't know, but from the looks of it we're not transmitting on
the same frequency ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
