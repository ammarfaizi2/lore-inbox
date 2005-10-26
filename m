Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVJZVbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVJZVbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbVJZVbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:31:08 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:26160 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S964926AbVJZVbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:31:07 -0400
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Laurent riffard <laurent.riffard@free.fr>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC patch 2/3] remove pci_driver.owner and .name fields
X-Message-Flag: Warning: May contain useful information
References: <20051026204802.123045000@antares.localdomain>
	<20051026204909.576265000@antares.localdomain>
	<52vezkyoor.fsf@cisco.com> <20051026212127.GU7992@ftp.linux.org.uk>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 26 Oct 2005 14:30:59 -0700
In-Reply-To: <20051026212127.GU7992@ftp.linux.org.uk> (Al Viro's message of
 "Wed, 26 Oct 2005 22:21:27 +0100")
Message-ID: <52r7a8ynho.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 26 Oct 2005 21:31:01.0205 (UTC) FILETIME=[8FB5E050:01C5DA74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > It looks stupid in the first place - what's wrong with
    > 		.driver.name = "DAC960",
    > instead of that mess?

Unfortunately I don't think gcc 2.95 accepts that syntax.  For
example the following:

	void foo(void)
	{
		struct {
			struct {
				int y;
			} x;
		} bar = {
			.x.y = 1
		};
	}

gives

	a.c: In function `foo':
	a.c:8: unknown field `y' specified in initializer

when compiled with gcc 2.95.

I guess we could do

	.driver = { .name = "DAC960" },

but that seems silly as well.

 - R.
