Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbTHSUEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbTHSUD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:03:28 -0400
Received: from mail.webmaster.com ([216.152.64.131]:60288 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261462AbTHSUBa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:01:30 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: Tue, 19 Aug 2003 13:01:26 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCENJFDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <3F427BE0.2040306@zytor.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Correction...
>
> _exit(2).
>
> There is no exit(2); I was talking about _exit(2) and you're talking
> about exit(3).
>
> _exit(2) *is* guaranteed to terminate a process immediately.
>
> 	-hpa

	If only it was so! I have direct practical experience that under
LinuxThreads, at least, it doesn't. SuSv3 allows _exit to flush open streams
and remove temporary files. Sadly, _exit, on many systems, acquire locks or
accesses process structures that might be corrupt whereas dereferencing a
NULL pointer does not.

	I have portable code that has a 'terminate this process immediately'
function. It started out calling '_exit' until we found platforms where that
resulted in a hang (say the thread calling _exit holds a non-recursive mutex
that the _exit function tries to acquire). So we kept inching our way up to
more and more extreme termination methods.

	DS


