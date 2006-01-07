Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965362AbWAGAZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965362AbWAGAZX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965368AbWAGAZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:25:23 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:23315 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965362AbWAGAZX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:25:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HbZV2JO6MveSuUIH1lgwV0y/RbH0eSGzZEJYs/77y66jsV1P72bnKr9i6wZ0gC4dXaHdAdxhszkGqdd/ptMeA703B4Obx0EJ13XMzSpNad3hqb5XOUMPfWxAEtZzgGku0w0Z4oh6hh3s8yBWaHXBXNmKqpf1tHsT1vHkXMjMjkM=
Message-ID: <9a8748490601061625q14d0ac04ica527821cf246427@mail.gmail.com>
Date: Sat, 7 Jan 2006 01:25:22 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davej@codemonkey.org.uk, airlied@linux.ie
In-Reply-To: <20060105165946.1768f3d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com>
	 <20060105162714.6ad6d374.akpm@osdl.org>
	 <9a8748490601051640s5a384dddga46d8106442d10c@mail.gmail.com>
	 <20060105165946.1768f3d5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> >  Reverted that one patch, then rebuild/reinstalled the kernel
> >  (with the same .config) and booted it - no change. It still locks up
> >  in the exact same spot.
> >  X starts & runs fine (sort of) since I can play around at the kdm
> >  login screen all I want, it's only once I actually login and KDE
> >  proper starts that it locks up.
>
> Oh bugger.  No serial console/netconsole or such?
>
> Or are you able log in and then quickly do the alt-ctrl-F1 thing, see if we
> get an oops?
>
I switched to tty1 right after logging in, and after a few seconds
(corresponding pretty well with the time it takes to hit the same spot
where it crashed all previous times) I got a lot of nice crash info
scrolling by.
Actually a *lot* scrolled by, a rough guestimate says some 4-6 (maybe
more) screens scrolled by, and since the box locks up solid I couldn't
scroll up to get at the initial parts :(  So all I have for you is the
final block - hand copied from the screen using pen and paper, so
please excuse any typos I may have made :

Bad page state in process 'kded'
page:c16a39e0 flags:0x00000000 mapping:00000000 mapcount:1 count:1
Trying to fix it up, but a reboot is needed
Backtrace:
 [<c0103e77>] dump_stack+0x17/0x20
 [<c0146f89>] bad_page+0x69/0x110
 [<c01473d2>] __free_pages_ok+0x82/0xd0
 [<c014818d>] __free_pages+0x3d/0x50
 [<c02a6663>] sg_page_free+0x23/0x30
 [<c02a5913>] sg_remove_scat+0x63/0xe0
 [<c02a62fd>] __sg_remove_sfp+0x4d/0xc0
 [<c02a6417>] sg_remove_sf+0xa7/0x120
 [<c02a26d6>] sg_release+0x46/0xc0
 [<c0163637>] __fput+0x167/0x1b0
 [<c01634bb>] fput+0x3b/0x50
 [<c0161bcc>] filp_close+0x3c/0x80
 [<c0161c79>] sys_close+0x69/0x90
 [<c0103009>] syscall_call+0x7/0xb
Hexdump:
000: 00 00 00 00 ff ff ff ff ff ff ff ff 00 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 ff ff ff ff ff ff ff ff 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Hope that helps a bit even though it's the last and thus least
interresting block of info.

It never makes it to the logs, and as mentioned previously I don't
have another machine to capture on via netconsole or serial, so if you
have any good ideas as to how to capture it all, then I'm all ears.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
