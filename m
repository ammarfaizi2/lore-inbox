Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbQLSVzh>; Tue, 19 Dec 2000 16:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129886AbQLSVz2>; Tue, 19 Dec 2000 16:55:28 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:57607 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129747AbQLSVzS>; Tue, 19 Dec 2000 16:55:18 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Michael J. Dikkema" <mjd@moot.ca>
Date: Wed, 20 Dec 2000 08:24:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14911.53776.854761.710519@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 question (fh_lock_parent)
In-Reply-To: message from Michael J. Dikkema on Tuesday December 19
In-Reply-To: <Pine.LNX.4.21.0012190929280.637-100000@sliver.moot.ca>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 19, mjd@moot.ca wrote:
> 
> I've been getting tonnes of these since I installed 2.2.18. Is this a
> problem? Should I even worry about this? If I don't need to worry about
> it, is there a way to stop displaying this message?
> 
> fh_lock_parent: mqueue/xfBAA14279 parent changed or child unhashed
> fh_lock_parent: mqueue/xfBAA16413 parent changed or child unhashed

You are running sendmail on an NFS client with /var/spool mounted off
the NFS server which is giving these message - right?

These messages tend to indicate a race between two different NFS
requests that try to do something to the one file - probably unlink
it, though possibly rename it.

If everything is configured properly (e.g. you don't have two
different sendmails on two different clients trying to use the one
shared spool area), then this would seem to imply that the server is
responding more slowly that the client would like, and the client is
resending the unlink (or whatever) request and so there are two
identical requests being served by the NFS server and they race.

So it is hard to be sure if you should worry about this.
Maybe if you tell us what you are trying to do (i.e. confirm the
configuration of sendmail, NFS mounts and the number of clients.
Also, how frequent is this?  Would you be able to get a tcpdump of a
few hundred packets either side of the message? If you do try this,
make sure that you use a large snap-length for tcpdump (-s 1024) to
get the whole nfs packet.

NeilBrown

> 
> ,.;::
> : Michael J. Dikkema
> | Systems / Network Admin - Internet Solutions, Inc.
> | http://www.moot.ca   Work: (204) 982-1060
> ; mjd@moot.ca
> ',.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
