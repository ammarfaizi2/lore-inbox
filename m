Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTJVO5W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 10:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTJVO5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 10:57:22 -0400
Received: from holomorphy.com ([66.224.33.161]:7572 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263436AbTJVO5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 10:57:21 -0400
Date: Wed, 22 Oct 2003 07:57:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Sylvain Jeaugey <sylvain.jeaugey@bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: (1/4) [PATCH] cpuset -- 2.6.0-test8
Message-ID: <20031022145711.GC1108@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Simon Derr <Simon.Derr@bull.net>,
	Stephen Hemminger <shemminger@osdl.org>,
	Sylvain Jeaugey <sylvain.jeaugey@bull.net>,
	linux-kernel@vger.kernel.org
References: <Pine.A41.4.53.0310131503500.173334@isabelle.frec.bull.fr> <20031021162019.7089cee4.shemminger@osdl.org> <20031022000808.GA14431@holomorphy.com> <Pine.A41.4.53.0310221620420.139942@isabelle.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.A41.4.53.0310221620420.139942@isabelle.frec.bull.fr>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003, William Lee Irwin III wrote:
>> Best not to insist NR_CPUS % BITS_PER_LONG == 0.

On Wed, Oct 22, 2003 at 04:34:21PM +0200, Simon Derr wrote:
> Actually we don't, but you're right, NR_CPUS should definately be used
> here.

The insistence mentioned was implicit, of course.


On Tue, 21 Oct 2003, William Lee Irwin III wrote:
>> Unfair rwlocks can take boxen out when abused by quadratic algorithms.

On Wed, Oct 22, 2003 at 04:34:21PM +0200, Simon Derr wrote:
> I don't see exactly which lock you are talking about here ?
> Anyway, the current state of the cpusets is OK for a 'gentle' use. I'm
> sure some improvements are needed to protect it from 'evil' users ;-)

tasklist_lock, infamous for setting off the NMI oopser (i.e. watchdogs
that panic machines when interrupts are ignored for long periods of
time) when users run many instances of top(1) or other nonsense. Not
a performance concern per se, but it may very well be hopeless anyway.

There are several threads about the rwlock algorithms being unfair and
taking out machines and/or persistently starving writers. Probably the
most recent one was started by Kevin van Maren. There Linus suggested
eventually adding a fair rwlock primitive to address this.


-- wli
