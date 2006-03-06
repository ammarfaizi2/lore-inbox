Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751941AbWCFRI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbWCFRI0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWCFRI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:08:26 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:23260 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750745AbWCFRIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:08:25 -0500
Date: Mon, 6 Mar 2006 18:08:24 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Sam Vilain <sam@vilain.net>
Subject: Re: sysctls inside containers
Message-ID: <20060306170824.GB29885@MAIL.13thfloor.at>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
	Sam Vilain <sam@vilain.net>
References: <43F9E411.1060305@sw.ru> <m1oe0wbfed.fsf@ebiederm.dsl.xmission.com> <1141062132.8697.161.camel@localhost.localdomain> <m1ek1owllf.fsf@ebiederm.dsl.xmission.com> <1141442246.9274.14.camel@localhost.localdomain> <m1veuucxnv.fsf@ebiederm.dsl.xmission.com> <1141662436.9274.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141662436.9274.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 08:27:16AM -0800, Dave Hansen wrote:
> On Sat, 2006-03-04 at 03:27 -0700, Eric W. Biederman wrote:
> > > I don't see an immediately clear solution on how to containerize sysctls
> > > properly.  The entire construct seems to be built around getting data
> > > from in and out of global variables and into /proc files.
> > 
> > I successfully handled pid_max.  So while it is awkward you can get
> > per task values in and out if sysctl. 
> 
> This:
> 
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/ebiederm/linux-2.6-ns.git;a=commitdiff;h=1150082e0bae41a3621043b4c5ce15e9112884fa
> 
> sir, is a hack :)
> 
> We can't possibly do that for each and every sysctl variable.  It would
> mean about fourteen billion duplicated _conv() functions. 
> 
> I'm wondering if, instead of having the .data field in that table, we
> can have a function pointer which, when called, gives a pointer to the
> data.  I'll give it a shot.

something similar to this?

http://www.13thfloor.at/vserver/d_rel26/v2.1.0/split-2.6.14.4-vs2.1.0/15_2.6.14.4_virt.diff.hl

(look for virt_handler() for sysctl ops)

best,
Herbert

> -- Dave
