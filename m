Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbUCHHpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 02:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUCHHpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 02:45:21 -0500
Received: from mail.tpgi.com.au ([203.12.160.58]:37085 "EHLO mail2.tpgi.com.au")
	by vger.kernel.org with ESMTP id S262423AbUCHHpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 02:45:12 -0500
Subject: Re: Some highmem pages still in use after shrink_all_memory()?
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Andy Isaacson <adi@hexapodia.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040308063639.GA20793@hexapodia.org>
References: <20040307144921.GA189@elf.ucw.cz>
	 <20040307164052.0c8a212b.akpm@osdl.org>
	 <20040308063639.GA20793@hexapodia.org>
Content-Type: text/plain
Message-Id: <1078724500.21062.7.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Mon, 08 Mar 2004 18:41:40 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-03-08 at 19:36, Andy Isaacson wrote:
> Note that there are some applications for which it is a *bug* if an
> mlocked page gets written out to magnetic media.  (gpg, for example.)
> I imagine that they'd rather lose the mapping and get a page fault on
> the next reference (which they can then fix up with a new mmap and
> mlock) than have precious key material written to disk.

For such an application, we'd have to provide a mechanism to allow an
application to set/clear a page's Nosave flag. We'd probably also want
to be able to notify user space that a suspend cycle has just occurred
and the page contents are invalid.

> However, I don't see how to implement a cryptographically secure swsusp.

It would be possible with Suspend2 - one could implement a backend (page
transformer or writer) that implemented encryption and required the user
to enter a passphrase at resume time.

> (The importance of this behavior is obviously dependent on your threat
> model.  Perhaps the Sufficiently Paranoid gpg users will simply need to
> avoid using swsusp.)

Yes. Or close all gpg apps before suspending?

Nigel

-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

