Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTIDN0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbTIDN0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:26:17 -0400
Received: from dub.inr.ac.ru ([193.233.7.105]:1247 "HELO dub.inr.ac.ru")
	by vger.kernel.org with SMTP id S263584AbTIDN0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 09:26:16 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200309041325.RAA15845@dub.inr.ac.ru>
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
To: nagendra_tomar@adaptec.com
Date: Thu, 4 Sep 2003 17:25:36 +0400 (MSD)
Cc: wa@almesberger.net, quade@hsnr.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0308282143330.14580-100000@localhost.localdomain> from "Nagendra Singh Tomar" at  =?ISO-8859-1?Q?=20=E1?=
	=?ISO-8859-1?Q?=D7=C7?= 28, 2003 09:55:33 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> All is fine, but the recursive tasklet problem is still there. We need 
> to add another state to tasklet TASKLET_STATE_KILLED which is set once 
> tasklet_kill is called. Once this is set tasklet_schedule just does not 
> schedule the tasklet.

Maybe. But all my past experience says me that it is some thing,
next to useless. Look, if you try to schedule some event not even caring
that the event handler is going to die, you do something really wrong.
State of death is connected not to tasklet but to source of events
which wake up the tasklet and need handling inside tasklet.
So, you just cannot tasklet_kill() before the source is shutdown and,
therefore, there are no good reasons to hold the bit inside the struct.

Alexey
