Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266714AbRGFPGe>; Fri, 6 Jul 2001 11:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266719AbRGFPGY>; Fri, 6 Jul 2001 11:06:24 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:15807 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S266714AbRGFPGJ>; Fri, 6 Jul 2001 11:06:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: The SUID bit (was Re: [PATCH] more SAK stuff)
Date: Fri, 6 Jul 2001 06:04:40 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200107060145.f661j5v74941@saturn.cs.uml.edu>
In-Reply-To: <200107060145.f661j5v74941@saturn.cs.uml.edu>
MIME-Version: 1.0
Message-Id: <01070606044004.00596@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 July 2001 21:45, Albert D. Cahalan wrote:

> Oh, cry me a river. You can set the RUID, EUID, SUID, and FUID
> in that same parent process or after you fork().

Okay, I'll bite.

The file user ID is fine, the effective user ID is what the suid bit sets to 
root of course, the saved user id is irrelevant to this (haven't encountered 
something that actually cares about it yet, and yes I have been checking 
source code when I bump into a problem).

But the actual uid (real user ID) ain't root, and an euid of root doesn't let 
me change the uid itself to root, or at least I haven't figured out how.  
(And haven't really tried: there are some things that might conceivably care 
whether you really are root or not, but the samba change password command 
isn't one of them.  I have a password protected cgi accessed via ssl which 
allows the manipulation of a limited subset of samba users, and the samba 
tool will happily let me change anybody's password as suid root.  But to add 
a user, the script has to append an entry to the file manually and then 
change the password from "racecondition" (which it is) to whatever the user's 
password should be.  I could patch and ship nonstandard samba binaries, but 
that makes automatic upgrades problematic.  (And samba, being a net 
accessable server, REALLY needs to be kept up to date.))

Do you have a code example of how a program with euid root can change its 
actual uid (which several programs check when they should be checking euid, 
versions of dhcpcd before I complained about it case in point)?

Some of it's misguided "policy", assuming that the suid bit is on the 
executable itself instead of its parent process.  A check and an error "Thou 
shalt not set this suid root" is fairly common on things that can be securely 
run from a daemon running AS root.  So apparently, the obvious way to fix it 
is to relax the security restrictions even MORE, which is silly.

> Since you didn't set all the UID values, I have to wonder what
> else you forgot to do. Maybe you shouldn't be messing with
> setuid programming.

Ah, the BSD attitude.  If you don't already know it, you should die rather 
than try to learn it.  Anybody who isn't perfect should leave us alone, we 
LIKE our user base small. :)

Following this logic, nobody should use Linux because the kernel has 
repeatedly shipped with holes allowing people to hack root, gaping big holes 
like the insmod `;rm -rf /` thing last year.  Apparently we should all be 
using an early 90's version of netware or some kind of embedded system 
audited for stack overflows and burned in ROM...

Rob

(Reference dilbert: "Here's a quarter kid, go buy yourself a real computer."  
That's a nice way to recruit new users to help politically support decss or 
convince video card manufacturers to release source code to their 3d drivers, 
winmodems, funky encryption in USB audio, slipping registration stuff in the 
ATA spec...)
