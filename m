Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317921AbSGWDFI>; Mon, 22 Jul 2002 23:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317924AbSGWDFI>; Mon, 22 Jul 2002 23:05:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25002 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317921AbSGWDFH>;
	Mon, 22 Jul 2002 23:05:07 -0400
Date: Mon, 22 Jul 2002 19:57:49 -0700 (PDT)
Message-Id: <20020722.195749.34129476.davem@redhat.com>
To: niemayer@isg.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: read/recv sometimes returns EAGAIN instead of EINTR on SMP
 machines
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D3BE1C2.CB89D124@isg.de>
References: <3D3BE1C2.CB89D124@isg.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Peter Niemayer <niemayer@isg.de>
   Date: Mon, 22 Jul 2002 12:43:14 +0200
   
   If one process tries to read non-blocking from a tcp socket (domain sockets work
   fine), and another process sends the reading process signals, then sometimes
   select() returns with the indication that the socket is readable,
   but the subsequent read returns EAGAIN - instead of EINTR which
   would have been the correct return code. This only happenes on SMP
   machines.

I think EAGAIN is the correct return value.  This behavior has been
there since the stone ages of TCP and I remember Alan specifically
auditing all of this stuff long ago wrt. POSIX compliance.

Can you cite some part of the POSIX spec which states that EAGAIN
cannot be returned when signals are received by a caller of
tcp_recvmsg?

   
