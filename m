Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWAIRrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWAIRrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWAIRrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:47:04 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:31380 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030212AbWAIRrC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:47:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n+kRaWHn2hI38yEK0owIqwpG1gp5KZXpMhxwOo8MbHP4S2XvZMqmKjgvwC2pE9Ly8DhshOicwfeILqUuPc7PKWm3Ud7LrS3nUvgm07a9hxnqQxwuLX71p/uuOu3zOYMrRYBOiibOE5IZWb/Ayg6dT6VF8gxLC3RVMhasvtHsCwk=
Message-ID: <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com>
Date: Mon, 9 Jan 2006 18:47:01 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm2
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
In-Reply-To: <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060107052221.61d0b600.akpm@osdl.org>
	 <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 1/7/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm2/
> >
> > This should be somewhat less buggy than 2.6.15-mm1.
> >
> For some maybe. For me it's just as broken as 2.6.15-mm1 :-(
>
> I'll turn on all debug switches and try and collect some crash dumps.
> If there's anything specific you want me to try, let me know.
>

Ok, got some info.

Following Dave's theory that, given that I hit bad_page() sometimes
during the crash that might actually be the first thing I hit before
hitting BUG(), I added an infinite loop at the end of bad_page() so it
would stay on screen for me to write down - and bad_page() turns out
to actuall *be* the very first thing I hit.

Here's what bad_page printed for me :

Bad page state in process 'kded'
[<c0103e77>] dump_stack+0x17/0x20
[<c0148999>] bad_page+0x69/0x160
[<c0148e92>] __free_pages_ok+0xa2/0x120
[<c0149c7f>] __free_pages+0x2f/0x60
[<c02acb63>] sg_page_free+0x23/0x30
[<c02abdb3>] sg_remove_scat+0x63/0xe0
[<c02ac80d>] __sg_remove_sfp+0x4d/0xc0
[<c02ac927>] sg_remove_sfp+0xa7/0x120
[<c02a8b39>] sg_release+0x49/0xc0
[<c0166827>] __fput+0x167/0x1b0
[<c01666ab>] fput+0x3b/0x50
[<c0164efc>] filp_close+0x3c/0x80
[<c0164fa9>] sys_close+0x69/0x90
[<c0103009>] syscall_call+0x7/0xb
Hexdump:
000: ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00
010: 50 81 e8 c1 50 81 e8 c1 ff ff ff ff 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
040: 00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00
050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
