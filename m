Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWGJPS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWGJPS6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbWGJPS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:18:56 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:62809 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422652AbWGJPSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:18:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=lHRWTIDtmm3844WI+/1kFDKte1cDEEwuaeL3YiaWYj70uDObG+A7x4HRSFEA1gLXVNIBwjCerRWT/N+snM9hQyiNx3kM+X+kSQQnpEr5VY/4bimYLbaQU1gGxbUX1iSGM4/kE+32N0NA85YhaSi4P1l2W8bum9HVenlOYtXz3fQ=
Message-ID: <44B26FD5.403@pol.net>
Date: Mon, 10 Jul 2006 23:18:45 +0800
From: "Antonino A. Daplas" <adaplas@pol.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>	<20060705165255.ab7f1b83.khali@linux-fr.org>	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>	<m3mzbh68g9.fsf@defiant.localdomain> <44B2398B.7040300@pol.net>	<m3ejwt65of.fsf@defiant.localdomain> <44B248E4.2020506@pol.net> <m3u05p4mkx.fsf@defiant.localdomain>
In-Reply-To: <m3u05p4mkx.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> "Antonino A. Daplas" <adaplas@pol.net> writes:
> 
>> Eventually, I'm the one who's going to maintain the code, most
>> of the drivers in the video directory are practically abandoned. 
> 
> BTW, it's fortunate that you are maintaing it. The I2C code in cirrusfb
> uses vga_wseq() and vga_rseq(). Is it safe WRT races between I2C
> adapter code and fb code? I don't see any locking here, and both
> functions are non-atomic (write merging and posting will not break it,
> but it looks like I need a lock for concurent access).

Correcting myself: vga_wseq() is not a problem in little endian machines
because the 2 single-byte writes are done with a single 2-byte write.
vga_rseq() is not safe though.

I don't know how big a problem this is, reading the i2c bus while the
video mode is changing..., but I agree that it might be worthwhile
to at least lock sequencer access.

Tony




