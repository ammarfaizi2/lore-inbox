Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSHOTbx>; Thu, 15 Aug 2002 15:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSHOTbx>; Thu, 15 Aug 2002 15:31:53 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317354AbSHOTbv>; Thu, 15 Aug 2002 15:31:51 -0400
Date: Thu, 15 Aug 2002 15:35:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: New Signal funnies on 2.4.19
Message-ID: <Pine.LNX.3.95.1020815153323.2319A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In linux-2.4.18 and before, one can check for an input keystroke
by setting up a signal handler and acting upon that signal.

A snippet of code follows: 

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
/*
 *  Save terminal characteristics and then set the terminal for raw
 *  input generating a signal upon any received character.
 */ 
    if(tcgetattr(STDIN_FILENO, &term) == FAIL)
        ERRORS(Tcgetattr);
    save = term;
    term.c_lflag = ISIG;
    term.c_iflag = 0;
    if(tcsetattr(STDIN_FILENO, TCSANOW, &term) == FAIL)
        ERRORS(Tcsetattr);
    if((flags = fcntl(STDIN_FILENO, F_GETFL)) == FAIL)
        ERRORS(Fcntl);
    flags |= (FNDELAY|FASYNC);
    if(fcntl(STDIN_FILENO, F_SETFL, flags) == FAIL)
        ERRORS(Fcntl);
    if(fcntl(STDIN_FILENO, F_SETOWN, getpid()) == FAIL)
        ERRORS(Fcntl);


In Linux-2.4.19, a signal is generated on OUTPUT as well as
input when STDIN_FILENO is associated with the network through
a virtual terminal 'pty' (like telnet).

This is NotGood(tm). Before I make work-arounds in production
code, is this a new standard or is it a bug? If this is a new
'standard', then the signal should be generated upon output
to all I/O terminal devices (which it isn't).


If somebody has a patch, I can easily check the fix.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

