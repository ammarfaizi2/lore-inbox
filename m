Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130290AbRAOOTY>; Mon, 15 Jan 2001 09:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130325AbRAOOTP>; Mon, 15 Jan 2001 09:19:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:34690 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130290AbRAOOTA>; Mon, 15 Jan 2001 09:19:00 -0500
Date: Mon, 15 Jan 2001 09:18:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Turn OFF flow-control on a serial link??
Message-ID: <Pine.LNX.3.95.1010115090300.26657A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

When the 'console' is mapped to a serial device, i.e., /dev/ttyS0,
if a terminal, without modem control is connected, no text is displayed.

If a terminal is connected, it is often just 3-wires, i.e, RX/TX/GND.
I need to disable modem control, i.e., hardware slow-control.
It used to be that CLOCAL  was sufficient in the c_cflag member of
the termios structure.  Then a flag, CRTSCTS was put into c_cflag member
also.  I could do:

	tcgetattr(STDIN_FILENO, &termios);
        termios.c_cflag &= ~CRTSCTS;
        termios.c_cflag |= CLOCAL;
        tcsetattr(STDIN_FILENO, TCSANOW, &termios);

This worked up to Linux version 2.2.17 or thereabouts.

This no longer is the case. It compiles and executes without errors, but
does absolutely nothing!  So, how do I initialize a serial link to ignore
RTS/CTS on version 2.4.0... ?

FYI, I tried......

	ioctl(fd, TIOCMGET, &modem);
        modem &= ~TIOCM_RTS;
//        modem &= ~TIOCM_CTS;
//        modem &= ~TIOCM_DTR;
        ioctl(fd, TIOCMSET, &modem);

... and other such guesses without any success.

Also:
	`cp textfile /dev/ttyS0`    # Waits forever
	`cat textfile >/dev/ttyS0`  # Waits forever
	but....
	`ls >dev/ttyS0`             # Executes 


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
