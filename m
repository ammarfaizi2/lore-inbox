Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280707AbRKGAEL>; Tue, 6 Nov 2001 19:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280705AbRKGAEC>; Tue, 6 Nov 2001 19:04:02 -0500
Received: from philotas.hosting.pacbell.net ([216.100.99.24]:60389 "EHLO
	philotas.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S280707AbRKGADs>; Tue, 6 Nov 2001 19:03:48 -0500
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'Roland Dreier'" <roland@topspincom.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux kernel 2.4 and TCP terminations per second.
Date: Tue, 6 Nov 2001 16:02:44 -0800
Message-ID: <018201c1671f$877cba70$3b10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <521yjb5utz.fsf@love-boat.topspincom.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not worried about SSL handshakes/sec. I am looking forward to how much
http/sec I could extract out of a moderate linux box. I have a dell box with
PIII 800 MHz, 256 MB RAM running a very light weight server (which I wrote)
and I wanted to find out how much time does it spend in system for TCP
terminations. The system in running linux kernel version 2.4.2

The server sits in a loop and launches worker threads as it receives a tcp
socket connection. The worker thread then sits in an infinite loop and
sends/receives data from client (which is again a custom client).
I figured out that most of the CPU time was spent in the kernel mode for TCP
terminatiions and Network was not the bottleneck.



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Roland Dreier
Sent: Tuesday, November 06, 2001 3:44 PM
To: imran.badr@cavium.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel 2.4 and TCP terminations per second.


    Imran> I am running openssl with apache using modssl. I will have
    Imran> to look at whether could I use openssl with TUX or zeus.

If you are doing SSL termination without a hardware crypto accelerator
then the cost of the public key operations for the SSL handshake will
far outweigh the cost of TCP termination and the webserver.  With a
typical machine (say a 1 GHz P3) I would estimate you could do 200 SSL
handshakes/sec with apache/modssl (with 95% of your CPU time spent in
OpenSSL RSA code).  With a hardware crypto accelerator you could get
up to 600-1000 handshakes/sec but the crypto will still be the
bottleneck.

Roland

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

