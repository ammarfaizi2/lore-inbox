Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbTDXIeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTDXIeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:34:05 -0400
Received: from [66.62.77.7] ([66.62.77.7]:33430 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S261839AbTDXIeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:34:03 -0400
Date: Thu, 24 Apr 2003 02:46:11 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: Valdis.Kletnieks@vt.edu
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Clemens Schwaighofer <cs@tequila.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
In-Reply-To: <200304240556.h3O5uexQ002672@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0304240206490.7870-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003 Valdis.Kletnieks@vt.edu wrote:

> On top of which, if a buffer overflow is found, the exploit will run in
> the context of the signed program. 

Two examples I can think of right now:

1. Manipulated 007 save games files can subvert the Xbox when they 
overflow the trusted game.
2. The "hack resistant" series 2 Tivo boxes can be subverted by a 
insecure, signed Linux kernel.

The Tivo kernel is signed with ElGamal, and the Tivo firmware will refuse
to run a non-signed kernel and initrd image. The initrd image has SHA1
hashes of all the bootup config files, binaries and and a hash checker.  
The idea here is that Tivo can control what is executed.

Turns out Tivo signed a kernel+initrd that wasn't locked down properly.  
Oops! This kernel+initrd package has become a hot commodity.

The pieces that come together are:

1. All directories/files are verified EXCEPT stuff on /var
- However, none of the hash checked boot scripts reference anything on 
/var

2. Users can control what command line is passed to the kernel

3. Users can put the Tivo hard drive in a PC and put stuff on /var.

Finally, Tivo didn't validate/scrub the kernel command line properly, and 
people were able to get their own daemons and code running, stored on 
/var, by passing BASH_ENV with a funky value to the kernel.

Dax Kelson

