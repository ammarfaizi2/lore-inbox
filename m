Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTDEBMP (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbTDEBMP (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:12:15 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:11782
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261651AbTDEBML 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 20:12:11 -0500
Subject: Re: [PATCH] New cpu macro and i386 cleanup
From: Robert Love <rml@tech9.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200304041931_MC3-1-3308-9B07@compuserve.com>
References: <200304041931_MC3-1-3308-9B07@compuserve.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049504699.753.128.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 04 Apr 2003 20:05:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-04 at 19:29, Chuck Ebbert wrote:
>  This annoyed me just enough to try and fix it.  I'd
> fix all the rest but I know how annoyed people get at
> massive changes:

I like, although I am not hot on the name, but that is just taste.

One minor nit: it is not preempt-safe.  But then again, neither is any
code that calls it without disabling preemption first.  Maybe put a
comment above it like:

	/*
	 * is_current_cpu() - are we running on the given processor?
	 *
	 * Note this is not preempt-safe: you need to explicitly
	 * disable preemption before calling this if you care
	 * about any consistency in the result
	 */

The problem is not so much the call itself, but the use of the results. 
Anywhere you care that 'cpu' is the current processor, kernel preemption
needs to remain disabled.

	Robert Love

