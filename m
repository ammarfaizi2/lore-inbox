Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVCUKfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVCUKfe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 05:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVCUKfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 05:35:34 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:42691 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261735AbVCUKeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 05:34:19 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp smp problems... [was Re: swsusp: Remove arch-specific references from generic code]
Date: Mon, 21 Mar 2005 11:34:10 +0100
User-Agent: KMail/1.7.1
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <20050316001207.GI21292@elf.ucw.cz> <200503200129.35739.rjw@sisk.pl> <20050320192422.GB1401@elf.ucw.cz>
In-Reply-To: <20050320192422.GB1401@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503211134.10431.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 20 of March 2005 20:24, Pavel Machek wrote:
> Hi!
> 
> At least part of them is caused by CONFIG_MTRR. I had to disable it on
> i386 to make it work...

Later today I'll check if that helps on x86-64.

Anyway in the meantime I have played a bit with the CPU hotplug code.
It needs some work, but looks promising.  I've changed disable_nonboot_cpus()
to use the CPU hotplug code and it seems to work.  Well, almost, because some
traces of the second CPU remain in the kernel, as some things do not work
properly (eg flush_tlb_others() is called with a mask that triggers a BUG()
in it etc.).  This should not be difficult to get fixed, however.  Strangely enough,
the processes still fail to freeze after the second CPU has been disabled
(specifically one of them, which is "syslogd").  I'm going to investigate this
more thoroughly.

Turning the second CPU back on does not work for me, but in fact I haven't
looked at it so far.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
