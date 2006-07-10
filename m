Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWGJOL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWGJOL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWGJOL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:11:58 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:6271 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030388AbWGJOL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:11:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AC0pFm1GDzZrcrJ6ZC1RzNbEqLnjYStXaJGa5GzGlZN6oABRQXE0i7dnxb/EqCZgm4TONVV7oCuAAB829ldCRt5X5uvYR7RSVDCSKCP1yOKqryPGn7fIGy5MAbdiMnhAciJpgT7VZHmQcnZOGKAJ5AOv99P6/IGUfZbIP/92ma0=
Message-ID: <44B26004.4050500@gmail.com>
Date: Mon, 10 Jul 2006 22:11:16 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: "Antonino A. Daplas" <adaplas@pol.net>, Jean Delvare <khali@linux-fr.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
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
> BTW, it's fortunate that you are maintaing it.

David Eger is the author, the last I heard from him was 2 years ago.
But I haven't received that many problem reports on cirrusfb.

However, changes that affect all drivers are my responsibility.
 
> The I2C code in cirrusfb
> uses vga_wseq() and vga_rseq(). Is it safe WRT races between I2C
> adapter code and fb code? I don't see any locking here, and both
> functions are non-atomic (write merging and posting will not break it,
> but it looks like I need a lock for concurent access).

The only register touched by the i2c code is EEPROM control (CL_SEQR8).
This is never touched by the rest of the cirrusfb code. So I don't
think concurrent access is a problem (unless the hardware has restrictions
such as no other register accesses are allowed while this register is being
accessed). 

The framebuffer layer is serialized by
acquire_console_sem()/release_console_sem(). If you think concurrent access
is a problem, you can always use that.

Tony

