Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbULEDGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbULEDGY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 22:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbULEDGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 22:06:23 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:52912 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261240AbULEDFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 22:05:53 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc3
Date: Sat, 4 Dec 2004 19:03:55 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412041903.55583.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From:       Martin Josefsson <gandalf () wlug ! westbo ! se>
> Date:       2004-12-04 21:42:11
> 
> On Sat, 4 Dec 2004, Alex Romosan wrote:
> 
> > thank you. the laptop wakes up now but i get the following when it
> > resumes (this is the output from dmesg):
> >
> > scheduling while atomic: sleepbtn.sh/0x00000001/3201
> ...
> That's an usb2.0 bug, the ehci driver sleeps when it can't sleep.

Who changed it so that context was no longer allowed to sleep???

That's a very recent change ... I've done a fair amount of testing
in previous kernels and _never_ got that message on that path.

Why was that changed?  Are you sure it's not just a bug higher up
in the call stack?  Classically(*), both suspend() and resume()
methods are called in contexts that can sleep, so that's a big
change I'd expect to impact other drivers too.  In fact that'd
explain a lot of other messages I saw reported on the list...

- Dave

(*) Since APM days if not before.
