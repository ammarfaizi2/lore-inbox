Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVCKJNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVCKJNP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 04:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbVCKJNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 04:13:14 -0500
Received: from relay.muni.cz ([147.251.4.35]:3742 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262632AbVCKJNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 04:13:08 -0500
Date: Fri, 11 Mar 2005 10:11:42 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       javier@tudela.mad.ttd.net, linux-fbdev-devel@lists.sourceforge.net,
       acpi-devel@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] inappropriate use of in_atomic()
Message-ID: <20050311091142.GB22415@fi.muni.cz>
References: <20050310204006.48286d17.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310204006.48286d17.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
: 
: in_atomic() is not a reliable indication of whether it is currently safe
: to call schedule().
: 
: This is because the lockdepth beancounting which in_atomic() uses is only
: accumulated if CONFIG_PREEMPT=y.  in_atomic() will return false inside
: spinlocks if CONFIG_PREEMPT=n.
: 
: Consequently the use of in_atomic() in the below files is probably
: deadlocky if CONFIG_PREEMPT=n:
[...]
: 	drivers/acpi/osl.c
[...]

This may be the cause of 

http://bugme.osdl.org/show_bug.cgi?id=4150

- I have recently verified that the problem described in bug #4150 disappears
when CONFIG_PREEMPT=y is used.

-Yenya


-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
