Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWESJG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWESJG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 05:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWESJG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 05:06:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1192 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751143AbWESJG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 05:06:58 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       xemul@sw.ru, haveblue@us.ibm.com, akpm@osdl.org, clg@fr.ibm.com
Subject: Re: [PATCH 4/9] namespaces: utsname: switch to using uts namespaces
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518154936.GE28344@sergelap.austin.ibm.com>
	<20060518170234.07c8fe4c.rdunlap@xenotime.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 19 May 2006 03:05:23 -0600
In-Reply-To: <20060518170234.07c8fe4c.rdunlap@xenotime.net> (Randy Dunlap's
 message of "Thu, 18 May 2006 17:02:34 -0700")
Message-ID: <m1lksy1j1o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> On Thu, 18 May 2006 10:49:36 -0500 Serge E. Hallyn wrote:
>
>> Replace references to system_utsname to the per-process uts namespace
>> where appropriate.  This includes things like uname.
>> 
>> Changes: Per Eric Biederman's comments, use the per-process uts namespace
>> 	for ELF_PLATFORM, sunrpc, and parts of net/ipv4/ipconfig.c
>> 
>> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

>
> OK, here's my big comment/question.  I want to see <nodename> increased to
> 256 bytes (per current POSIX), so each field of struct <variant>_utsname
> needs be copied individually (I think) instead of doing a single
> struct copy.

Where is it specified?  Looking at the spec as SUSV3 I don't see a size
specified for nodename.

> I've been working on this for the past few weeks (among other
> things).  Sorry about the timing.
> I could send patches for this against mainline in a few days,
> but I'll be glad to listen to how it would be easiest for all of us
> to handle.
>
> I'm probably a little over half done with my patches.
> They will end up adding a lib/utsname.c that has functions for:
>   put_oldold_uname()	// to user
>   put_old_uname()	// to user
>   put_new_uname()	// to user
>   put_posix_uname()	// to user

Sounds reasonable, if we really need a 256 byte nodename.

As long as they take a pointer to the appropriate utsname
structure these patches should not fundamentally conflict.

Eric

