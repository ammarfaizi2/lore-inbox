Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280001AbRKDPeM>; Sun, 4 Nov 2001 10:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280011AbRKDPeD>; Sun, 4 Nov 2001 10:34:03 -0500
Received: from unthought.net ([212.97.129.24]:31448 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S280001AbRKDPd4>;
	Sun, 4 Nov 2001 10:33:56 -0500
Date: Sun, 4 Nov 2001 16:33:54 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Cc: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Tim Jansen <tim@tjansen.de>
Subject: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104163354.C14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	linux-kernel@vger.kernel.org,
	Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160MMf-1ptGtMC@fmrl05.sul.t-online.com> <20011104143631.B1162@pelks01.extern.uni-tuebingen.de> <160Nyq-2ACgt6C@fmrl07.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <160Nyq-2ACgt6C@fmrl07.sul.t-online.com>; from tim@tjansen.de on Sun, Nov 04, 2001 at 03:13:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's my stab at the problems - please comment,

We want to avoid these problems:
 1)  It is hard to parse (some) /proc files from userspace
 2)  As /proc files change, parsers must be changed in userspace

Still, we want to keep on offering
 3)  Human readable /proc files with some amount of pretty-printing
 4)  A /proc fs that can be changed as the kernel needs those changes


Taking care of (3) and (4):

Maintaining the current /proc files is very simple, and it offers the system
administrator a lot of functionality that isn't reasonable to take away now. 

       * They should stay in a form close to the current one *


Taking care of (1) and (2):

For each file "f" in /proc, there will be a ".f" file which is a
machine-readable version of "f", with the difference that it may contain extra
information that one may not want to present to the user in "f".

The dot-proc file is basically a binary encoding of Lisp (or XML), e.g. it is a
list of elements, wherein an element can itself be a list (or a character string,
or a host-native numeric type.  Thus, (key,value) pairs and lists thereof are
possible, as well as tree structures etc.

All data types are stored in the architecture-native format, and a simple
library should be sufficient to parse any dot-proc file.


So, we need a small change in procfs that does not in any way break
compatibility - and we need a few lines of C under LGPL to interface with it.

Tell me what you think - It is possible that I could do this (or something
close) in the near future, unless someone shows me the problem with the
approach.

Thank you,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
