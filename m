Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272755AbRILMWc>; Wed, 12 Sep 2001 08:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272763AbRILMWY>; Wed, 12 Sep 2001 08:22:24 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:38665 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S272755AbRILMWM>; Wed, 12 Sep 2001 08:22:12 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Marcus Sundberg <marcus@cendio.se>
Date: Wed, 12 Sep 2001 22:22:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15263.21360.720415.344639@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs is stupid ("getfh failed")
In-Reply-To: message from Marcus Sundberg on  September 12
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman>
	<15261.47176.73283.841982@notabene.cse.unsw.edu.au>
	<vebskgpu32.fsf@inigo.sthlm.cendio.se>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  September 12, marcus@cendio.se wrote:
> neilb@cse.unsw.edu.au (Neil Brown) writes:
> 
> > On  September 10, marcus@cendio.se wrote:
> > > cachefs sucks. It doesn't seem to cache stat(2) information.
> > > Doing ls -F in a ~100-entries directory takes several seconds over
> > > a link with 50ms round-trip time.
> > 
> > Well, I said "concept" not "implementation", but I suspect that
> > Solaris cachefs does cache stat information.  Maybe you just need to
> > increase the timeouts for the attribute cache.
> 
> Considering that I did several ls'es on the order of milliseconds
> apart I doubt that would help...

Odd..
I just tried out cachefs (for the first time) on Solaris2.6.
I mounted my home directory (which has 125 entries) and did 
 ls -F
while watching network traffic.

Except of the first time, and after every 30 seconds (the default
attribute cache timeout) there was only 1 RPC request for each
  ls -F
and that was to check the modify time on the directory.
But then that is exactly the same traffic that I see when I do
  ls -F
in my home directory over normal NFS (v2).

I could do 100 "ls -F" runns in about 4 seconds.
This is on regular 100Mbit ethernet.

NeilBrown
