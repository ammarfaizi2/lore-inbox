Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276132AbRKFAfV>; Mon, 5 Nov 2001 19:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276135AbRKFAfL>; Mon, 5 Nov 2001 19:35:11 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:19620 "EHLO
	mail.lysator.liu.se") by vger.kernel.org with ESMTP
	id <S276132AbRKFAfE>; Mon, 5 Nov 2001 19:35:04 -0500
Date: Tue, 6 Nov 2001 01:34:56 +0100
From: Jorgen Cederlof <jc@lysator.liu.se>
To: lonnie@outstep.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Special Kernel Modification
Message-ID: <20011106013456.B12540@ondska>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1004920141.3be5dd4db68a0@mail.outstep.com>
User-Agent: Mutt/1.3.19i
X-eric-conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Nov 04, 2001 at 19:29:01 -0500, lonnie@outstep.com wrote:

> From what I can see. With chrooting, I have to make a complete
> "fake" system an then place the users below that into a home
> directory, or make a complete "fake" system for each user.
> 
> I was trying to find a simple solution that would allow for:
> 
> I was initially thinking about something like this for each user:
> 
> /system (real) /dev/hda4 (chrooted also)
>       |
>       /bin
>       /etc
>       /lib

chtrunk (http://noid.sf.net/chtrunk.html) can set up the namespace
dynamically for you. Instead of creating a complete system by hand and
run chroot, just run (you don't need to be root):

   chtrunk -s /bin /etc /lib /home/user -c program_to_run

This will give that program access to /bin, /etc, /lib and the home
directory, but nothing more.

You can use

   chtrunk -s /bin /etc /lib /home/user /tmp=/home/user/tmp -c program

to give every user their own private /tmp.

As a bonus, the suid/sgid bits will have no effect for these users,
which will prevent them from becoming root through buggy suid
programs.

    Jörgen
