Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWH0JsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWH0JsW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWH0JsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:48:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42430 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932069AbWH0JsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:48:21 -0400
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060827084417.918992193@goop.org>
References: <20060827084417.918992193@goop.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 27 Aug 2006 11:47:51 +0200
Message-Id: <1156672071.3034.103.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Measure performance impact.  The patch adds a segment register
>   save/restore on entry/exit to the kernel.  This expense should be
>   offset by savings in using the PDA while in the kernel, but I haven't
>   measured this yet.  Space savings are already appealing though.

this will be interesting; x86-64 has a nice instruction to help with
this; 32 bit does not... so far conventional wisdom has been that
without the instruction it's not going to be worth it.

When you're benchmarking this please use multiple CPU generations from
different vendors; I suspect this is one of those things that vary
greatly between models

> - Make it a config option?  UP systems don't need to do any of this,
>   other than having a single pre-allocated PDA.  Unfortunately, it gets
>   a bit messy to do this given the changes needed in handling %gs.


A config option for this is a mistake imo. Not every patch is worth a
config option! It's good or it's not, if it's good it should be there
always, if it's not....  Something this fundamental to the core doesn't
really have a "but it's optional" argument going for it, unlike
individual drivers or subsystems...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

