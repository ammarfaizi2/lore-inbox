Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275583AbTHSGy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275592AbTHSGy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:54:56 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:1287 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S275583AbTHSGyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:54:54 -0400
Message-Id: <200308190654.h7J6sIL07040@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "David Schwartz" <davids@webmaster.com>,
       "Mike Fedyk" <mfedyk@matchmail.com>,
       "Hank Leininger" <hlein@progressive-comp.com>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: Tue, 19 Aug 2003 09:54:17 +0300
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKIEFLFDAA.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEFLFDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 August 2003 01:39, David Schwartz wrote:
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

I disagree. _exit(2) is the most sensible way to terminate.

Logginh kernel-induced SEGVs and ILLs are definitely a help when you hunt
daemons mysteriously crashing. This outweighs DoS hazard.
--
vda
