Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSIIAXX>; Sun, 8 Sep 2002 20:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSIIAXX>; Sun, 8 Sep 2002 20:23:23 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:44941 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S315721AbSIIAXW>; Sun, 8 Sep 2002 20:23:22 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Juan Gomez <juang@us.ibm.com>
Date: Mon, 9 Sep 2002 10:27:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15739.60163.174816.739514@notabene.cse.unsw.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: NFS lockd patch proposal for user-level control of the grace period 
In-Reply-To: message from Juan Gomez on Friday September 6
References: <OF1F5F01D1.E414689E-ON87256C2C.007B2D30@us.ibm.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday September 6, juang@us.ibm.com wrote:
> 
> 
> 
> 
> Christoph, Alan, Neil,
> 
> Attached you will find the patch with the sysctl implementation of my
> previous patch to enable grace period control from user-land.
> Please let me know if this looks good enough for inclusion in the kernel
> distribution or whether I still need to do something else.
> Note this piece is derived from net/sunrpc/sysctl.c, which by the way I
> think has a problem with the READ/WRITE verifys which seem
>  to be swicthed which I fixed in lockd version but not there, you may want
> to take a look at net/sunrpc/sysctl.c and fix that although that's a minor
> thing.
> 
> (See attached file: lockd-sysctl.patch)
> 

I still haven't managed to find out exactly what you want to do with
this, and hence whether it is appropriate.

You mentioned in another Email that this was for a High Availability
setup where one server might take-over a filesystem that another
server was previously serving.

If this is the case, do you really want to change the grace period, or
do you really want to re-start the grace period.
If that is what you really want, then I think that sysctl is
un-necessary and a simple signal would do the trick.
Currently, SIGKILL will
   1/ drop all locks held for clients
   2/ restart the grace period.

it would probably be quite sensible (and trivial to code) for SIGHUP
(say) to restart the grace period without dropping the locks.

Would this be suitable for you?

NeilBrown
