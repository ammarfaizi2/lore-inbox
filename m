Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWCFS65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWCFS65 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbWCFS65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:58:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42189 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751983AbWCFS64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:58:56 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, serue@us.ibm.com,
       frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>
Subject: Re: sysctls inside containers
References: <43F9E411.1060305@sw.ru>
	<m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>
	<1141062132.8697.161.camel@localhost.localdomain>
	<m1ek1owllf.fsf@ebiederm.dsl.xmission.com>
	<1141442246.9274.14.camel@localhost.localdomain>
	<m1veuucxnv.fsf@ebiederm.dsl.xmission.com>
	<1141662436.9274.25.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Mar 2006 11:56:32 -0700
In-Reply-To: <1141662436.9274.25.camel@localhost.localdomain> (Dave Hansen's
 message of "Mon, 06 Mar 2006 08:27:16 -0800")
Message-ID: <m1zmk38krj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Sat, 2006-03-04 at 03:27 -0700, Eric W. Biederman wrote:
>> > I don't see an immediately clear solution on how to containerize sysctls
>> > properly.  The entire construct seems to be built around getting data
>> > from in and out of global variables and into /proc files.
>> 
>> I successfully handled pid_max.  So while it is awkward you can get
>> per task values in and out if sysctl. 
>
> This:
>
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/ebiederm/linux-2.6-ns.git;a=commitdiff;h=1150082e0bae41a3621043b4c5ce15e9112884fa
>
> sir, is a hack :)

I did mention awkward!

> We can't possibly do that for each and every sysctl variable.  It would
> mean about fourteen billion duplicated _conv() functions. 
>
> I'm wondering if, instead of having the .data field in that table, we
> can have a function pointer which, when called, gives a pointer to the
> data.  I'll give it a shot.

Sounds like a step in the right direction.  In the context of _conv() functions
it would also be nice if the limit checking between the sys_sysctl path and
the proc path were the same.

We definitely need some infrastructure cleanups if we are going to do much with
sysctl.

Eric
