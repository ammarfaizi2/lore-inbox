Return-Path: <linux-kernel-owner+w=401wt.eu-S1762995AbWLKRhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762995AbWLKRhr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762997AbWLKRhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:37:47 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:42524 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762995AbWLKRhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:37:45 -0500
Date: Mon, 11 Dec 2006 18:35:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Akinobu Mita <akinobu.mita@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Mark bitrevX() functions as const 
In-Reply-To: <29623.1165853572@redhat.com>
Message-ID: <Pine.LNX.4.61.0612111828550.28981@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612110803340.12500@woody.osdl.org> 
 <29447.1165840536@redhat.com>  <29623.1165853572@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > Mark the bit reversal functions as being const as they always return the
>> > same output for any given input.
>> 
>> Well, we should mark the argument const too, no?
>
>The argument is just an integer; I'm not sure that marking it const actually
>achieves anything, except to tell the function that it can't modify it - and
>since it's effectively a copy, where's the fun in that.

I can just second this. What should be marked const is [1]the things 
pointed to, not [2]the local copy of a function argument.

This[2] is what I believe almost every other software project does, 
though they often fail at [1]. Or have you seen Glibc trying to pull a
int strtoul(const char *const nptr, char **const endptr, const int 
base)? It just makes the prototypes and headers longer without having 
too much benefit. And maybe the code author may even want to reuse the 
args directly as walking pointers or countdown integers, for example.


	-`J'
-- 
