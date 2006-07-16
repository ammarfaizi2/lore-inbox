Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWGPGpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWGPGpU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 02:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWGPGpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 02:45:20 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:54544 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751512AbWGPGpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 02:45:19 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: close(fd) doesn't wake up read(fd) or select() in another thread
Date: Sat, 15 Jul 2006 23:44:50 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEFDNDAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
In-Reply-To: <200607141146.52908.mikell@optonline.net>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 15 Jul 2006 23:40:19 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 15 Jul 2006 23:40:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [1.] One line summary of the problem:
> 	close(fd) doesn't wake up read(fd) or select() in another thread

	If you delete a resource in one thread while another thread is using it,
anything can happen. This is as serious a bug as calling 'free' on a block
of memory while another thread is using it.

	You can never be sure the other thread was in 'read' or 'select' (as
opposed to being about to call it and then being pre-empted), so such code
will always have race conditions.

	DS


