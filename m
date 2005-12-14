Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVLNMUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVLNMUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 07:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVLNMUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 07:20:14 -0500
Received: from mail.ccur.com ([66.10.65.12]:56284 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S932501AbVLNMUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 07:20:12 -0500
Subject: insufficent ptrace status when a thread calls exec
From: Tom Horsley <tom.horsley@ccur.com>
To: linux-kernel@vger.kernel.org
Cc: bugsy@ccur.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 07:20:11 -0500
Message-Id: <1134562811.25787.10.camel@tweety>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The redhat folks sent me to the kernel folks with this one:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171323

This bugzilla contains a test program that takes the (admittedly
weird) action of having a thread in a multi-threaded program
call exec() (not fork then exec, just exec :-). When a poor
old debugger is debugging this thing, most of the threads
just up and disappear, the main thread says it is about to
exit, then instead of exiting, it actually execs.

I don't believe there is enough information laying around for
any debugger to deduce what just happened and handle it
correctly. The bugzilla proposes the creation of a new
extended status so the main thread could say "I'm about to
exec on behalf of one of my threads which are all disappearing"
instead of saying "I'm about to exit" (which is a lie).

I certainly don't know enough to figure out how to actually
implement this and propose a patch, but I thought I'd at least
raise the issue with folks who probably know more about ptrace
than I do.

Thanks.

