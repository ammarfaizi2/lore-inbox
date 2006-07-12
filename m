Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWGLAZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWGLAZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWGLAZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:25:21 -0400
Received: from terminus.zytor.com ([192.83.249.54]:8128 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932294AbWGLAZU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:25:20 -0400
Message-ID: <44B44164.9020407@zytor.com>
Date: Tue, 11 Jul 2006 17:25:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain>	 <44B3EA16.1090208@zytor.com> <44B3ED3B.3010401@fr.ibm.com>	 <44B3EDBA.4090109@zytor.com>	 <a36005b50607111250k70598c31nbc9c0de661dba9e6@mail.gmail.com>	 <44B41D39.801@fr.ibm.com> <44B41EC0.70404@zytor.com> <a36005b50607111716t4756828dsafd740bfb90e6655@mail.gmail.com>
In-Reply-To: <a36005b50607111716t4756828dsafd740bfb90e6655@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> On 7/11/06, H. Peter Anvin <hpa@zytor.com> wrote:
>> > #define EXECVEF_NEWNS 0x00000100
>> > #define EXECVEF_NEWIPC        0x00000200
>> > #define EXECVEF_NEWUTS        0x00000400
>> > #define EXECVEF_NEWUSER       0x00000800
> 
> Yes on these.
> 
> 
>> If flags comes first, I would rather like to call it execfve(), or
>> perhaps execxve() ("extended") or execove() ("options").  execfve()
>> sounds like it executes a file descriptor (which would probably be
>> called fexecve()).
> 
> I think execfve is fine.
> 
> 
>> Perhaps more seriously, if we're adding more functionality already, it
>> should acquire -at functionality (execveat) and take a directory 
>> argument.
> 
> We have fexecve already.  Adding -at variants is probably not the best
> idea, it's confusing.  Note, that fexecve only takes a file
> descriptor, not a file descriptor plus file name.
> 
> The only reason I could see for changing this is thatfexecve depends
> on /proc.  But there is so much other functionality which won't work
> if /proc isn't mounted that I'd rank this low.  I'm fine with just
> adding execfve.

It seems to me to make a lot of sense to make it execveat(), then.  That 
way it would provide the equivalent functionality of both execve() and 
fexecve(), plus additional functionality.

	-hpa
