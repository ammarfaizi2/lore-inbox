Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278365AbRJMTHr>; Sat, 13 Oct 2001 15:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278366AbRJMTHi>; Sat, 13 Oct 2001 15:07:38 -0400
Received: from [212.21.93.146] ([212.21.93.146]:58755 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S278365AbRJMTH3>; Sat, 13 Oct 2001 15:07:29 -0400
Date: Sat, 13 Oct 2001 21:05:21 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pablo Alcaraz <pabloa@laotraesquina.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011013210521.A995@kushida.jlokier.co.uk>
In-Reply-To: <Pine.LNX.4.33.0110130956350.8707-100000@penguin.transmeta.com> <3BC88AB3.2040707@laotraesquina.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC88AB3.2040707@laotraesquina.com.ar>; from pabloa@laotraesquina.com.ar on Sat, Oct 13, 2001 at 03:40:51PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo Alcaraz wrote:
> Whatever will be the chosen solution, it would have to allow to 
> overwrite all the executables and libraries files (if we have enough 
> permissions).

Pablo, there's no need for this.  Upgrades to libraries are done by
removing the old file's name from its parent directory and placing the
new file at that name, perhaps using an atomic rename.  The old _file_
continues to exist even though its name has been deleted, until the last
program using the library finishes using it, even though the old file
does not have a name any more.

New programs that open the library will find the new file.  Both files
exist until the old file finally disappears.  At no point is any file's
contents overwritten.

This is why you can upgrade a running linux system including critical
system libraries, and nothing crashes.  Usually ;-)

-- Jamie
