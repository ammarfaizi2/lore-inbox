Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129860AbRAZLr7>; Fri, 26 Jan 2001 06:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAZLru>; Fri, 26 Jan 2001 06:47:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52624 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129396AbRAZLri>;
	Fri, 26 Jan 2001 06:47:38 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14961.25502.797308.994383@pizda.ninka.net>
Date: Fri, 26 Jan 2001 03:46:38 -0800 (PST)
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: Sasi Peter <sape@iq.rulez.org>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <20010126171014.B18463@linuxcare.com>
In-Reply-To: <20010125212033.E14807@linuxcare.com>
	<Pine.LNX.4.30.0101251157400.5377-100000@iq.rulez.org>
	<20010126171014.B18463@linuxcare.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anton Blanchard writes:
 > diff -u -u -r1.257 reply.c
 > --- source/smbd/reply.c	2001/01/24 19:34:53	1.257
 > +++ source/smbd/reply.c	2001/01/26 05:38:53
 > @@ -2383,6 +2391,51 @@
 ...
 > +    while(nread) {
 > +    	int nwritten;
 > +	nwritten = sendfile(smbd_server_fd(), fsp->fd, &tmpoffset, nread);
 > +	if (nwritten == -1)
 > +	  DEBUG(0,("reply_read_and_X: sendfile ERROR!\n"));
 > +
 > +	if (!nwritten)
 > +		break;
 > +
 > +	nread -= nwritten;
 > +    }
 > +
 > +    return -1;

Anton, why are you always returning -1 (which means error for the
smb_message[] array functions) when using sendfile?

Aren't you supposed to return the number of bytes output or
something like this?

I'm probably missing something subtle here, so just let me
know what I missed.

Thanks.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
