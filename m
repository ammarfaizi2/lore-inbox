Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281265AbRKHB7k>; Wed, 7 Nov 2001 20:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281267AbRKHB7b>; Wed, 7 Nov 2001 20:59:31 -0500
Received: from smtp2.libero.it ([193.70.192.52]:34993 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S281265AbRKHB7Q>;
	Wed, 7 Nov 2001 20:59:16 -0500
Date: Thu, 8 Nov 2001 02:51:13 +0100
From: antirez <antirez@invece.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: antirez <antirez@invece.org>, David Ford <david@blue-labs.org>,
        "Brenneke, Matthew Jeffrey (UMR-Student)" <mbrennek@umr.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Yet another design for /proc. Or actually /kernel.
Message-ID: <20011108025113.F568@blu>
Reply-To: antirez <antirez@invece.org>
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu> <20011108012051.C568@blu> <3BE9D7BD.7030308@blue-labs.org> <20011108021057.E568@blu> <3BE9DF48.20802@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BE9DF48.20802@zytor.com>; from hpa@zytor.com on Wed, Nov 07, 2001 at 05:26:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 05:26:32PM -0800, H. Peter Anvin wrote:
> > About the complexity. It only "looks" complex. But from the
> > machine point of view it's very simple to parse.
> > Note that the strong advantage of this isn't the quoting,
> > you can quote anyway in 1000 different ways. The advantage
> > is that data is structured and parsing does not rely on
> > spaces or newlines, but just on ().
> > With this syntax you can express data as complex and structured
> > as you want but the parsing is still simple.
> > 
> 
> 
> You just changed spaces and newlines to ( and ) -- it doesn't really solve
> anything unless you want three levels of nesting or more; in which case
> you have *WAY* too much data in a single proc item.
> 
> 	-hpa

There are anyway different ways to output the same data, and yes,
probably spaces/tabs/newlines are more human readable, but I think
the right solution isn't something that limits a-priori the
complexity of the output. This will make developers more prone
to invent their own formats for special stuff. the lisp-like way
allows you to automagically put a description of the format with
little efforts, simple parsing, unlimited complexity.
Maybe you want limited complexity, but the format isn't your limit
anyway.

About the two level of nesting, take a look at /proc/net/netstat.
it's not very clear, but in lisp-like it can be translated to:

((TcpExt)((SyncookiesSent)(0)))

and so on. For every kind of proc output you can find today, there
is a good way to convert it in that format, that is at the same
time used by all the entries. I think you will hardly get the same
with space/tabs/newlines without to indirectly use it like (), that
will probably result in something of more complex to generate/parse.

I can't see any strong reason to adopt a format that will for sure
fail at some time in the future.

BTW I see that the idea isn't well accepted, so I'll be quiet ;)

Regards,
Salvatore
