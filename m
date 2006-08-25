Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422896AbWHYUkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422896AbWHYUkx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWHYUkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:40:53 -0400
Received: from mx.pathscale.com ([64.160.42.68]:23185 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932459AbWHYUkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:40:52 -0400
Message-ID: <44EF6053.4010006@pathscale.com>
Date: Fri, 25 Aug 2006 13:40:51 -0700
From: Robert Walsh <rjwalsh@pathscale.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] [PATCH 22 of 23] IB/ipath - print warning if
 LID not acquired within one minute
References: <1a41dc627c5a1bc2f7e9.1156530287@eng-12.pathscale.com> <adafyfktxqt.fsf@cisco.com>
In-Reply-To: <adafyfktxqt.fsf@cisco.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Roland Dreier wrote:
> 1) What makes ipath special so that we want this warning for ipath
> devices but not other IB hardware?

There's nothing special about our hardware that requires this.  We just
wanted that in there so we could direct customers to look at dmesg to
see if the warning popped up if they call with a problem.  It is useful
to have for this purpose.

> If this warning is actually
> useful, then I think it would make more sense to start a timer when
> any IB device is added, and warn if ports with a physical link don't
> become active after the timeout time.

I'd be OK with doing that, too.

> But I'm having a hard time
> seeing why we want this message in the kernel log.

It's useful when you're trying to track down problems.

> 2) You do cancel_delayed_work() but not flush_scheduled_work(), so
> it's possible for your timeout function to be running after the module
> text is gone.

OK - I'll fix this up.  Thanks for spotting it.

Regards,
 Robert.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iQEVAwUBRO9gU/zvnpzTd9fxAQJBQwgAkbgrEA4/UpbcD0gsGC+39r5ZAAz+4d3I
/QAIKn239juMf8TfrlekAzD9MCj5Rna1bk3yu1gu/Z0Jg5vHvQNmBxDtveQ4bDyu
1DAUbvmclNknzM00LtMHI6AZfYbRgsbCIKXJw0reXctAkbJAvMU0U6Ff1imvO0Tw
38C24ktDalaaKpz4DHO261UHlmtD4wlJojKLYI5yH39JSHK449zjJznrP9W8SPIU
RbxGktSsD69gQXmpqgY5KEmbcukZ9AIF4VHTG2uEz1aO7eOQ+1BsUg140EcWXC//
R1Jg56WhCYsMDVik7+u994VgQi34beos9pwbLIUkq+315VHN3QFbQg==
=XhNA
-----END PGP SIGNATURE-----
