Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWDTPam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWDTPam (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWDTPam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:30:42 -0400
Received: from spirit.analogic.com ([204.178.40.4]:3844 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751023AbWDTPal convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:30:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <4447A19E.9000008@gmail.com>
x-originalarrivaltime: 20 Apr 2006 15:30:40.0611 (UTC) FILETIME=[61890B30:01C6648F]
Content-class: urn:content-classes:message
Subject: Re: Which process is associated with process ID 0 (swapper)
Date: Thu, 20 Apr 2006 11:30:40 -0400
Message-ID: <Pine.LNX.4.61.0604201118200.5749@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Which process is associated with process ID 0 (swapper)
Thread-Index: AcZkj2Gj/bsia80JQ62xzVT2/78+Hg==
References: <4447A19E.9000008@gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Mikado" <mikado4vn@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Apr 2006, Mikado wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> When a process make a connection to one server, if the server doesn't
> respond, the swapper process (PID 0) will re-send SYN packet
> automatically. How can I know which socket/process that re-sent SYN
> packet belongs to.
>
> Thanks in advance,
> Mikado.

This must be a trick question. Linux is not VAX/VMS. There is no
swapper process. Check in /proc. Processes start at 1. Even
kernel threads have PIDs greater than 1.

Portions of the kernel networking code operate detached. The code
gets the CPU from a timer queue or from an interrupt. When an
connection is attempted, the process attempting the connection
is either waiting, with its CPU time being used, or put to
sleep, while the timer queue's CPU time is being used. The
SYN/ACK handshake is handled during this time, therefore it
is possible to find who is attempting that connection. Netstat
gets that information from /proc/net and multiple socket
calls.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
