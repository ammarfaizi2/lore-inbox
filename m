Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbSI2CrI>; Sat, 28 Sep 2002 22:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262385AbSI2CrI>; Sat, 28 Sep 2002 22:47:08 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:65298 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262384AbSI2CrH>; Sat, 28 Sep 2002 22:47:07 -0400
Date: Sun, 29 Sep 2002 03:52:25 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: Re: [PATCH][RFC] oprofile for 2.5.39
Message-ID: <20020929025224.GA68153@compsoc.man.ac.uk>
References: <20020929014440.GA66796@compsoc.man.ac.uk.suse.lists.linux.kernel> <p737kh5sf45.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p737kh5sf45.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 04:29:14AM +0200, Andi Kleen wrote:

> Can you explain what you need the context switch hook for ? 

Hmm, I tried to explain this in comments in the patch ...

> I don't think it's a good idea to put a hook at such a critical place.

... but I obviously didn't do a very good job.

We need a context to look up the EIP against when we process each sample
in buffer_sync.c. We could just log current at sample time along with
EIP/event, but why would it be preferrable to just logging the same
information once when it's needed ?

Basically it's a matter of :

	task_struct *
	EIP/Event
	EIP/Event
	EIP/Event
	EIP/Event
	....

versus

	task_struct */EIP/Event
	task_struct */EIP/Event
	task_struct */EIP/Event
	task_struct */EIP/Event
	task_struct */EIP/Event
	....

Where task_struct is the same as the previous entry for the vast
majority of entries.

> 2.4 oprofile worked without such a hook, no ? 

Sure, but it was ugly as hell (and worked completely differently)

regards
john

-- 
"When your name is Winner, that's it. You don't need a nickname."
	- Loser Lane
