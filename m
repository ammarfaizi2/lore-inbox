Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267592AbSLFTlL>; Fri, 6 Dec 2002 14:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbSLFTlL>; Fri, 6 Dec 2002 14:41:11 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:63500
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267592AbSLFTlK>; Fri, 6 Dec 2002 14:41:10 -0500
Subject: Re: Detecting threads vs processes with ps or /proc
From: Robert Love <rml@tech9.net>
To: Nick LeRoy <nleroy@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200212060924.02162.nleroy@cs.wisc.edu>
References: <200212060924.02162.nleroy@cs.wisc.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1039204112.1943.2142.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 06 Dec 2002 14:48:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 10:24, Nick LeRoy wrote:

> >From what else I've read, it seems that the new threading model in 2.5/2.6 is 
> changing to a more POSIX friendly model, which will effect this answer, but 
> we're not running 2.5 and really can't force such an upgrade -- hell, right 
> now we're having problems getting a switch from 2.2 pushed through.

Yep, you should get what you want with 2.5 + NPTL.  We need to add a few
bits, though, to make it complete.

> Thanks _very_ much in advance.  I'd be tickled pink if the answer is something 
> like "just look at the foo flag in ps", or "upgrade to version 1.2.3.4 of 
> procps and do xyzzy", but my intuition tells me otherwise.

See http://tech9.net/rml/procps

and "upgrade to version 2.0.8 or later of procps" :)

It is just a heuristic, though.  A hack in fact.  We look at a process's
children and compare RSS, VM size, and the process image they are
running.  If they are the same, we label them threads.

It is the default behavior.  Flag `-m' turns it off.

See thread_group() and flag_threads().

	Robert Love

