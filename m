Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275220AbTHRWoN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275221AbTHRWoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:44:13 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6414
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S275220AbTHRWoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:44:12 -0400
Date: Mon, 18 Aug 2003 15:44:10 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: David Schwartz <davids@webmaster.com>
Cc: Hank Leininger <hlein@progressive-comp.com>, linux-kernel@vger.kernel.org
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Message-ID: <20030818224409.GJ10320@matchmail.com>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	Hank Leininger <hlein@progressive-comp.com>,
	linux-kernel@vger.kernel.org
References: <20030818210238.GG10320@matchmail.com> <MDEHLPKNGKAHNMBLJOLKIEFLFDAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEFLFDAA.davids@webmaster.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 03:39:15PM -0700, David Schwartz wrote:
> 
> > And why not just catch the ones sent from the kernel?  That's the one that
> > is killing the program because it crashed, and that's the one the
> > origional
> > poster wants logged...
> 
> 	Because sometimes a program wants to terminate. And it is perfectly legal
> for a programmer who needs to terminate his program as quickly as possible
> to do this:
> 
> char *j=NULL;
> signal(SIGSEGV, SIG_DFL);
> *j++;
> 
> 	This is a perfectly sensible thing for a program to do with well-defined
> semantics. If a program wants to create a child every minute like this and
> kill it, that's perfectly fine. We should be able to do that in the default
> configuration without a sysadmin complaining that we're DoSing his syslogs.

Are you saying that a signal requested from userspace uses the same code
path as the signal sent when a process has overstepped its bounds?

Surely some flag can be set so that we know the kernel is killing it because
it did something illegal...
