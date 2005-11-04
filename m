Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbVKDETJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbVKDETJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030601AbVKDETI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:19:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43189 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030599AbVKDETH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:19:07 -0500
Date: Thu, 3 Nov 2005 23:19:02 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
Subject: Re: [PATCH] I8K: convert to seqfile
Message-ID: <20051104041902.GA23618@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dmitry Torokhov <dtor@mail.ru>
References: <200506260103.j5Q13ovn020970@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506260103.j5Q13ovn020970@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 06:03:50PM -0700, Linux Kernel wrote:
 > tree e76bf5589246831604130349ae67b30b998deb29
 > parent e70c9d5e61c6cb2272c866fc1303e62975006752
 > author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 26 Jun 2005 04:54:26 -0700
 > committer Linus Torvalds <torvalds@ppc970.osdl.org> Sun, 26 Jun 2005 06:24:24 -0700
 > 
 > [PATCH] I8K: convert to seqfile
 > 
 > I8K: Change proc code to use seq_file.
 > 
 > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
 > Signed-off-by: Andrew Morton <akpm@osdl.org>
 > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
 > 
 >  drivers/char/i8k.c |   64 ++++++++++++++++++-----------------------------------
 >  1 files changed, 22 insertions(+), 42 deletions(-)

This took a while to notice somehow, but one of our Fedora users
upgraded from a 2.6.12 kernel to 2.6.14 today, and noticed
that his gkrellm segfaulted[1].

The reason is that we've subtley changed the format of /proc/i8k

Before:
1.0 A38 ? 54 -22 1 -22 79260 -1 2

After:
1.0 A38  52 -22 1 -22 77340 -1 2


The missing '?' field is puzzling though. Looking at the diff,
this should work.  Is this a shortfalling of seq_file perhaps ?

		Dave

[1] The i8k plugin for that thing is hurrendous btw, don't
look at it with a weak stomach. It does no sanity checking
on arguments at all, and assumes things will stay constant.
Little wonder it blows up when it runs out of things to strcpy()

