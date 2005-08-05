Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262976AbVHEKpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbVHEKpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbVHEKnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:43:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:53203 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262960AbVHEKmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:42:25 -0400
Date: Fri, 5 Aug 2005 12:42:24 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: drepper@redhat.com, jakub@redhat.com, linux-kernel@vger.kernel.org,
       bert.hubert@netherlabs.nl, michael.kerrisk@gmx.net, akpm@osdl.org
MIME-Version: 1.0
References: <1118835415.22181.68.camel@hades.cambridge.redhat.com>
Subject: =?ISO-8859-1?Q?pselect()_modifying_timeout?=
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <31556.1123238544@www44.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

By the way, looking at the comments to the last version of
the pselect()/ppoll()patch, I see that the treatment of 
the timeout argument is made dependent on the personality.  

http://marc.theaimsgroup.com/?l=linux-kernel&m=111883591220436&w=2

I'm not sure that this is a good idea; my reasons as follows:

1. POSIX made the behaviour of pselect() explicit -- the 
   timeout must not be modified.  The idea was to avoid the 
   vagueness of the select() specification; it had to be vague 
   because of existing implementations. By contrast, there were 
   no pre-existing implementations when pselect() was specified.  
   (By the way, although one or two posts in the earlier thread 
   implied that pselect() has long/widely been present on 
   some systems, this is almost certainly not true.  The only 
   systems where I believe it is currently implemented are two that 
   were recently Unix 03 certified: Solaris 10 and AIX (5.3?).  I 
   know from doing quite a bit of checking that it is not present 
   as a kernel implementation on most (all?) other systems (even
   though it was already described by POSIX.1g and Richard 
   Stevens 7 years ago))  

   I haven't tested Solaris 10 and AIX, but I think one can be 
   reasonably sure that they would conform to the letter of 
   POSIX law.  Lacking any strong reason to the contrary, 
   Linux should (IMO) too (why gratuitously introduce 
   differences across implementations?).

2. The existing (non-atomic) glibc pselect() implementation 
   does not change the timeout argument.

Please consider making Linux pselect() conform to POSIX on this 
point.

Cheers,

Michael

-- 
5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
+++ GMX - die erste Adresse für Mail, Message, More +++
