Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278401AbRJMU6O>; Sat, 13 Oct 2001 16:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278411AbRJMU6E>; Sat, 13 Oct 2001 16:58:04 -0400
Received: from pigpen.lucentctc.com ([199.93.237.4]:28686 "EHLO
	pigpen.lucentctc.com") by vger.kernel.org with ESMTP
	id <S278401AbRJMU54>; Sat, 13 Oct 2001 16:57:56 -0400
Message-ID: <CCE8403B91E4D4119E9300A0C9DDA22401C16AFE@pigpen.lucentctc.com>
From: "Kingsbury, Michael" <mkingsbury@avayactc.com>
To: "'David Schwartz'" <davids@webmaster.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: High Rate of Sockets ->  No buffer space availible errors
Date: Sat, 13 Oct 2001 16:58:17 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, these are TCP sockets.  I do see some errors with regard to too many
open files, but not before the buffer error.   

-mike

-----Original Message-----
From: David Schwartz [mailto:davids@webmaster.com]
Sent: Saturday, October 13, 2001 10:13 AM
To: mkingsbury@avayactc.com; 'linux-kernel@vger.kernel.org'
Subject: Re: High Rate of Sockets -> No buffer space availible errors



On Sat, 13 Oct 2001 11:08:48 -0400, Kingsbury, Michael wrote:

>I have a network testing application that is opening & closing sockets with
>other machines at a high rate (multi-threaded,  1000 opens & closes a
second
>with ~20 machines.)  There's a seperate thread per machine its connecting
>to, and each thread opens a socket, transmits 8k, and closes.

	Are these TCP sockets? It can take around 2 minutes to close a TCP 
connection. So 1,000 opens/closes a second could potentially mean 120,000 
connections sitting around. Are you sure you aren't running out of local 
ports or something else?

>The problem lies with an error of 'No buffer space availible' within the
>first couple of seconds.  I've tried the SO_SNDBUF&  SO_RVCBUF, but that
>doesn't make sense in my head anyways.  Anyone seen problems like this
under
>similar conditions & maybe any remedys?

	Which system call returns the error? socket? bind? send? receive?

	And why are you using so many threads? Are you under the
misperception that 
you need lots of thread to do lots of work? Perhaps your architecture is a 
major part of the problem.

	DS

