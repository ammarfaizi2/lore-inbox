Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWHODaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWHODaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 23:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbWHODaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 23:30:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36269 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750974AbWHODaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 23:30:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
       chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
References: <20060730011338.GA31695@sergelap.austin.ibm.com>
	<20060814220651.GA7726@sergelap.austin.ibm.com>
	<m1r6zirgst.fsf@ebiederm.dsl.xmission.com>
	<20060815020647.GB16220@sergelap.austin.ibm.com>
Date: Mon, 14 Aug 2006 21:29:53 -0600
In-Reply-To: <20060815020647.GB16220@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Mon, 14 Aug 2006 21:06:47 -0500")
Message-ID: <m13bbyr80e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> In fact my version knowingly ignores CAP_AUDIT_WRITE and
> CAP_AUDIT_CONTROL (because on my little test .iso they didn't exist).
> So a version number may make sense.
>
>> So we need some for of
>> forward/backward compatibility.  Maybe in the cap name?
>
> You mean as in use 'security.capability_v32" for the xattr name?
> Or do you really mean add a cap name to the structure?

I was thinking the xattr name.  But mostly I was looking
for a place where you had possibly stashed a version.

Thinking about it possibly the most portable thing to do
is to assign each cap a well known name.  Say
"security.cap.dac_override" and have a value in there like +1  
add the cap -1 clear the cap.  That at least seems to provide
granularity and some measure of future proofing and some measure of
portability.  The space it would take with those names looks ugly
though.

The practical question is what do you do with a program that
was give a set of capabilities you no longer support? 
Do you run it without any capabilities at all?
Do you give it as many capabilities of what it asked for
   as you can?
Do you complain loudly and refuse to execute it at all?

What is the secure choice that least violates the principle of least surprise?

Eric
