Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284944AbRLLBVr>; Tue, 11 Dec 2001 20:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284968AbRLLBVa>; Tue, 11 Dec 2001 20:21:30 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:37013 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S284944AbRLLBVR>; Tue, 11 Dec 2001 20:21:17 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Elliot Lee <sopwith@redhat.com>
Date: Wed, 12 Dec 2001 12:21:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15382.45336.802869.600836@notabene.cse.unsw.edu.au>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: knfsd and FS_REQUIRES_DEV
In-Reply-To: message from Elliot Lee on Tuesday December 11
In-Reply-To: <20011211.162011.21927662.davem@redhat.com>
	<Pine.LNX.4.33.0112111922100.541-100000@devserv.devel.redhat.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 11, sopwith@redhat.com wrote:
> I'm not worried about problems where files mysteriously disappear due to
> me screwing up inode numbers in my code, only about causing kernel panics
> or other Bad Things in the server's kernel. If I were to remove the
> FS_REQUIRES_DEV check (or, more likely, submit a patch adding an nfsd
> module option to remove the check...), what are the worst things that
> could theoretically and realistically happen?

If you just removed the check, the worst that would happen is that
after a server reboot you have to remount everything on your clients.

If you submit a patch to make it an option, the worst that can happen
is that I jump on you (but I'm not a good long jumper, so you are
pretty safe).

I plan to make a change to knfsd in the near future so that you can
have an option like:
   fs=27
in /etc/exports and the the kernel puts the magic number "27" in the
filehandle instead of the device number.  Then as long as you export
each filesystem with a unique and consistant fs number, you won't need
to worry about the instability of device numbers.

NeilBrown
