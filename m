Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318155AbSHKJKI>; Sun, 11 Aug 2002 05:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSHKJKI>; Sun, 11 Aug 2002 05:10:08 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:53891 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318155AbSHKJKH>; Sun, 11 Aug 2002 05:10:07 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Chris the Elder <chippo@netactive.co.za>
Date: Sun, 11 Aug 2002 19:13:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15702.10940.895498.828689@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ancient NFS patch sought
In-Reply-To: message from Chris the Elder on Sunday August 11
References: <3D5622FC.7080602@netactive.co.za>
X-Mailer: VM 7.03 under Emacs 21.2.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday August 11, chippo@netactive.co.za wrote:
> Greets,
> 
> I'm looking for a few terms that I can use to STFW with google, to find
> the patch (or code) for a wierd ancient NFS feature.
> 
> Many years ago I was using someone else's Linux box with NFS.  This
> version of NFS had the feature that:
> 
> On the server you could copy a file to it's own name followed by a '#'
> followed by the MAC address of one of the clients, and then that client
> would see this copy of the file as though it were the original.  The two
> files would typically be different, and the server and the client get
> their own versions each.  The process could be continued for any number
> of different clients.
> 
> Can anyone give me some search terms (or an URL) to help me find the
> code for this feature on the web?

ClusterNFS on sourceforge.  So
   http://clusternfs.sourceforge.net/

> 
> TIA,
> chippo
> 
> PS: What I really want to know (which I'll hopefully glean from the
> code/URL when located) is:
>  - was this a user-space or kernel-space implementation of NFS

UserSpace

>  - how much mission it'll be to get the same (or similar) functionality
> on a 2.4 kern.

Not if I can help it.  All the functionality you need already exists.

Each client mounts a common root filesystem.
A very early rc script mounts a per-client filesystem on
e.g. /perclient.
The rc script can use hostname or IP address or MAC address or
whatever it wants to choose the actual filesystem to mount:

   mount -t nfs -o nolocks server:/clientfilesys/`hostname` /perclient

Then any file that needs to be per-client becomes a symlink into
/perclient.

About the only thing that this doesn't work for is files the are
unlinked and re-created often.  I suspect if there are any of those
there is a workable solution.

NeilBrown


> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
