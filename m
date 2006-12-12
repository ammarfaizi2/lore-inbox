Return-Path: <linux-kernel-owner+w=401wt.eu-S1751247AbWLLMUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWLLMUP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 07:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWLLMUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 07:20:15 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:21220 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbWLLMUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 07:20:14 -0500
Message-ID: <457E9E81.9060307@tls.msk.ru>
Date: Tue, 12 Dec 2006 15:20:17 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060813)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com> <Pine.LNX.4.64.0612110741010.12500@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612110741010.12500@woody.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 11 Dec 2006, Chuck Ebbert wrote:
>> Prevent oops when an app tries to create a pipe while pipefs
>> is not mounted.
> 
> Have you actually seen this, or is this just from looking at code?
> 
> Quite frankly, if "pipe_mnt" is ever NULL, we're dead for lots of other 
> reasons. 
> 
> In fact, pipe_mnt can't be NULL. The way it is initialized is:
> 
> 	pipe_mnt = kern_mount(&pipe_fs_type);
> 
> and pipe_mnt doesn't even return NULL - it returns an error pointer, so if 
> "kern_mount()" were to have failed, pipe_mnt will be some random invalid 
> pointer that could only be tested with IS_ERR(), not by comparing against 
> NULL.

http://marc.theaimsgroup.com/?t=116510390600001&r=1&w=2

/mjt
