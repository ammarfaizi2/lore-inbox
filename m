Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280382AbRKJPzw>; Sat, 10 Nov 2001 10:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280672AbRKJPzn>; Sat, 10 Nov 2001 10:55:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39952 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280382AbRKJPzi>; Sat, 10 Nov 2001 10:55:38 -0500
Subject: Re: [PATCH] fix loop with disabled tasklets
To: mathijs@knoware.nl (Mathijs Mohlmann)
Date: Sat, 10 Nov 2001 16:02:44 +0000 (GMT)
Cc: andrea@suse.de (Andrea Arcangeli), davem@redhat.com (David S. Miller),
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <20011110152845.8328F231A4@brand.mmohlmann.demon.nl> from "Mathijs Mohlmann" at Nov 10, 2001 04:29:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E162aai-0006kH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > queue if it remains disabled forever. tasklet_kill will deadlock on a
> > tasklet that is disabled.
> I think this is the responsability of the device driver writer (or who ever 
> uses it). AFAIK there is no defined behavior for this case. I vote for 
> removing the tasklet without it ever being run.

I don't think the semantics actually matter too much. That would be mostly
down to timing. Surely its sufficient to say something like "when
tasklet_kill returns the tasklet will not be scheduled or execute further"

Do we care if it ran ? And do we want to imply any locking properties we
might have to maintain?
