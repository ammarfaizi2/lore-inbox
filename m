Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275822AbRJFXeW>; Sat, 6 Oct 2001 19:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275825AbRJFXeL>; Sat, 6 Oct 2001 19:34:11 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:46773 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S275822AbRJFXd4>;
	Sat, 6 Oct 2001 19:33:56 -0400
Date: Sun, 07 Oct 2001 00:34:22 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Anton Blanchard <anton@samba.org>, Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: %u-order allocation failed
Message-ID: <482899202.1002414861@[195.224.237.69]>
In-Reply-To: <Pine.LNX.3.96.1011007002406.18004A-100000@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.3.96.1011007002406.18004A-100000@artax.karlin.mff.cuni
 .cz>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, 07 October, 2001 12:31 AM +0200 Mikulas Patocka 
<mikulas@artax.karlin.mff.cuni.cz> wrote:

> Sorry, but it can be triggered by _ANY_ VM since buddy allocator was
> introduced.

Just for info, this was circa 1.0.6 :-) (patches were available
since 0.99.xxx). And before it was introduced, rather a lot
of other things would consistently fail, for instance anything
that reassembled packets whose total size was >4k. And currently
they still need that.

Kernel memory is a limited resource. Contiguous kernel memory
more so. Things that need it need to better deal with the
lack of it, esp. in transient situations (such as by working
round the absence of it, e.g. kiovec in net code, or by
causing some freeing and retrying). And, when contiguous
kernel memory is short, the allocator could do with some
intelligent page freeing to reduce fragmentation.

--
Alex Bligh
