Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131949AbRC1PWw>; Wed, 28 Mar 2001 10:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131912AbRC1PWn>; Wed, 28 Mar 2001 10:22:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14344 "EHLO www.linux.org.uk") by vger.kernel.org with ESMTP id <S131882AbRC1PWb>; Wed, 28 Mar 2001 10:22:31 -0500
Date: Wed, 28 Mar 2001 16:08:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: snwahofm@mi.uni-erlangen.de, Jesse Pollard <jesse@cats-chateau.net>, Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
Message-ID: <20010328160825.C6867@flint.arm.linux.org.uk>
References: <200103281440.IAA48398@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103281440.IAA48398@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Wed, Mar 28, 2001 at 08:40:42AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 08:40:42AM -0600, Jesse Pollard wrote:
> Now, if ELF were to be modified, I'd just add a segment checksum
> for each segment, then put the checksum in the ELF header as well as
> in the/a segment header just to make things harder. At exec time a checksum
> verify could (expensive) be done on each segment. A reduced level could be
> done only on the data segment or text segment. This would at least force
> the virus to completly read the file to regenerate the checksum.

Checksums don't help that much - virus writers would treat it as "part
of the set of alterations that need to be made" and then the checksum
becomes zero protection.

Your system binaries are safe from the virus (from my understanding of the
poor writeup) if you are sensible about your system - ie, don't run stuff
as the root user, don't login as root, ensure that your binaries are owned
by root etc.

If users have their own binaries, then they should take adequate care
over them (find ~ -type f -perm +111 | xargs chmod a-w) to ensure that
they are not writable (this applies to your argument as well).

Once you're in this situation:

1. Users can't write to their executables without first chmod'ing them.
   (won't take long for a virus writer to get the idea that they should
   chmod +w them first).

2. If a user binary becomes infected, only people able to run that binary
   also become infected.  Certainly root should under no circumstances
   run any program which a user has compiled - the user may have some
   nice code in there which creates another root user in /etc/passwd
   with no password entry.

3. Since you're only running system programs as root (and by that I mean
   stuff for administration, not stuff like mail clients, news readers
   etc), your system binaries should not become infected.

Therefore, if you follow good easy system administration techniques, then
you end up minimising the risk of getting:

1. viruses
2. trojans
3. malicious users

cracking your system.  If you don't follow these techniques, then you're
asking for lots of trouble, and no amount of checksumming/signing/etc
will ever save you.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

