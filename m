Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275219AbTHRWjW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275234AbTHRWjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:39:22 -0400
Received: from mail.webmaster.com ([216.152.64.131]:55515 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S275219AbTHRWjV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:39:21 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Mike Fedyk" <mfedyk@matchmail.com>,
       "Hank Leininger" <hlein@progressive-comp.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: Mon, 18 Aug 2003 15:39:15 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEFLFDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030818210238.GG10320@matchmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And why not just catch the ones sent from the kernel?  That's the one that
> is killing the program because it crashed, and that's the one the
> origional
> poster wants logged...

	Because sometimes a program wants to terminate. And it is perfectly legal
for a programmer who needs to terminate his program as quickly as possible
to do this:

char *j=NULL;
signal(SIGSEGV, SIG_DFL);
*j++;

	This is a perfectly sensible thing for a program to do with well-defined
semantics. If a program wants to create a child every minute like this and
kill it, that's perfectly fine. We should be able to do that in the default
configuration without a sysadmin complaining that we're DoSing his syslogs.

	DS



