Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131188AbRALBQU>; Thu, 11 Jan 2001 20:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbRALBQK>; Thu, 11 Jan 2001 20:16:10 -0500
Received: from linuxcare.com.au ([203.29.91.49]:54286 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131188AbRALBP7>; Thu, 11 Jan 2001 20:15:59 -0500
From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14942.23127.188103.787383@diego.linuxcare.com.au>
Date: Fri, 12 Jan 2001 12:13:59 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: ENOMEM on socket writes
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@linuxcare.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.4, and the prereleases since about early December or so, I
have been seeing rsync dying with an error "write: unable to allocate
memory".  Rsync is writing on a socket which is set non-blocking and
the write is apparently returning ENOMEM.

Is this actually a new behaviour, or just something which was possible
all along but which has been made more likely by the recent VM
changes?

>From the point of view of the application, ENOMEM is a little hard to
deal with constructively.  Select will say that the socket is
writable, so there doesn't seem to be a good way of waiting until the
write has a chance of succeeding.  About the only thing that I can see
to do is just to spin trying the write over and over - does anyone
have a better idea?

Paul.

-- 
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
