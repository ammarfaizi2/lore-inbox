Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVDGC5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVDGC5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 22:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVDGC5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 22:57:30 -0400
Received: from webmail.topspin.com ([12.162.17.3]:6036 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261179AbVDGC50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 22:57:26 -0400
To: AsterixTheGaul <asterixthegaul@gmail.com>
Cc: Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] disable built-in modules V2
X-Message-Flag: Warning: May contain useful information
References: <20050405225747.15125.8087.59570@clementine.local>
	<54b5dbf505040618324186678a@mail.gmail.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 06 Apr 2005 19:23:30 -0700
In-Reply-To: <54b5dbf505040618324186678a@mail.gmail.com> (asterixthegaul@gmail.com's
 message of "Thu, 7 Apr 2005 07:02:53 +0530")
Message-ID: <528y3v72al.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 Apr 2005 02:23:30.0476 (UTC) FILETIME=[CA08DEC0:01C53B18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > -#define module_init(x) __initcall(x);
 > > +#define module_init(x) __initcall(x); __module_init_disable(x);
 > 
 > It would be better if there is brackets around them... like
 >
 > #define module_init(x) { __initcall(x); __module_init_disable(x); }
 >
 > then we know it wont break some code like
 > 
 > if (..)
 >  module_init(x);

This is all completely academic, since module_init() is a declaration
that won't be inside any code, but in general it's better still to use
the do { } while (0) idiom like

#define module_init(x) do { __initcall(x); __module_init_disable(x); } while (0)

so it won't break code like

	if (..)
		module_init(x);
	else
		something_else();

(Yes, that code is nonsense but if you're going to nitpick, go all the way...)

 - R.
