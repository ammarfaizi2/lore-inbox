Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbRFVI30>; Fri, 22 Jun 2001 04:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265374AbRFVI3G>; Fri, 22 Jun 2001 04:29:06 -0400
Received: from mailimailo.univ-rennes1.fr ([129.20.131.1]:24467 "EHLO
	mailimailo.univ-rennes1.fr") by vger.kernel.org with ESMTP
	id <S265373AbRFVI3C>; Fri, 22 Jun 2001 04:29:02 -0400
Date: Fri, 22 Jun 2001 12:47:50 +0200 (CEST)
From: Thomas Speck <Thomas.Speck@univ-rennes1.fr>
To: linux-kernel@vger.kernel.org
Subject: problem with select() - 2.4.5
In-Reply-To: <993069751.10191.0.camel@agate>
Message-ID: <Pine.LNX.4.21.0106221233540.11061-100000@pc-astro.spm.univ-rennes1.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !
I have a problem with reading from a serial port using select() under
2.4.5. What I am doing is basically the following: 

fd_set readfds;
struct timeval timeout;
int s;

serialfd = open("/dev/ttyS0", O_RDWR );

init_serial(B9600);

timeout.tv_sec = 2; /* ! */
timeout.tv_usec = 0;
FD_ZERO(&readfds);
FD_SET(serialfd,&readfds);

s=select(serialfd+1, &readfds, NULL, NULL, &timeout);
...

But s is always equal to 0 even when I am sure there are data to read.
If I use 

s=select(serialfd+1, NULL, &writefds, NULL,  &timeout);

(with the corresponding initialisation of writefds) it returns s=1 and I
can write to the serial port. I can see that since the lights of the modem
are flashing. 
I noticed that behavior since I tried to send some "ATZ" with the
write-function but I never got the "OK" back.

However, the same programme works under 2.2.19.

Any help, please ?

--
Thomas

