Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269451AbUJLEap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbUJLEap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 00:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269453AbUJLEaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 00:30:20 -0400
Received: from mail.aknet.ru ([217.67.122.194]:44049 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S269451AbUJLEaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 00:30:12 -0400
Message-ID: <416B5085.6070907@aknet.ru>
Date: Tue, 12 Oct 2004 07:33:25 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [patch] allow write() on SOCK_PACKET sockets
References: <E1CH7o3-0004M4-00@gondolin.me.apana.org.au>
In-Reply-To: <E1CH7o3-0004M4-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert.

Herbert Xu wrote:
>> sendto(). SOCK_RAW code, in comparison, allows
>> write() after bind().
> It is counter-intuitive to allow write after bind().  AFAIK RAW
> only allows write after connect(), not bind().
I claim that SOCK_RAW allows write() after bind()
because a few days ago I changed dosemu code
to use SOCK_RAW instead of SOCK_PACKET and write()
instead of sendto(). See here:
http://cvs.sourceforge.net/viewcvs.py/dosemu/dosemu/src/dosext/net/net/libpacket.c?r1=1.4&r2=1.5&diff_format=u
http://cvs.sourceforge.net/viewcvs.py/dosemu/dosemu/src/dosext/net/net/pktnew.c?r1=1.7&r2=1.8&diff_format=u
Of course the fact that I did that for dosemu,
doesn't mean that I was doing the right thing
(so if you know it is wrong - I'll redo it)
but at least it was tested and works.
And since that works for SOCK_RAW, I don't
see any reasons for it to not work for
SOCK_PACKET. And btw, I can use read() quite
happily even with SOCK_PACKET, so why not
write()...
My patch is simply an adoption of the code
SOCK_RAW has. See af_packet.c:packet_sendmsg(),
you'll see under "if (saddr == NULL)" just the
same code as I was doing for SOCK_PACKET.

