Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132473AbRDJXUs>; Tue, 10 Apr 2001 19:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132470AbRDJXUh>; Tue, 10 Apr 2001 19:20:37 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:58889 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S132472AbRDJXUZ>; Tue, 10 Apr 2001 19:20:25 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Let init know user wants to shutdown
Date: Tue, 10 Apr 2001 23:20:24 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9b04fo$9od$3@ncc1701.cistron.net>
In-Reply-To: <20010405000215.A599@bug.ucw.cz>
X-Trace: ncc1701.cistron.net 986944824 9997 195.64.65.67 (10 Apr 2001 23:20:24 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010405000215.A599@bug.ucw.cz>,
Pavel Machek  <pavel@suse.cz> wrote:
>Hi!
>
>Init should get to know that user pressed power button (so it can do
>shutdown and poweroff). Plus, it is nice to let user know that we can
>read such event. [I hunted bug for few hours, thinking that kernel
>does not get the event at all].
>
>Here's patch to do that. Please apply,

Not so hasty ;)

>+		printk ("acpi: Power button pressed!\n");
>+		kill_proc (1, SIGTERM, 1);

SIGTERM is a bad choise. Right now, init ignores SIGTERM. For
good reason; on some (many?) systems, the shutdown scripts
include "kill -15 -1; sleep 2; kill -9 -1". The "-1" means
"all processes except me". That means init will get hit with
SIGTERM occasionally during shutdown, and that might cause
weird things to happen.

Perhaps SIGUSR1 ?

Mike.

