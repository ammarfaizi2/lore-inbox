Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129364AbRCEPvr>; Mon, 5 Mar 2001 10:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129372AbRCEPvi>; Mon, 5 Mar 2001 10:51:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:19074 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129364AbRCEPv0>; Mon, 5 Mar 2001 10:51:26 -0500
Date: Mon, 5 Mar 2001 10:50:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: John Kodis <kodis@mail630.gsfc.nasa.gov>
cc: linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010305095512.A30787@tux.gsfc.nasa.gov>
Message-ID: <Pine.LNX.3.95.1010305102226.9913A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, John Kodis wrote:

> On Mon, Mar 05, 2001 at 08:40:22AM -0500, Richard B. Johnson wrote:
> 
> > Somebody must have missed the boat entirely. Unix does not, never
> > has, and never will end a text line with '\r'.
> 
> Unix does not, never has, and never will end a text line with ' ' (a
> space character) or with \t (a tab character).  Yet if I begin a shell
> script with '#!/bin/sh ' or '#!/bin/sh\t', the training white space is
> striped and /bin/sh gets exec'd.  Since \r has no special significance
> to Unix, I'd expect it to be treated the same as any other whitespace
> character -- it should be striped, and /bin/sh should get exec'd.
> 

No. the '\n' character is interpreted. '\t' is expanded on stdout if
the terminal is "cooked". Other interpreted characters are:
		^C, ^\, ^U, ^D, ^@, ^Q, ^S, ^Z, ^R, ^O, ^W, ^V

These are all upper-case ASCII letters codes minus 64. The erase (VERASE)
is special and is '?' + 64 

The '\r' (^R) definitely has special significance to Unix. It's called
"VREPRINT", in the termios structure member "c_cc". If it exists in
a file instead of an output stream, these characters are not interpreted.
All files in Unix are binary. It's the 'C' runtime library that may
interpret file contents for programmer convenience. For instance,
fgets() reads until the new-line character. If you happen to have a
'\r' before that new-line, guess what? You will have a '\r' in your
string. If you were attempting to do:

	ls foo\r

You will get a file-not found error unless you have a file with '\r'
as its last character.

There is really no such thing as  "whitespace" in Unix compatible text.
For instance, the text in a Makefile MUST use the tab character as a
separator. Spaces won't do.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


