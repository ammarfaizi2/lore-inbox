Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266950AbUAXPMC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 10:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266951AbUAXPMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 10:12:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34009 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266950AbUAXPL6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 10:11:58 -0500
Date: Sat, 24 Jan 2004 15:11:56 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: RFC: Representation of large hex values
Message-ID: <20040124151156.GB1029@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0 (i686)
X-Uptime: 14:55:28 up 15:56,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(OK, this isn't strictly a kernel thing - but it seems to be a good
place for peoples thoughts on this, and the kernel would be one
place to start it off)

The problem: Large (64 bit) hex values are cumbersome - especially
when they contain strings of 0's in the middle

Suggestion: Print hex value with a seperator every 4 or 8 nybbles
to aid in counting.  After some discussion it seems that _
is a decent seperator - e.g.

1000_0000_0000_1234

this is especially useful when you have a pile of numbers like

1000000021771245

and you are trying to see if that is bigger or smaller than 
the number 1000000232349876, yet it is pretty obvious when you
try and compare 1000_0000_2177_1245 and 1000_0002_3234_9876.

I originally thought of using : like IPv6 but this can get
in the way on languages which use : for other things.
(and I don't think it is worth doing packed numbers like IPv6
does - i.e. 1000_0_2177_1245 would be invalid).

For clarity, it would seem best to use a distinct format character;
so perhaps prefix these numbers by 0y (read Oi!) and then you
could use %y (and %Y if you REALLY want) in printf. Scanf equivalents
would be taught to understand both formats; using 0y and _ makes
code that doesn't understand the format fail noisily. So:

0ydead_beef_1ced_ac1d

I don't think there is the necessity to force zero padding, so 
1_2177_1245 is valid; but _ shall not be the first character
(so as not to construct an identifier). (I'm vaguely remembering
that VHDL allows _ padding?)

If people like this then I'd be happy to write a modified
printf/scanf, and I suggest that it gets used in limited places
until the same could be integrated in gdb/binutils/other tools.

Suggestions and constructive comments welcome and apologies
for disturbing your games of wack-the-penguin.

Dave
P.S. Thanks go to members of the non-existant cabal on this.

 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
