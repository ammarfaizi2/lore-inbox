Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTFDRBv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbTFDRBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:01:51 -0400
Received: from sj-core-1.cisco.com ([171.71.177.237]:43957 "EHLO
	sj-core-1.cisco.com") by vger.kernel.org with ESMTP id S263665AbTFDRBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:01:49 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Linus Torvalds'" <torvalds@transmeta.com>,
       "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'P. Benie'" <pjb1008@eng.cam.ac.uk>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [2.5] Non-blocking write can block
Date: Wed, 4 Jun 2003 10:14:29 -0700
Organization: Cisco Systems
Message-ID: <019801c32abc$c233d1a0$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0306040732470.13753-100000@home.transmeta.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We ran into this problem here in an embedded environment. It causes
syslogd to hang and when this happens, everybody who talks to syslogd
hangs. Which means you may not even be able to login. In the end we used
exactly the same fix which seems to work.

I am curious to know the correct fix.

> On Wed, 4 Jun 2003, Christoph Hellwig wrote:
> > 
> > The else should be on the same line as the closing brace, else
> > the patch looks fine.
> 
> No no no, it's wrong.
> 
> If you do something like this, then you also have to teach "select()" 
> about this, otherwise you just get busy looping in applications.
> 
> In general, we shouldn't do this, unless somebody can show an 
> application 
> where it really matters. Taking internal kernel locking into 
> account for 
> "blockingness" easily gets quite complicated, and there is 
> seldom any real 
> point to it.
> 
> Remember: perfect is the enemy of good. I'll happily apply 
> the patch (if 
> it also updates the tty poll() functionality), _if_ there is some 
> real-world situation where it matters.
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

