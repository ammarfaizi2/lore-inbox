Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279389AbRJWLtm>; Tue, 23 Oct 2001 07:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279391AbRJWLtc>; Tue, 23 Oct 2001 07:49:32 -0400
Received: from s1.relay.oleane.net ([195.25.12.48]:54448 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S279389AbRJWLtY>; Tue, 23 Oct 2001 07:49:24 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Tue, 23 Oct 2001 13:49:45 +0200
Message-Id: <20011023114945.13204@smtp.adsl.oleane.com>
In-Reply-To: <20011023110344.17140@smtp.adsl.oleane.com>
In-Reply-To: <20011023110344.17140@smtp.adsl.oleane.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>SUSPEND_SAVE_STATE must run with interrupts enabled, as it's supposed
>to both block new incoming IOs and wait for pending ones to complete (*).
>It would be sub-efficient to force drivers to implement polled IOs for
>this case.

I forgot...

(*) Did you decide if you allowed that "call me again later" result code
from SUSPEND_SAVE_STATE ? If yes, that would mean you must loop notifying
all drivers that have not ack'ed it until they all do before going to
SUSPEND_POWER_DOWN. It's probably not much bloat to let the feature in,
as usual, it doesn't have to be used by drivers, but for those drivers
who knows it will take some time for pending async requests to complete,
it makes sense to let others perform they job. It would slightly speed
up the suspend process, which is not critical, but still nice ;)

Ben.




