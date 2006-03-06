Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWCFQ2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWCFQ2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWCFQ2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:28:22 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:23759 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751047AbWCFQ2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:28:22 -0500
Subject: Re: sysctls inside containers
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, serue@us.ibm.com,
       frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>
In-Reply-To: <m1veuucxnv.fsf@ebiederm.dsl.xmission.com>
References: <43F9E411.1060305@sw.ru>
	 <m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>
	 <1141062132.8697.161.camel@localhost.localdomain>
	 <m1ek1owllf.fsf@ebiederm.dsl.xmission.com>
	 <1141442246.9274.14.camel@localhost.localdomain>
	 <m1veuucxnv.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 08:27:16 -0800
Message-Id: <1141662436.9274.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-04 at 03:27 -0700, Eric W. Biederman wrote:
> > I don't see an immediately clear solution on how to containerize sysctls
> > properly.  The entire construct seems to be built around getting data
> > from in and out of global variables and into /proc files.
> 
> I successfully handled pid_max.  So while it is awkward you can get
> per task values in and out if sysctl. 

This:

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/ebiederm/linux-2.6-ns.git;a=commitdiff;h=1150082e0bae41a3621043b4c5ce15e9112884fa

sir, is a hack :)

We can't possibly do that for each and every sysctl variable.  It would
mean about fourteen billion duplicated _conv() functions. 

I'm wondering if, instead of having the .data field in that table, we
can have a function pointer which, when called, gives a pointer to the
data.  I'll give it a shot.

-- Dave

