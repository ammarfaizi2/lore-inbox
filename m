Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292459AbSBPFgn>; Sat, 16 Feb 2002 00:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292460AbSBPFge>; Sat, 16 Feb 2002 00:36:34 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:51946 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S292459AbSBPFgY>; Sat, 16 Feb 2002 00:36:24 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Matt Bernstein <matt@theBachChoir.org.uk>
Date: Sat, 16 Feb 2002 16:39:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15469.61588.692971.442274@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to avoid stale NFS filehandles?
In-Reply-To: message from Matt Bernstein on Friday February 15
In-Reply-To: <15467.2034.663448.825288@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.44.0202151141510.1457-100000@nick.dcs.qmul.ac.uk>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday February 15, matt@theBachChoir.org.uk wrote:
> Hi,
> 
> I'm wondering what encoding is used for NFSv{2,3} file handles under
> knfsd. In particular, can I upgrade kernel from 2.4.x to 2.4.y without
> my clients accumulating stale filehandles?

In general, you should be able to upgrade a minor version (e.g. 2.2 to
2.4) and up or down grade a patch leverl (e.g. 2.4.2 to 2.4.10 and
back to 2.4.2) without and filehandle compatability problems.
This only applies from 2.2.16 or there abouts.  Before that it was a
bit of a mess.

In particular, 2.4 introduced a new file handle format, but still
recognises the old file handle format.  Further, in response to a
request that contains an old style file handle, it generates an old
style file handle so that the client can compare filehandles and so
that thos filehandles can still be used in the server is down graded.

Some time in 2.4 I will probably introduce a new export option
(fs=nnnn) which will cause the filehandles to look slightly different
(i.e. not have any device numbers in them).  This will be optional
(options are like that...) but even if you do change a filesystem to
be exported with the new option, clients that currently have it
mounted will still work without getting stale file handles.

So, you should be safe (but if something does go wrong, let me know
... there could always be a bug in there somewhere).

NeilBrown
