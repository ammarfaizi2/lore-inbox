Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277170AbRJMRNA>; Sat, 13 Oct 2001 13:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276815AbRJMRMj>; Sat, 13 Oct 2001 13:12:39 -0400
Received: from mail.webmaster.com ([216.152.64.131]:59877 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S276547AbRJMRMd> convert rfc822-to-8bit; Sat, 13 Oct 2001 13:12:33 -0400
From: David Schwartz <davids@webmaster.com>
To: <mkingsbury@avayactc.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (988) - Registered Version
Date: Sat, 13 Oct 2001 10:13:02 -0700
In-Reply-To: <CCE8403B91E4D4119E9300A0C9DDA22401C16AFD@pigpen.lucentctc.com>
Subject: Re: High Rate of Sockets ->  No buffer space availible errors
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20011013171303.AAA7749@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 Oct 2001 11:08:48 -0400, Kingsbury, Michael wrote:

>I have a network testing application that is opening & closing sockets with
>other machines at a high rate (multi-threaded,  1000 opens & closes a second
>with ~20 machines.)  There's a seperate thread per machine its connecting
>to, and each thread opens a socket, transmits 8k, and closes.

	Are these TCP sockets? It can take around 2 minutes to close a TCP 
connection. So 1,000 opens/closes a second could potentially mean 120,000 
connections sitting around. Are you sure you aren't running out of local 
ports or something else?

>The problem lies with an error of 'No buffer space availible' within the
>first couple of seconds.  I've tried the SO_SNDBUF&  SO_RVCBUF, but that
>doesn't make sense in my head anyways.  Anyone seen problems like this under
>similar conditions & maybe any remedys?

	Which system call returns the error? socket? bind? send? receive?

	And why are you using so many threads? Are you under the misperception that 
you need lots of thread to do lots of work? Perhaps your architecture is a 
major part of the problem.

	DS


