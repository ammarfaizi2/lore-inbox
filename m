Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264917AbRGBQSj>; Mon, 2 Jul 2001 12:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264928AbRGBQS3>; Mon, 2 Jul 2001 12:18:29 -0400
Received: from t2.redhat.com ([199.183.24.243]:2035 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264917AbRGBQSX>; Mon, 2 Jul 2001 12:18:23 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <2703.994089456@warthog.cambridge.redhat.com> 
In-Reply-To: <2703.994089456@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: Jes Sorensen <jes@sunsite.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jul 2001 17:17:36 +0100
Message-ID: <17538.994090656@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dhowells@redhat.com said:
>  I think the second #define should be:
> 	#define res_readb(res, adr) readb(res->start+adr)
> for consistency. 

You're right that it should be consistent. But it doesn't really matter
whether we pass an offset within the resource, or whether we continue to
pass the full 'bus address'. The driver doesn't even need to care - it just
adds the register offset to whatever opaque cookie it's given as the address
of that resource anyway.

That's really an orthogonal issue. The _important_ bit is that we pass the
resource to the I/O functions, so that in the case where they're
out-of-line, they don't need to play silly buggers with the numbers they're
given just to work out which bus they should be talking to.

--
dwmw2


