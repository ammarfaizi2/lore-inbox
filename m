Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSFZOAf>; Wed, 26 Jun 2002 10:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSFZOAe>; Wed, 26 Jun 2002 10:00:34 -0400
Received: from abricot.axialys.net ([217.146.226.10]:53240 "EHLO kiwi")
	by vger.kernel.org with ESMTP id <S316586AbSFZOAe>;
	Wed, 26 Jun 2002 10:00:34 -0400
Date: Wed, 26 Jun 2002 16:00:29 +0200
From: Nicolas Bougues <nbougues-listes@axialys.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with wait queues
Message-ID: <20020626140029.GA6310@kiwi>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	linux-kernel@vger.kernel.org
References: <20020626103243.GA4797@kiwi> <20020626105241.GA19512@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020626105241.GA19512@win.tue.nl>
User-Agent: Mutt/1.4i
Organization: Axialys Interactive http://www.axialys.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2002 at 12:52:41PM +0200, Andries Brouwer wrote:
> On Wed, Jun 26, 2002 at 12:32:43PM +0200, Nicolas Bougues wrote:
> 
> > Does anybody have any idea on what I may have done wrong, and why
> > would loadavg increase when vmstat show no activity ?
> 
> loadavg does not report what you think it reports
> 

As far as I understand, loadavg reports the average number of
processes in the TASK_RUNNING state.

What happens in my driver, I believe, is that :
- on timer interrupt, I do some stuff, and wake_up the waiting process
- then the loadavg is computed (seeing my waiting task as TASK_RUNNING)
- then the scheduler runs the task
- then the task goes immediatly back to sleep

>From this point of view, then my problem is just "cosmetic". Isn't
there a way to do things in a different order, so that I could still
get a meaningful(*) loadavg ?

(*): by meaningful, I mean representing the number of busy processes
at a random point in time.
--
Nicolas Bougues

