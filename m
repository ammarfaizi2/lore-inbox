Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUBSRwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUBSRwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:52:15 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:23523 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S267445AbUBSRwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:52:14 -0500
Cc: "Andrea Arcangeli" <andrea@suse.de>,
       "Nigel Cunningham" <ncunningham@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: Reserved page flaging of 2.4 kernel memory changed recently?
References: <200402050941.34155.mhf@linuxmail.org> <20040208020624.GG31926@dualathlon.random> <200402100625.41288.mhf@linuxmail.org> <20040219072629.GB467@openzaurus.ucw.cz> <opr3l0mfdw4evsfm@smtp.pacific.net.th> <20040219161455.GC259@elf.ucw.cz> <opr3mok1ko4evsfm@smtp.pacific.net.th> <20040219173514.GD259@elf.ucw.cz>
Message-ID: <opr3mplzb44evsfm@smtp.pacific.net.th>
Date: Fri, 20 Feb 2004 01:59:49 +0800
From: "Michael Frank" <mhf@linuxmail.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040219173514.GD259@elf.ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 18:35:14 +0100, Pavel Machek <pavel@suse.cz> wrote:

> Hi!
>
>> >That means that PG_nosave | PG_reserved indeed is "PG_donttouch", but
>> >PG_nosave has slightly different meaning.
>>
>> Makes sense, but PG_reserved is used to keep VM out of these pages.
>>
>> Can we have a seperate bit PG_donttouch which is set with PG_nosave
>> | PG_reserved in reserved/video/BIOS/Broken CPU areas?
>
> Why?
>
> I do not see what is wrong with 2 separate flags... In fact, you might
> want to
>
> #define PG_donttouch (PG_reserved | PG_nosave)
>
> and (modulo atomic macros etc), it would work for everyone...
>

As your earlier post pointed out, it would not work in swsusp nosave area
which is only PG_reserved | PG_nosave.

Are we too short of bits ? ;)

What about:
  - export swsusp __nosave range for netdump override to dump __nosave page(s)

  - debugger (linked in) uses swsusp __nosave range to enable access to __nosave page(s)

Regards
Michael




