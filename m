Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276150AbRJYU3X>; Thu, 25 Oct 2001 16:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276215AbRJYU3N>; Thu, 25 Oct 2001 16:29:13 -0400
Received: from zero.aec.at ([195.3.98.22]:5133 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S276150AbRJYU3G>;
	Thu, 25 Oct 2001 16:29:06 -0400
To: Tim Hockin <thockin@sun.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: issue: deleting one IP alias deletes all
In-Reply-To: <Pine.LNX.4.31.0110251234430.32029-100000@netmonster.pakint.net> <3BD86FA9.A992FE96@sun.com>
From: Andi Kleen <ak@muc.de>
Date: 25 Oct 2001 22:29:40 +0200
In-Reply-To: Tim Hockin's message of "Thu, 25 Oct 2001 13:01:45 -0700"
Message-ID: <k21yjrea4r.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BD86FA9.A992FE96@sun.com>,
Tim Hockin <thockin@sun.com> writes:
> "Matthew G. Marsh" wrote:
>> The original thought refers to the old concept of address "class" where is
>> a "class" (think subnet) went away then there was no need (and indeed
>> incorrect) behaviour to still be able to have addresses on it. Thus when
>> the primary address is deleted you should clear all addresses within that

> I don't really think the original thought matters.  What matters is that
> the behavior is 
> a) non-obvious - you don't expect it

It's bug to bug compatibility with 2.0. If you never rename ip aliases
manually and always create the "main" device first it is actually
not too unobvious.

> b) undetectable - you can't find out which alias is "primary"

The information is actually exported to user space via the ifaddrmsg 
flags in rtnetlink, but not displayed currently by iproute2.

> c) inconsistent - some aliases act differently that other aliases

> All of these violate the principle of least surprise.  Whether it was
> intentional or not, it behaves like a nasty hack, or worse, a bug.  It is
> easily fixed, and should be.

It is an nasty hack, but needed to not void all the documentation and scripts
that rely on the old 2.0 alias behaviour.

If you want to avoid it only use ifconfig add/del or ip addr add/del..
to create aliases; never named ip aliases. They're deprecated, but
unfortunately still quite popular.

-Andi


