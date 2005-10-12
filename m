Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVJLAli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVJLAli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVJLAli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:41:38 -0400
Received: from mail29.messagelabs.com ([140.174.2.227]:37314 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S932067AbVJLAlh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:41:37 -0400
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-4.tower-29.messagelabs.com!1129077692!27480869!1
X-StarScan-Version: 5.4.15; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to aterminating (PF_EXITING) process.
Date: Tue, 11 Oct 2005 19:44:38 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F36B12E@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to aterminating (PF_EXITING) process.
Thread-Index: AcXOwaupZkdCACNjTCmBwyHnJRJ6TQAAtijg
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Linux Kernel Mail List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Oct 2005 00:44:40.0522 (UTC) FILETIME=[212AB2A0:01C5CEC6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> It seems that the signal reception in exiting process logic has
changed.
> Serial depends on the old behaviour and its difficult to see how it
> should be fixed and what else would be "correct behaviour" here.

> Alan

Hi Alan,

That's what I was wondering.
Thanks for confirming it.

Do you know if there was any particular reason why it was changed that
signals can't be delivered to an exiting process in 2.6?
Was there maybe some sort of race, and this was the best way to resolve
it?

Using "setserial" to set a timeout value to bail is just "not right".

In most cases, people do NOT want the data to be tossed away after
the timeout expires.

Imagine a printer stuck in a hardware flow control state because the
printer ran out of paper.
The user would end up losing the tail end of their print job!

Setting a infinite timeout value with setserial is also bad.
Without being able to take a 2nd+ signal, the port ends up being stuck
forever.
Only a reboot, or a reassertion of CTS would "fix" it.

Scott
