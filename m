Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269574AbUINWQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269574AbUINWQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269553AbUINWOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:14:21 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:63367 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S267634AbUINWMI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:12:08 -0400
Date: Tue, 14 Sep 2004 18:12:04 -0400
To: Dave Jones <davej@redhat.com>, Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: offtopic: how to break huge patch into smaller independent patches?
Message-ID: <20040914221204.GA24015@fieldses.org>
References: <41474B15.8040302@nortelnetworks.com> <20040914201210.GE13788@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914201210.GE13788@redhat.com>
User-Agent: Mutt/1.5.6+20040818i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 09:12:10PM +0100, Dave Jones wrote:
> On Tue, Sep 14, 2004 at 01:48:37PM -0600, Chris Friesen wrote:
>  > 
>  > Its kind of offtopic, but I hoped that someone might have some pointers 
>  > since the kernel developers deal with so many patches.
>  > 
>  > I've been given a massive kernel patch that makes a whole bunch of 
>  > conceptually independent changes.
>  > 
>  > Does anyone have any advice on how to break it up into independent patches?
> 
> diffsplit will split it into a patch-per-file, which could be
> a good start. If you have multiple changes touching the same file
> however, things get a bit more fun, and you get to spend a lot
> of time in your favorite text editor glueing bits together.

When I've done this I've started by taking big patch P against tree T,
finding the simplest, easiest to understand change in it, writing a
small patch P_0 which makes that one change, then diffing T + P against

	T + P_0

(where "T + P_0" means "the result of applying patch P_0 to tree T").
Repeat, write a second patch P_1, and diff T + P against

	T + P_0 + P_1

So at step n+1, I find out what's left to do by diffing T + P against

	T + P_0 + ... + P_n

(where I'm actually maintaining the patches P_i using Andrew Morton's
patch scripts).

Given a tree, a big patch, and a series of little patches (more
generally, given *two* series of patches) I'd like to be able to
calculate the diff between the two quickly.  Not having any automated
way to do that makes this all more of a pain than it should be.

It seems like it shouldn't be hard to do this with some shell scripting,
but I haven't sat down and tried it yet.  I'd be interested to hear if
anyone else as.

--Bruce Fields
