Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbSJDXmV>; Fri, 4 Oct 2002 19:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262113AbSJDXmV>; Fri, 4 Oct 2002 19:42:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:25988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262112AbSJDXmU>;
	Fri, 4 Oct 2002 19:42:20 -0400
Date: Fri, 4 Oct 2002 16:47:10 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Matt D. Robinson" <yakker@aparity.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] LKCD for 2.5.40
In-Reply-To: <200210042303.g94N3Wo10004@nakedeye.aparity.com>
Message-ID: <Pine.LNX.4.33L2.0210041625400.20655-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2002, Matt D. Robinson wrote:

| These are the patches (9 in all) for the Linux Kernel Crash Dump
| modifications for 2.5.  This allows crash dumps to be built as a
| module in the kernel and also includes a breakdown of a few of the
| changes needed in the kernel.  The current version will allow for
| block dumping, and has the ability to readily integrate network
| dumping (a la Red Hat).

Hi Matt,

I have a few comments.

| Please accept these patches or provide feedback on how we can
| modify them for acceptance.  Thanks,

Who do you want to accept these patches?
If it's Linus, you should send them to him.

Documentation/SubmittingPatches doesn't say so, but lately it's
become quite common and desirable to use diffstat output above
patches to summarize the files modified and how much they are
modified.

Instead of replying to other patches separately, I'll add a few
comments here.

CONFIG_DUMP:  I'd prefer to see something a little bit more descriptive,
like CONFIG_CRASH_DUMP or CONFIG_DUMP_KERNEL.  Yes, this is minor.
(BTW, I don't like the shortness of CONFIG_TRACE for LTT either.  :)

Why are all of the dump_init() and secondary init functions
_not_ marked as __init ?

You shouldn't need to call dump_init() explicitly since you use
module_init(dump_init);
Oh, I see, you call dump_init() for built-into-kernel but use
#ifdef MODULE
to surround lots of MODULE_xyz() lines.
You shouldn't surround the MODULE_xyz() lines like that,
they should always be present for MODULE or not,
and you should just use the module_init(dump_init) always to
initialize.

-- 
~Randy

