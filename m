Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUE3AYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUE3AYM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 20:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUE3AYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 20:24:12 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:57570 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261389AbUE3AYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 20:24:10 -0400
Message-ID: <40B91AD6.5070807@kegel.com>
Date: Sat, 29 May 2004 16:20:54 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: karim@opersys.com
CC: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler version
References: <40B8A161.5040306@kegel.com> <40B922D5.5090609@opersys.com>
In-Reply-To: <40B922D5.5090609@opersys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> RANT: It's really about time that someone within the GNU project took it
> upon herself to actually get the GNU toolchain to build for cross-dev
> without having to require walking-on-water talents.

Quite.  I'm heading up to the gcc summit next week to make that point
(see also http://gcc.gnu.org/ml/gcc/2004-05/msg01417.html,
which rumors that Paolo Bonzini and Nathanael Nerode are
working on detangling gcc bootstrap).

And I've been busting my ass for the last year maintaining the 'crosstool'
script so people without walking-on-water talents can build
the GNU toolchain for cross-development.  (But before Karim objects
to the concept of a canned build script, I hasten to add that
I fully agree with him that the gnu toolchain build process shouldn't
need such an ugly and fragile wrapper script around it.)

> BTW, the 2.6.6 kernel wouldn't build without the following
> modifications to the main makefile:
> AS              = $(CROSS_COMPILE)as -maltivec
> CFLAGS_KERNEL   = -maltivec
> AFLAGS_KERNEL   = -maltivec
> For some reason 3.4.0 forgets to tell AS that this CPU may have
> Altivec instructions -- there are some postings about this if
> you google around.

I think the issue is that binutils-2.15 started checking its
input more strictly, in a way that broke several apps.  Binutils
cvs has the following patch which is said to relex the check:
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/opcodes/ppc-opc.c.diff?r1=1.70&r2=1.71&cvsroot=src
That patch'll be in the next crosstool, of course.

Thanks for posting about your experiences with gcc-3.4.0
and the link to http://www.ppckernel.org, which I wasn't aware of...
- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
