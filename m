Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265478AbRFVRe3>; Fri, 22 Jun 2001 13:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265479AbRFVReK>; Fri, 22 Jun 2001 13:34:10 -0400
Received: from mailimailo.univ-rennes1.fr ([129.20.131.1]:35828 "EHLO
	mailimailo.univ-rennes1.fr") by vger.kernel.org with ESMTP
	id <S265477AbRFVReA>; Fri, 22 Jun 2001 13:34:00 -0400
Date: Fri, 22 Jun 2001 21:53:05 +0200 (CEST)
From: Thomas Speck <Thomas.Speck@univ-rennes1.fr>
To: Thomas Speck <Thomas.Speck@univ-rennes1.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: problem with select() - 2.4.5
In-Reply-To: <Pine.LNX.4.21.0106221233540.11061-100000@pc-astro.spm.univ-rennes1.fr>
Message-ID: <Pine.LNX.4.21.0106222150090.12493-100000@pc-astro.spm.univ-rennes1.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2001, Thomas Speck wrote:

> 
> Hi !
> I have a problem with reading from a serial port using select() under
> 2.4.5. What I am doing is basically the following: 
> 
> fd_set readfds;
> struct timeval timeout;
> int s;
> 
> serialfd = open("/dev/ttyS0", O_RDWR );
> 
> init_serial(B9600);
> 
> timeout.tv_sec = 2; /* ! */
> timeout.tv_usec = 0;
> FD_ZERO(&readfds);
> FD_SET(serialfd,&readfds);
> 
> s=select(serialfd+1, &readfds, NULL, NULL, &timeout);
> ...
> 
> But s is always equal to 0 even when I am sure there are data to read.
> If I use 
> 
> s=select(serialfd+1, NULL, &writefds, NULL,  &timeout);
> 
> (with the corresponding initialisation of writefds) it returns s=1 and I
> can write to the serial port. I can see that since the lights of the modem
> are flashing. 
> I noticed that behavior since I tried to send some "ATZ" with the
> write-function but I never got the "OK" back.
> 
> However, the same programme works under 2.2.19.

Probably I should have given the init_serial() as well; So here it is:
(it is basically the one from the serial-programming-howto)

int init_serial(tcflag_t baud)
{
        struct termios tio;
        tcgetattr(serialfd,&tio);
        tio.c_cflag = baud | CLOCAL;
        tio.c_iflag = IGNPAR;
        tio.c_oflag = 0;
        tio.c_lflag = 0;
        tio.c_cc[VTIME] = 0;
        tio.c_cc[VMIN] = 1;
        tcflush(serialfd, TCIFLUSH);
        tcsetattr(serialfd,TCSANOW,&tio);
        return 0;
}

Thank you for any help
--
Thomas

