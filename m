Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272549AbRITVJ6>; Thu, 20 Sep 2001 17:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274649AbRITVJt>; Thu, 20 Sep 2001 17:09:49 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:32555 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272549AbRITVJb> convert rfc822-to-8bit; Thu, 20 Sep 2001 17:09:31 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Roger Larsson <roger.larsson@norran.net>, linux-kernel@vger.kernel.org,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200109200758.f8K7wEG13675@zero.tech9.net>
In-Reply-To: <1000939458.3853.17.camel@phantasy>
	<20010920063143.424BD1E41A@Cantor.suse.de>
	<20010920084131.C1629@athlon.random> 
	<200109200758.f8K7wEG13675@zero.tech9.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 17:09:17 -0400
Message-Id: <1001020162.6050.149.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 03:57, Dieter Nützel wrote:
> You've forgotten a one liner.
> 
>   #include <linux/locks.h>
> +#include <linux/compiler.h>
> 
> But this is not enough. Even with reniced artsd (-20).
> Some shorter hiccups (0.5~1 sec).


Note (I am repeated myself from an email I just sent) that the
conditional schedule won't show better results if
current->need_reschedule is unset, since preemption won't be enabled.  I
need to add explicit support to the preemption-test patch for this.

So you may see some better results, but just one time the condition
schedule does not occur, you will see the worst result in
/proc/latencytimes -- remembers its the 20 worst (perhaps we need
average or total latency, too?)

Now, with all that said, you should _see_ an improvement with this
patch.  You say short hiccups.  Some? All? How much better is it?

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

