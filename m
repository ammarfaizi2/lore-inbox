Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288259AbSAHT1L>; Tue, 8 Jan 2002 14:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288262AbSAHT1B>; Tue, 8 Jan 2002 14:27:01 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:59661 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288259AbSAHT06>;
	Tue, 8 Jan 2002 14:26:58 -0500
Date: Tue, 8 Jan 2002 11:24:50 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, felix-dietlibc@fefe.de,
        andersen@codepoet.org
Subject: [RFC] klibc requirements
Message-ID: <20020108192450.GA14734@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

First off, I do not want to fork off yet another tiny libc
implementation, unless it is determined that we really need to do it.  I
posted the klibc implementation because I have found that in the past,
people can talk all they want, but the only way to actually get people
all riled up and start paying attention is to post code :)

Now that people are riled up, and want to talk about it, let's try to
describe the problem and see if any of the existing libc implementations
help solve them.  Here's what I see as a list of requirements for a
klibc like library that can be used by initramfs programs (please,
everyone else jump in here with their requirements too):
	- portable, runs on all platforms that the kernel currently
	  works on, but doesn't have to run on any non-Linux based OS.
	- tiny.  If we link statically it should be _small_.  Both
	  dietLibc and uClibc are good examples of the size goal.  We do
	  not need to support all of POSIX here, only what we really
	  need.
	- If we end up having a lot of different programs in initramfs,
	  a dynamic version of the library should be available.  This
	  shared library should be _small_ and only contain the symbols
	  that are needed by the programs to run.  This should be able
	  to be determined at build time.
	- It has to "not suck" :)  This is a lovely relative feeling
	  about the quality of the code base, ease at building the
	  library, ease at understanding the code, and responsiveness of
	  the developers of the library.

I don't think either dietHotplug or uClibc or glibc or any other
existing libc implementation meets these goals right now, right?

I had asked the dietLibc authors about the ability of tweaking their
library into something that resembles the above, but didn't get a
response.  Hence my post.  I would love to work with the authors of an
existing libc to build such a library, as I have other things I would
rather work on than a libc :)

Comments from the various libc authors?  Comments from other kernel
developers about requirements and goals they would like to see from such
a libc?

thanks,

greg k-h
