Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272578AbTHKNoq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272577AbTHKNnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:43:55 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:35545
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S272587AbTHKNjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:39:44 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O13int for interactivity
Date: Mon, 11 Aug 2003 02:57:25 -0400
User-Agent: KMail/1.5
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, mingo@elte.hu,
       felipe_alfaro@linuxmail.org
References: <200308050207.18096.kernel@kolivas.org> <20030804230337.703de772.akpm@osdl.org> <200308051726.14501.kernel@kolivas.org>
In-Reply-To: <200308051726.14501.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308110257.25601.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 August 2003 03:26, Con Kolivas wrote:
> On Tue, 5 Aug 2003 16:03, Andrew Morton wrote:
> > We do prefer that TASK_UNINTERRUPTIBLE processes are woken promptly so
> > they can submit more IO and go back to sleep.  Remember that we are
> > artificially leaving the disk head idle in the expectation that the task
> > will submit more I/O.  It's pretty sad if the CPU scheduler leaves the
> > anticipated task in the doldrums for five milliseconds.
>
> Indeed that has been on my mind. This change doesn't affect how long it
> takes to wake up. It simply prevents tasks from getting full interactive
> status during the period they are doing unint. sleep.
>
> > Very early on in AS development I was playing with adding "extra boost"
> > to the anticipated-upon task, but it did appear that the stock scheduler
> > was sufficiently doing the right thing anyway.
>
> Con

It seems that there's a special case, where a task that was blocked on a read 
(either from a file or from swap) wants to be scheduled immediately, but with 
a really short timeslice.  I.E. give it the ability to submit another read 
and block on it immediately, but if a single jiffy goes by and it hasn't done 
it, it should go away.

This has nothing to do with the normal priority levels or being considered 
interactive or not.  As I said, a special case.  IO_UNBLOCKED_FLAG or some 
such.  Maybe unnecessary...

(Once again, the percentage of CPU time to devote to a task and the immediacy 
of scheduling that task are in opposition.  The "priority" abstraction is a 
bit too simple at times...)

Rob

