Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271870AbRH1S25>; Tue, 28 Aug 2001 14:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271871AbRH1S2r>; Tue, 28 Aug 2001 14:28:47 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:34319 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S271870AbRH1S2c>;
	Tue, 28 Aug 2001 14:28:32 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108281828.UAA02042@nbd.it.uc3m.es>
Subject: Re: does the request function block
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <200108281813.f7SIDjY03688@mail.swissonline.ch> "from Christian
 Widmer at Aug 28, 2001 08:13:45 pm"
To: cwidmer@iiic.ethz.ch
Date: Tue, 28 Aug 2001 20:28:30 +0200 (CEST)
CC: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christian Widmer wrote:"
> does the request function of a bock device driver to be attomic or may it 
> block? in the linux device driver 2 it says that it must be attomic and 
> may not block. that makes sense to me since it also sais that the bottom-

It may not block - it's executed by the kernel in order to empty the
queue of requests for the device, and the kernel executes it with the
io lock held. So that's that. It can return without emptying the
queue, but that's another story. It must return immediately.

> half of the driver will call the request function too. but this is not realy
> nessesery when i remove all request before releasing the io_request_lock.

?? This seems to me to be orthogonal to to your question.

> on the other side block devices like nbd or brbd do send date using a socket
> in there request function.

No they don't. NBD moves the requests to an internal queue when the
request function is run. The function does not block. The internal
queue is later emptied by another means, in another context.

> who is right and why?

Well, since the hypothesis on which the question is based is mistaken,
it's hard to say!

Peter
