Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbSAZKyI>; Sat, 26 Jan 2002 05:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281214AbSAZKx6>; Sat, 26 Jan 2002 05:53:58 -0500
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:6081 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S279798AbSAZKxw>; Sat, 26 Jan 2002 05:53:52 -0500
Date: Sat, 26 Jan 2002 05:53:52 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [question] implentation of smb-browsing: kernel space or user
 space?
In-Reply-To: <a2cqc9$2fc$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201260540350.17807-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan 2002, H. Peter Anvin wrote:
> Followup to:  <Pine.LNX.4.33.0201191313170.4434-100000@cola.teststation.com>
> By author:    Urban Widmark <urban@teststation.com>
> In newsgroup: linux.dev.kernel
> > >
> > > I think that using the smb-file-system with a user-space mounter like
> > > mkautosmb has the problem of bad scalability in large networks, because it
> > > scans the whole network before you can access one share.
> >
> > You don't need to scan on every access. You could run the scanner only if
> > it was more than x minutes since the last scan. You could run the scanner
> > independently of any attempts to access autofs.
> >
>
> There is probably no need to even do that.  SMB contains a browser
> list protocol, and Samba (nmbd) can participate in it.  You should be
> able to read it out of there.

Yes.  Consider the way DNS is implemented, and do likewise.  That is,
there's a library which presents a single standard interface for mapping
names (shares, hosts, whatever) to addresses in the NMB namespace.  It
can be configured to use a local nmbd if you have one, a nearby nmbd if
you choose, LDAP searching of the local ADS forest if there is one, etc.
without reconfiguring the app.s.

It might even be grafted onto the existing resolver library, although the
name resolution API may be due for an overhaul to generalize it over a
wider variety of name resolution services.

How the results are presented to app.s is a separate question, and I
believe that there are methods of implementing filesystems almost entirely
in userspace.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Our lives are forever changed.  But *that* is exactly as it always was.

