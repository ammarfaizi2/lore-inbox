Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWFSLhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWFSLhH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 07:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWFSLhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 07:37:07 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:30212 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932355AbWFSLhF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 07:37:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 19 Jun 2006 11:37:04.0031 (UTC) FILETIME=[AFC9AAF0:01C69394]
Content-class: urn:content-classes:message
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Date: Mon, 19 Jun 2006 07:37:02 -0400
Message-ID: <Pine.LNX.4.61.0606190730070.27378@chaos.analogic.com>
In-Reply-To: <20060618212303.GD4744@bouh.residence.ens-lyon.fr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: emergency or init=/bin/sh mode and terminal signals
thread-index: AcaTlK/msT0Onc/2QhKK/Vjj0b4riQ==
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Samuel Thibault" <samuel.thibault@ens-lyon.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Jun 2006, Samuel Thibault wrote:

> Hi,
>
> There's a long-standing issue in init=/bin/sh mode: pressing control-C
> doesn't send a SIGINT to programs running on the console. The incurred
> typical pitfall is if one runs ping without a -c option... no way to
> stop it!
>
> This is because no session is set up by the kernel, and shells don't
> start sessions on their own, so that no session (hence no controlling
> tty) is set up.
>
> The attached patch sets such session and controlling tty up, which fixes
> the issue. The unfortunate effect is that init might be killed if one
> presses control-C very fast after its start.
>
> Samuel
>

I don't think this is the correct behavior. You can't allow some
terminal input to affect init. It has been the de facto standard
in Unix, that the only time one should have a controlling terminal
is after somebody logs in and owns something to control. If you want
a controlling terminal from your emergency shell, please exec /bin/login.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
