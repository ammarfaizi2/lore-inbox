Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTFDSbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTFDSbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:31:46 -0400
Received: from sj-core-1.cisco.com ([171.71.177.237]:21189 "EHLO
	sj-core-1.cisco.com") by vger.kernel.org with ESMTP id S261785AbTFDSbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:31:45 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Linus Torvalds'" <torvalds@transmeta.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'P. Benie'" <pjb1008@eng.cam.ac.uk>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [2.5] Non-blocking write can block
Date: Wed, 4 Jun 2003 11:44:26 -0700
Organization: Cisco Systems
Message-ID: <01b601c32ac9$52f002c0$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0306041019570.14465-100000@home.transmeta.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@transmeta.com] 
> Sent: Wednesday, June 04, 2003 10:42 AM
> To: Hua Zhong
> Cc: 'Christoph Hellwig'; 'P. Benie'; 'Kernel Mailing List'
> Subject: RE: [PATCH] [2.5] Non-blocking write can block
> 
> 
> 
> On Wed, 4 Jun 2003, Hua Zhong wrote:
> >
> > We ran into this problem here in an embedded environment. It causes
> > syslogd to hang and when this happens, everybody who talks to
syslogd
> > hangs. Which means you may not even be able to login. In the end we 
> > used exactly the same fix which seems to work.
> > 
> > I am curious to know the correct fix.
> 
> [ First off: your embedded syslog problem is fixed by making sure that
>   syslog doesn't try to write to a tty that somebody else might be
>   blocked. In other words, to me it sounds like a "well, don't do that
>   then" schenario, rather than a real kernel problem. ]

It's hard. The shell might be printing and you cannot prevent that.
 
That said, the main problem was somebody could be stuck in waiting for
tty *forever* and thus everyone who tries to write also hangs.

This particular patch is in 2.4.20 already. There is another patch in
2.4.20 (?) which seems to fix the "main problem" (the n_tty_write_wakeup
function in n_tty.c), but I didn't verify it.

