Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271886AbRH1TQC>; Tue, 28 Aug 2001 15:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271887AbRH1TPw>; Tue, 28 Aug 2001 15:15:52 -0400
Received: from relay02.cablecom.net ([62.2.33.102]:47374 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S271886AbRH1TPo>; Tue, 28 Aug 2001 15:15:44 -0400
Message-Id: <200108281916.f7SJG0I01130@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: ptb@it.uc3m.es
Subject: Re: does the request function block
Date: Tue, 28 Aug 2001 21:15:59 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <200108281828.UAA02042@nbd.it.uc3m.es>
In-Reply-To: <200108281828.UAA02042@nbd.it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 August 2001 20:28, you wrote:
> No they don't. NBD moves the requests to an internal queue when the
> request function is run. The function does not block. The internal
> queue is later emptied by another means, in another context.

ok - does 
	result = sock_sendmsg(sock, &msg, size);
block? something in the back of my brains sais yes, but i might be
wrong since i'm new to linux kernel programing. if it does block 
nbd blocks. it realeases the io_request_lock lock and calls 
nbd_send_req which calls nbd_xmit and that results in a call to 
sock_sendmst.

in the documention ob the brbd it sais: that the request function 
is allways called in the context of a process doing I/O the kflushd
or the kupdate kernel thread.




