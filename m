Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262818AbVD2QWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbVD2QWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVD2QWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:22:13 -0400
Received: from everest.sosdg.org ([66.93.203.161]:18844 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S262818AbVD2QWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 12:22:04 -0400
From: "Coywolf Qi Hunt" <coywolf@lovecn.org>
Date: Sat, 30 Apr 2005 00:21:54 +0800
To: lxr@linux.no
Cc: lxr-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       cate@debian.org
Message-ID: <20050429162034.GA4641@lovecn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Scan-Signature: 6f14ccbb63e73e4fd43bf7eb67b490d7
X-SA-Exim-Connect-IP: 66.93.203.161
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: [patch] lxr-0.3.1 handle `_' fix
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.2 (built Tue, 12 Apr 2005 17:41:13 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

lxr-0.3.1 can not handle '_' in the Architecture variable.

Like <http://sosdg.org/~coywolf/lxr/source/include/asm-x86_64/?a=x86_64>
is wrongly shown as <http://sosdg.org/~coywolf/lxr/source/include/asm-/?a=x86_64>

This problem was brought in by the file exposure security fix some time ago iirc. 

		Coywolf

diff -pu lxr/http/lib/LXR/Config.pm.orig lxr/http/lib/LXR/Config.pm
--- lxr/http/lib/LXR/Config.pm.orig	2005-04-29 23:35:26.000000000 +0800
+++ lxr/http/lib/LXR/Config.pm	2005-04-29 23:37:28.000000000 +0800
@@ -156,7 +156,7 @@ sub varrange {
 sub varexpand {
     my ($self, $exp) = @_;
     $exp =~ s{\$\{?(\w+)\}?}{
-       $self->{variable}->{$1} =~ /^([a-zA-Z0-9\.\-]*)$/ ? $1 : ''
+       $self->{variable}->{$1} =~ /^([a-zA-Z0-9\.\-_]*)$/ ? $1 : ''
        }ge;
     return($exp);
 }
