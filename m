Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292688AbSCSVFv>; Tue, 19 Mar 2002 16:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292705AbSCSVFm>; Tue, 19 Mar 2002 16:05:42 -0500
Received: from fungus.teststation.com ([212.32.186.211]:9224 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S292688AbSCSVFf>; Tue, 19 Mar 2002 16:05:35 -0500
Date: Tue, 19 Mar 2002 22:04:44 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.teststation.com
To: Andreas Dilger <adilger@clusterfs.com>
cc: John Jasen <jjasen1@umbc.edu>, Mike Galbraith <mikeg@wen-online.de>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reading your email via tcpdump
In-Reply-To: <20020319154734.GM470@turbolinux.com>
Message-ID: <Pine.LNX.4.44.0203192147590.27806-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Andreas Dilger wrote:

> On Mar 19, 2002  10:11 -0800, Mike Fedyk wrote:
> > That's not the problem part of the tcpdump output.  The problem is that part
> > of an email previously read on the linux box (with no samba runing. (also,
> > no smbfs MikeG?)) showed up in the tcpdump output...
> 
> I haven't been following the whole thread, but it is _possible_ that the
> email data was written to the end of a data block which was later re-used
> for a file exported via SMB.  Depending on how the SMB code works, is it
> possible that it is sending a whole block of data to the client and/or
> not zeroing out new blocks?

There was no SMB involved on the box that errors and as I understand it
the email never touched the windows box involved. I think this is just
tcpdump misbehaving.


I'm guessing that Mike ran tcpdump with no -s parameter. The tcpdump
decoder (for SMB and probably others) doesn't seem to look at how much
data is valid when it decodes. At least I believe that I have seen it
do that before and/or when playing with some decode to ascii patch.

The SMB part that is decoded is ridiculous. word count of 66 (10-15 yes,
lots of those but 66?). The Flags do not match what any server I know of
returns.

Further, when there is a smb error return normally the rest of the packet
is empty. And the (known) error classes are 0, 1, 2, 3, not 0x46. Some of
the "parameter words" (smb_vwv) looks suspicously like ascii data.


Like you say, if the tcpdump was running while the email was received on
Mike's box it is possible that it had that data in some buffer. When it
later got this message (in another buffer) and tried to decode it, it
decoded the length the message said it had and simply spewed out random
bytes from memory.

Someone that feels like doing some hex to ascii conversion can find work 
here:
http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-11/att-x_

/Urban

