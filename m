Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLNXpC>; Thu, 14 Dec 2000 18:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129880AbQLNXow>; Thu, 14 Dec 2000 18:44:52 -0500
Received: from [199.26.153.10] ([199.26.153.10]:41994 "EHLO fourelle.com")
	by vger.kernel.org with ESMTP id <S129423AbQLNXon>;
	Thu, 14 Dec 2000 18:44:43 -0500
Message-ID: <3A3953DB.CDA2DF4E@fourelle.com>
Date: Thu, 14 Dec 2000 15:12:27 -0800
From: Adam Scislowicz <adams@fourelle.com>
Organization: Fourelle Systems, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Non-Blocking socket (SOCK_STREAM send)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone explain why send is failing with EPIPE on the 2.4.x
kernel, while it is working with the 2.2.x kernels.

The PsuedoCode:
sock = socket(AF_INET, SOCK_STREAM, 0)
buf = fcntl(sock, F_GETFL)
fcntl(sock, F_SETFL, buf | O_NONBLOCK) // we check the SETFL return
value, it succeeds
while ((retval = connect(sock, addr, sizeof(struct sockaddr_in))) < 0)
{
  if (retval < 0) {
   if (errno != EINPROGRESS) return -1; // return failure
 }
} // the connect succeeds during first iteration with return value of 0.

send(sock, msg, msg_length, 0) // this connection is to the thttpd web
server on the same host. XXX
XXX: send fails with EPIPE on the 2.4.0-test11-ac 4 and 2.4.0-test12
kernels, whereas it does not fail on 2.2.14-5.0(redhat kernel)

More Info:
 thttpd is working properly on the 2.4.x machine, I can access it via
Netscape, our software is a proxy.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
