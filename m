Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131346AbRC1OnW>; Wed, 28 Mar 2001 09:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131365AbRC1OnN>; Wed, 28 Mar 2001 09:43:13 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:36169 "EHLO tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP id <S131346AbRC1OnD>; Wed, 28 Mar 2001 09:43:03 -0500
Date: Wed, 28 Mar 2001 08:40:42 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103281440.IAA48398@tomcat.admin.navo.hpc.mil>
To: snwahofm@mi.uni-erlangen.de, Jesse Pollard <jesse@cats-chateau.net>
cc: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> 
> On Wed, 28 Mar 2001, Jesse Pollard wrote:
> 
> > >Any idea?
> > 
> > Sure - very simple. If the execute bit is set on a file, don't allow
> > ANY write to the file. This does modify the permission bits slightly
> > but I don't think it is an unreasonable thing to have.
> 
> And how exactly does this help?
> 
> fchmod (fd, 0666);
> fwrite (fd, ...);
> fchmod (fd, 0777);

By itself it doesn't - but if you also don't have user/group/world rw and
don't own the file, you can't do anything to it.

It's only there to reduce accidents. If you want to go full out,
remove the symbols from the file.

Now, if ELF were to be modified, I'd just add a segment checksum
for each segment, then put the checksum in the ELF header as well as
in the/a segment header just to make things harder. At exec time a checksum
verify could (expensive) be done on each segment. A reduced level could be
done only on the data segment or text segment. This would at least force
the virus to completly read the file to regenerate the checksum.

That change would even allow for signature checks of the checksum if the
signature was stored somewhere else (system binaries/setuid binaries...).
But only in a high risk environment. This could even be used for a scanner
to detect ANY change to binaries (and fast too - signature check of checksums
wouldn't require reading the entire file).

In any case, the problem is limited to one user, even if nothing is done.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
