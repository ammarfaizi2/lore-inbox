Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270494AbUJUBp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270494AbUJUBp5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270652AbUJUBky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:40:54 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:49422 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S270503AbUJUBix
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:38:53 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <cfriesen@nortelnetworks.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Wed, 20 Oct 2004 18:38:22 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEJBPCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <41770AC6.7090604@nortelnetworks.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 20 Oct 2004 18:15:01 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 20 Oct 2004 18:15:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David Schwartz wrote:

> > 	Perhaps I missed the details, but under your proposal, how
> > do you predict
> > at 'select' time what mode the socket will be in at 'recvmsg' time?!

> Well, if you've got a blocking socket, and do a nonblocking read with
> MSG_DONTWAIT, everything works fine.  You lose a bit of
> performance, but it works.
>
> The problem case is if you create a socket, set O_NONBLOCK, do
> select, clear
> O_NONBLOCK, then do a recvmsg().
>
> I suspect it's not a very common thing to do, so my proposal
> would still help
> the vast majority of existing apps.
>
> Chris

	I think this is a reasonable thing to do. Applications that select in one
mode and then operate in another are rare, and the suggested change won't
break anything.

	DS



