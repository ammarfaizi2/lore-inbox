Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279907AbRKDM2L>; Sun, 4 Nov 2001 07:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279983AbRKDM2B>; Sun, 4 Nov 2001 07:28:01 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:23742 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S279907AbRKDM1p>; Sun, 4 Nov 2001 07:27:45 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Tim Jansen <tim@tjansen.de>
To: Jakob =?iso-8859-1?q?=D8stergaard=20?= <jakob@unthought.net>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Date: Sun, 4 Nov 2001 13:30:06 +0100
X-Mailer: KMail [version 1.3.1]
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104013951Z16981-4784+741@humbolt.nl.linux.org> <20011104030832.C26842@unthought.net>
In-Reply-To: <20011104030832.C26842@unthought.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <160MMf-1ptGtMC@fmrl05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 November 2001 03:08, Jakob Østergaard wrote:
> Now, if established files in proc could just be stable, so that they would
> not change unless non-backwards-compatible information absolutely must be
> presented, that would be a major step in the right direction.  Further, if
> we could find some acceptable compromise between human- and machine-
> readability, as has happened in the past...

The problem is that it is almost impossible to offer human-readable 
interfaces that will be backward-compatible. As soon as you have a 
well-formatted output, like /proc/partitions, you can not add a new field 
without breaking user-space applications. 
What you could do is to establish rules for files like /proc/partitions ("if 
there are more than 4 space-separated alphanumeric strings per line in 
/proc/partitions then ignore the additional fields"), but you won't find such 
a rule that is useful for every file and still offers a nice human-readable 
format. And it will be quite hard to be sure that everybody really sticks to 
these rules. Alternatively you could use a semi-human-readable format like 
XML, which several people have proposed, but it seemed like almost nobody 
liked it.

IMHO there shouldn't be any 'presentation logic' in the kernel. If you need 
the things in a human-friendly format, write a 3 line shell script:

for I in `ls -d /proc/partitions/*` ; do
	echo `cat $I/major` `cat $I/minor` `cat $I/blocks` `cat $I/name`
done

bye...

