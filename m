Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264896AbUGMLLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbUGMLLD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 07:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264897AbUGMLLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 07:11:03 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:8351 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S264896AbUGMLKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 07:10:51 -0400
Message-ID: <008501c468d2$405d8c70$161b14ac@boromir>
From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>,
       "Paul Davis" <paul@linuxaudiosystems.com>
Cc: <florin@sgi.com>, <linux-kernel@vger.kernel.org>,
       <linux-audio-dev@music.columbia.edu>, <albert@users.sourceforge.net>
References: <1089665153.1231.88.camel@cube><200407122354.i6CNsNqS003382@localhost.localdomain> <20040712172458.2659db52.akpm@osdl.org>
Subject: Re: [linux-audio-dev] Re: desktop and multimedia as an afterthought?
Date: Tue, 13 Jul 2004 13:09:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> Please double-check that there are no priority inversion problems and that
> the application is correctly setting the scheduling policy and that it is
> mlocking everything appropriately.

I don't think it is currently possible to have cooperating threads with
different priorities without priority inversion when using a mutex to
serialize access to shared data; and using a mutex is in fact the only portable
way to do that...

Thus, the fact that Linux does not support protocols to prevent priority
inversion (please correct me if I am wrong) kind of suggests that supporting
realtime applications is not considered very important.

It is often heard in the Linux audio community that mutexes are not realtime
safe and a lock-free ringbuffer should be used instead. Using such a lock-free
ringbuffer requires non-standard atomic integer operations and does not
guarantee memory synchronization (and should probably not perform
significantly better than a decent mutex implementation) and is thus not
portable.

--ms


