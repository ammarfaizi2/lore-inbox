Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264003AbTDJIHt (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 04:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264006AbTDJIHt (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 04:07:49 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:41929 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264003AbTDJIHq (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 04:07:46 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: fdavis@si.rr.com, linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
Date: Thu, 10 Apr 2003 10:19:26 +0200
User-Agent: KMail/1.5
References: <3E93A958.80107@si.rr.com> <20030409190700.H19288@almesberger.net> <3E94A1B4.6020602@si.rr.com>
In-Reply-To: <3E94A1B4.6020602@si.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304101019.26134.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 10. April 2003 00:41 schrieb Frank Davis:
> How about unifying the printk text messages into a limited set of
> common/canned text statements? If that could be done, all that would be
> needed in the kernel would be a small language translation table. The
> output of the table, based on the english input and the user's language
> setting, would be sent to the administrator/user.

This is a nightmare to keep current.

> On a similar note, Andreas Dilger mentioned this suggestion earlier,
> which it seems has been echoed by others, and that might be agreeable...
>
> "My suggestion would be to add the required i18n support to klogd, so
> that kernel messages are translated as they are removed from dmesg into
> syslog. Then, like any i18n support, you build a message catalog from
> the printk strings in the kernel and have klogd do the
> lookups/translation in user space."

The strings are too variable. The kernel embeds strings into some of
its messages. There must be hints in the output about what should
be translated and what must be left alone.
Like:
<esc>xxxxxxxxDummyfs: Unknown flags for file <lit>myfile

That means that you have to parse and mangle the strings as they
are in the kernel sources: "Dummyfs: Unknown flags for file %s\n"
This is not very difficult, printk() does it already. The beauty of that
would be that "Dummyfs: Unknown flags for file" now strictly speaking
is unnecessary in the kernel image. The mangling tool can replace it
with a number which klogd can replace with the original.
However this means that kernel and 'messages file' need to be kept
in sync, like System.map currently.

Now that is not all. Klogd will not run in some cases and cannot
be assumed to always run in others. Eg klogd itself may oops or the
drive with the messages file may break down, or we might be booting.
You might remove the strings only for KERN_DEBUG and KERN_INFO
strings. That should result in space savings and translation ability.

	Regards
		Oliver

