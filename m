Return-Path: <linux-kernel-owner+w=401wt.eu-S932190AbWLNJ51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWLNJ51 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWLNJ51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:57:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47241 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbWLNJ50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:57:26 -0500
Subject: Re: Executability of the stack
From: Arjan van de Ven <arjan@infradead.org>
To: Franck Pommereau <pommereau@univ-paris12.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <458118BB.5050308@univ-paris12.fr>
References: <458118BB.5050308@univ-paris12.fr>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 14 Dec 2006 10:57:24 +0100
Message-Id: <1166090244.27217.978.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 10:26 +0100, Franck Pommereau wrote:
> Dear Linux developers,
> 
> I recently discovered that the Linux kernel on 32 bits x86 processors
> reports the stack as being non-executable while it is actually
> executable (because located in the same memory segment).

this is not per se true, it depends on the capabilities of your 32 bit
x86 processor.


> # grep maps /proc/self/maps
> bfce8000-bfcfe000 rw-p bfce8000 00:00 0          [stack]

this shows that the *intent* is to have it non-executable. 
Not all x86 processors can enforce this. All modern ones do.

> Is there any reason for this situation? 

the alternative (showing effective permission) is equally confusing;
apps would see permissions they didn't set...

> Maybe it comes from sharing source code for 64 bits and 32 bits
> architectures but if so, it should be possible (and highly desirable) to
> treat 32 bits differently.

it's not a "32 bit" thing, it's an "older processors don't, newer ones
do" thing.

Can you paste your /proc/cpuinfo file here ? Maybe you have a processor
with the capability but just haven't enabled it (either in the bios or
in the kernel config)

Greetings,
   Arjan van de Ven

