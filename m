Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVGQLSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVGQLSR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 07:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVGQLSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 07:18:17 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:34255 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261249AbVGQLSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 07:18:15 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux v2.6.13-rc3
Date: Sun, 17 Jul 2005 13:18:54 +0200
User-Agent: KMail/1.7.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507171318.54723.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 July 2005 07:05, Linus Torvalds wrote:
> Yes,
>  it's _really_ -rc3 this time, never mind the confusion with the commit
> message last time (when the Makefile clearly said -rc2, but my over-eager
> fingers had typed in a commit message saying -rc3).
>
> There's a bit more changes here than I would like, but I'm putting my foot
> down now. Not only are a lot of people going to be gone next week for LKS
> and OLS, but we've gotten enough stuff for 2.6.13, and we need to calm
> down.
>
> Admittedly the diff looks a bit bigger than it really conceptually is,
> partly due to the hwmon drivers moving around, partly due to re-indenting
> reiserfs. No real changes, but huge diffs in both cases.

Hi Linus,

I get several warnings like the one below when building with gcc4.0. 

net/ipv4/netfilter/ip_conntrack_core.c: In function 'ip_conntrack_in':
net/ipv4/netfilter/ip_conntrack_core.c:612: warning: 'set_reply' may be used 
uninitialized in this function

The trivial patch below fixes it:

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>

--- net/ipv4/netfilter/ip_conntrack_core.c.orig	2005-07-17 13:14:21.000000000 
+0200
+++ net/ipv4/netfilter/ip_conntrack_core.c	2005-07-17 13:14:57.000000000 +0200
@@ -609,7 +609,7 @@ unsigned int ip_conntrack_in(unsigned in
 	struct ip_conntrack *ct;
 	enum ip_conntrack_info ctinfo;
 	struct ip_conntrack_protocol *proto;
-	int set_reply;
+	int set_reply = 0;
 	int ret;
 
 	/* Previously seen (loopback or untracked)?  Ignore. */


However, being so trivial, is it at all worth it fixing them or should I just 
ignore them?
