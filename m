Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132984AbRDYXI6>; Wed, 25 Apr 2001 19:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132993AbRDYXIt>; Wed, 25 Apr 2001 19:08:49 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:19604 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S132984AbRDYXIi>; Wed, 25 Apr 2001 19:08:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
Date: Thu, 26 Apr 2001 01:09:04 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3AE704FA.DCF1BEC6@kegel.com> <01042520555600.00849@cookie> <3AE72344.97C849DA@kegel.com>
In-Reply-To: <3AE72344.97C849DA@kegel.com>
MIME-Version: 1.0
Message-Id: <01042601090401.01143@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 April 2001 21:19, you wrote:
> The corresponding one-value-per-file approach can probably be made to
> be a single call per value.  

Yes, the real problem is writing a callback-based filesystem (unless you want 
to hold everything in memory). After thinking about it for the last two hours 
I already find the one-value-per-file approach not as hard to do as I did 
before, but it's still a lot of work.


> Have you bothered to go back and read the old discussions on this topic?

Yes. But in my case is different than, for example, the files in /proc/sys:
- the file names in /proc/sys are static. For devreg the filenames must be 
made dynamically (similar to the /proc process directories or usbdevfs)
- in /proc/sys there is just one piece for code responsible for every file or 
directory and no cooperation between different parts. If devreg creates, for 
example, a directory for a USB mouse it must be prepared to share this 
directory with the USB subsystem, the input subsystem and the USB hid driver. 
All four modules are responsible for their own files. 
- files and their content should be created on demand, so there must be some 
callback to tell the USB subsystem something like "the user just opened the 
directory of device X, please tell me which directories or files you want to 
add". 

It is certainly possible to convert devreg to the one-value-per-file approach 
and if this is all that it takes to get into some future (2.5) kernel I will 
do it. I just doubt that this is the easiest way to implement the 
functionality, because that's what I really want.


> Are you trying to avoid writing a DTD?  

Yes, at least a have a complete DTD, because it would be a nightmare to 
maintain it. Each time somebody adds a new capability to a driver the DTD 
would have to be updated. And what about drivers that are not part of the 
official kernel?
I thought about using a separate XML Schema definition for each namespace 
though.

bye...
