Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264951AbTFYSlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbTFYSlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:41:55 -0400
Received: from pop.gmx.de ([213.165.64.20]:58824 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264951AbTFYSlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:41:53 -0400
Message-Id: <5.2.0.9.2.20030625204242.00ceda90@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 25 Jun 2003 21:00:26 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: patch O1int for 2.5.73 - interactivity work
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <200306260209.45020.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:09 AM 6/26/2003 +1000, Con Kolivas wrote:

>I'm still working on something for the "xmms stalls if started during very
>heavy load" as a different corner case.

One way to deal with that problem would be to create a very high priority 
queue which is reserved for very light weight tasks, and heavily protected 
against them going cpu hungry.  If a forking task has a run history worthy 
of trial, slip it straight into the high priority queue... and be prepared 
to beat it into submission should it misbehave (short term run_avg ever 
exceeds X, you're outta here buddy, and if this queue is consuming more 
than Y, sorry, we're closed).

Another way would be to factor task age into the priority calculation, with 
age becoming rapidly less important.  Xmms' audio threads are light weight, 
and will quickly be able to sustain their priority.  Others would 
(hopefully) rapidly fall down where they belong.

Just a couple random thoughts, both of which I can see problems with ;-)

         -Mike 

