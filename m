Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312824AbSC0D2r>; Tue, 26 Mar 2002 22:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312974AbSC0D2h>; Tue, 26 Mar 2002 22:28:37 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:14992 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S312824AbSC0D2X>; Tue, 26 Mar 2002 22:28:23 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Wed, 27 Mar 2002 14:23:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15521.15136.643851.483671@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre4-ac1
In-Reply-To: message from Mike Fedyk on Tuesday March 26
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 26, mfedyk@matchmail.com wrote:
> On Wed, Mar 27, 2002 at 01:07:00PM +1100, Neil Brown wrote:
> > On Wednesday March 27, afu@fugmann.dhs.org wrote:
> > > Thanks.
> > > 
> > > It seems that there is some more problems.
> > > I have not verified the lookup (since I just booted right away with the patch), but
> > > I have found that:
> > > 
> > > Mar 26 23:56:58 gw kernel: nfsd: LOOKUP(3)   24: 03000001 03000900 00000002 0000106d 0000106c 0000070d WMRootMenu
> > > Mar 26 23:56:58 gw kernel: RPC request reserved 240 but used 244
> > > 
> > > Mar 27 00:30:09 gw kernel: nfsd: CREATE(3)   24: 03000001 03000900 00000002 00000003 00000002 00000000 test
> > > Mar 27 00:30:09 gw kernel: RPC request reserved 272 but used 276
> > > 
> > > Mar 27 00:30:21 gw kernel: nfsd: SYMLINK(3)  24: 03000001 03000900 00000002 00000003 00000002 00000000 test1 -> test
> > > Mar 27 00:30:21 gw kernel: RPC request reserved 272 but used 276
> > > 
> > > And there might be others.
> > 
> > I bet you're using reisferfs ???
> > 
> > It occasionaly uses filehandles longer than 32 bytes (the max for
> > NFSv2) and my calculations forgot that nfsv3 allows for 64 bytes.
> > So "9" (8 longs and a count) should be "17" (16 longs and a count).
> >
> 
> Why aren't you using defines with comments in effect to the above?

No really good reason.
I think I felt that macros would be very noisy for relatively little
gain.
However I guess

#define ST 1  /* status*/
#define FH 17 /* filehandle with length */
#define AT 22 /* attributes */
#define WC 7  /* WCC attribute prefix */

might make things clearer without being too noisy....

NeilBrown
