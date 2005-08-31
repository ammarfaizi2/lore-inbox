Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbVHaXCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbVHaXCR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 19:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVHaXCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 19:02:17 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:45440 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932549AbVHaXCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 19:02:16 -0400
Date: Thu, 1 Sep 2005 01:01:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
cc: akpm@osdl.org, joe.korty@ccur.com, george@mvista.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: RE: FW: [RFC] A more general timeout specification
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A042B0192@orsmsx407>
Message-ID: <Pine.LNX.4.61.0509010041020.3728@scrub.home>
References: <F989B1573A3A644BAB3920FBECA4D25A042B0192@orsmsx407>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 31 Aug 2005, Perez-Gonzalez, Inaky wrote:

> >Why is that needed in a _general_ timeout API? What exactly makes it so
> >useful for everyone and not just more complex for everyone?
> 
> Because if a system call gets a timeout specification it needs to
> verify its correctness first. Instead of doing that at the point
> where it goes to sleep, that could be deep in an atomic section,
> we provide a separate function [timeout_validate()] which is the
> one you mention, to do that.
> 
> Usefulness: (see the rationale in the patch), but in a nutshell;
> most POSIX timeout specs have to be absolute in CLOCK_REALTIME
> (eg: pthread_mutex_timed_lock()). Current kernel needs the timeout
> relative, so glibc calls the kernel/however gets the time, computes
> relative times and syscalls. Race conditions, overhead...etc. 
> 
> This mechanism supports both. That's why it is more general.

Your patch basically only mentions fusyn, why does it need multiple clock 
sources? Why is not sufficient to just add a relative/absolute version, 
which convert the time at entry to kernel time?

bye, Roman
