Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWAIDOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWAIDOE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWAIDOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:14:04 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:47634 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1750927AbWAIDOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:14:02 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <davidel@xmailserver.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH/RFC] POLLHUP tinkering ...
Date: Sun, 8 Jan 2006 19:13:04 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEOJJDAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060108.160802.103497642.davem@davemloft.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sun, 08 Jan 2006 19:09:58 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sun, 08 Jan 2006 19:09:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Davide Libenzi <davidel@xmailserver.org>
> Date: Sun, 8 Jan 2006 16:02:10 -0800 (PST)

> > But if and hangup happened with some data (data + FIN), they won't
> > receive any more events for the Linux poll subsystem (and epoll,
> > when using the event triggered interface), so they are forced to
> > issue an extra read() after the loop to detect the EOF
> > condition. Besides from the extra read() overhead, the code does not
> > come exactly pretty.

> The extra last read is always necessary, it's an error synchronization
> barrier.  Did you know that?

	If there is an error, an error event must be returned. An edge-triggered
interface must report every event that occurs with an indication of that
type.

> If a partial read or write hits an error, the successful amount of
> bytes read or written before the error occurred is returned.  Then any
> subsequent read or write will report the error immediately.

	If the connection closes and the edge-triggered interface does not give a
HUP indication, then it is broken.

	A HUP is not a read event and signalling a read is not sufficient.

	DS


