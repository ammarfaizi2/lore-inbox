Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVANGyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVANGyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 01:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVANGyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 01:54:17 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:59429 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261159AbVANGyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 01:54:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=o+/ri+9GKOQ3u/dEFLBWsYaPuyKe2WMrvNtlGaenK7bgOr1nWlktobRpDEdJCSPtupgbCWtfr+af82YZC4ozxddWmZXWueUleXcz5ABO1We/DpPFzt7IJLpgywtmSBBLEeuhNBr7XIV549Fyn6MZAf12GNr4eTLN6q2Lp+qzjmc=
Message-ID: <a36005b50501132254155a0d5a@mail.gmail.com>
Date: Thu, 13 Jan 2005 22:54:13 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: short read from /dev/urandom
In-Reply-To: <cs7mup$hgo$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E7509E.4030802@redhat.com>
	 <cs7mup$hgo$1@abraham.cs.berkeley.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005 05:56:41 +0000 (UTC), David Wagner
<daw@taverner.cs.berkeley.edu> wrote:

> True.  Arguably, the solution is to fix the documentation.

The problem is that no-short-reads behavior has been documented for a
long time and so programs might, correctly so, use

    while (read(fd, buf, sizeof buf) == -1)
      continue;

Image a program doing this.  It provides the possibility for a local
attack.  If one can determine the content of the to-be-filled buffer
before the 'read', then an attacker could limit the randomness in the
buffer after the read by sending signals to the program.

Not breaking the ABI is more important than symmetry.
