Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWDXTYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWDXTYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWDXTYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:24:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:56150 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751148AbWDXTYM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:24:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kAN8tVSF/XkFJawhYGtmFrnrkc/J7upVkgJKEBvt+LIR+r8FqojhZ8901jfDv9Mm3qu7K+3KKYCZdarcxw9KoeD7s0LZ67ItaswBXSqxxKlAFgYHZYDOehWoHEeA/3u5BCatG/qTZi2YMpfuIr1ys4rNDCBRJXoNmKPuU8zZ61I=
Message-ID: <9e4733910604241224i4511ce72n918fad354cc1a9ee@mail.gmail.com>
Date: Mon, 24 Apr 2006 15:24:12 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matthew Reppert" <arashi@sacredchao.net>
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1145856489.3375.28.camel@minerva>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145851361.3375.20.camel@minerva>
	 <1145856489.3375.28.camel@minerva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/06, Matthew Reppert <arashi@sacredchao.net> wrote:
> > I've also got a Promise PDC20268 whose expansion ROM seems to have made a
> > similar move (from ff8f8000 to c6920000), but the ATA devices attached to
> > that controller seem to work fine under 2.6.17-rc2.
>
> Also, on 2.6.17-rc2, if I do a hexdump of the PCI config space for the
> RADEON 7000 via sysfs once Linux boots, it still says the ROM is located
> at ff8c0000, even though I get this message during boot:
>
> PCI: pbus will assign resource 0000:01:0c.0
> PCI: assigning resource #6 for 0000:01:0c.0 (start 0)
>   got res [c6900000:c691ffff] bus [c6900000:c691ffff] flags 7200 for BAR 6 of
> 0000:01:0c.0

To make the sysfs rom attribute work, "echo 1 >rom". Then use 'hexdump
-C rom | more' to see the ROM contents. If you get the video ROM
contents when you do this, then the ROM is where the kernel thinks it
is. If you get FFFF or some other ROM then something like X has moved
the ROM without the kernel's knowledge.  Obviously, moving ROMs
without telling the kernel is a good way to mess up your system.

If your system locks up after "echo 1 >rom" on a disk controller, then
you have one of the few disk controllers that didn't bother to
implement full address decoding for the ROM. "echo 1 >rom". should
always work for video ROMs.

Read http://people.freedesktop.org/~jonsmirl/graphics.html if you want
to know more about the evils of X and it's use of the PCI bus.

--
Jon Smirl
jonsmirl@gmail.com
