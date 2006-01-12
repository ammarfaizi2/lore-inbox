Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWALBea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWALBea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWALBe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:34:29 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:31502 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S964960AbWALBe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:34:28 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <lgb@lgb.hu>, <linux-kernel@vger.kernel.org>
Subject: RE: fork(): parent or child should run first?
Date: Wed, 11 Jan 2006 17:33:13 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKECAJFAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060111123745.GB30219@lgb.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 11 Jan 2006 17:30:07 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 11 Jan 2006 17:30:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The following problem may be simple for you, so I hope someone can answer
> here. We've got a complex software using child processes and a table
> to keep data of them together, like this:
>
> childs[n].pid=fork();
>
> where "n" is an integer contains a free "slot" in the childs struct array.
>
> I also handle SIGCHLD in the parent and signal handler  searches
> the childs
> array for the pid returned by waitpid(). However here is my problem. The
> child process can be fast, ie exits before scheduler of the kernel give
> chance the parent process to run, so storing pid into childs[n].pid in the
> parent context is not done yet. Child may exit, than scheduler
> gives control
[snip]

	There are a lot of things you should not do in a signal handler, this is
one of them. There are a lot of possible solutions. My recommendation would
be to handle the death of a child from a safe context, rather than from a
signal handler. For example, the SIGCHLD handler could just set a volatile
variable to 'true' and then the code could notice that from a safe context
and loop on 'waitpid', reaping all dead children.

	DS


