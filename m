Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTKZMpR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 07:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTKZMpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 07:45:17 -0500
Received: from enigma.barak.net.il ([212.150.48.99]:17604 "EHLO
	enigma.barak.net.il") by vger.kernel.org with ESMTP id S261914AbTKZMpM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 07:45:12 -0500
From: "Amir Hermelin" <amir@montilio.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PG_reserved bug
Date: Wed, 26 Nov 2003 14:45:06 +0200
Organization: Montilio
Message-ID: <003e01c3b41b$22140580$1d01a8c0@CARTMAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
In-Reply-To: <20031126101744.GJ8039@holomorphy.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, fair enough.  According to what you say, this behavior won't change in
2.6.  So, I'm still left with my second question: since I do access the
pages from several places in my module, and I want to use the refcount field
of the struct page (and not have to wrap the pages in another structure) so
I know when my page is no longer referenced, how can I make sure it's 'safe'
to not use the reserved bit?

Amir.


-----Original Message-----
From: William Lee Irwin III [mailto:wli@holomorphy.com] 
Sent: Wednesday, November 26, 2003 12:18 PM
To: Amir Hermelin
Cc: linux-kernel@vger.kernel.org
Subject: Re: PG_reserved bug


On Wed, Nov 26, 2003 at 12:09:58PM +0200, Amir Hermelin wrote:
> Hi,
> I've found a bug in the 2.4.20 kernel (might have appeared before), 
> that if the PG_reserved flag is set on a page, its reference count 
> will be incremented but won't be decremented.  This is due to the 
> wrong order of lazy if tests in __free_pages(). I have two questions:
> 1.  How do I report it?  I found no maintainer for MM in MAINTAINERS
> 2.  I'm writing a module that gets pages (via __get_free_pages) and holds
> them throughout its lifetime.  Where must I check if this page can be
taken
> from under me, without using the reserved bit?  In other words, if I want
to
> make sure the behavior is the same with or without the reserved bit, what
> must I maintain?

Reserved pages are excepted from normal reference counting rules. The
allocators of reserved pages are expected to clear reference counts
themselves before returning them to the system (if they ever do).


-- wli


