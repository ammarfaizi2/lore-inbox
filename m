Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVADFDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVADFDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVADFC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 00:02:29 -0500
Received: from lakermmtao07.cox.net ([68.230.240.32]:54429 "EHLO
	lakermmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262039AbVADEuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:50:24 -0500
In-Reply-To: <16858.5104.353423.247503@samba.org>
References: <41D9C635.1090703@zytor.com> <16857.56805.501880.446082@samba.org> <41D9E3AA.5050903@zytor.com> <16857.59946.683684.231658@samba.org> <41D9EDF6.1060600@zytor.com> <16857.62250.259275.305392@samba.org> <41D9F65E.3030301@zytor.com> <16857.63978.65838.823252@samba.org> <AA7F1C76-5DF7-11D9-B689-000393ACC76E@mac.com> <16858.1074.740440.917427@samba.org> <3D55717A-5E02-11D9-B689-000393ACC76E@mac.com> <16858.5104.353423.247503@samba.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <217129D4-5E0C-11D9-B689-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>, samba-technical@lists.samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ntfs-dev@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       sfrench@samba.org, aia21@cantab.net
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
Date: Mon, 3 Jan 2005 23:50:17 -0500
To: tridge@samba.org
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 03, 2005, at 22:56, tridge@samba.org wrote:
> superset is hard, as a uid_t/gid_t is only superfically similar to a
> windows SID. Samba has to do quite a lot of complex stuff to map
> between general SIDs and posix IDs. It can't be done in any reasonable
> fashion without being able to talk MSRPC to domain controllers, or at
> least having a (potentially quite large) persistent database of
> mappings.

I only have a couple points of response here, really.  Primarily, I 
didn't
say that I thought this was possible, let alone easy, only that it 
would be
closer to the mythical "ideal" than the system what we currently have.

My personal opinion is that perhaps this (ideally) should be integrated
somehow with an additional "credentials" system, perhaps like that
which dhowells added.  An "SID" for a particular local NTFS (or maybe
even remote via CIFS too) filesystem would be another "credential"
given to users.  Heck, if we _really_ wanted to go far, the "user" and
"group" identifiers originating in UNIX could be "credentials" too, and
passed on from parent to child processes.  In such a system, many of
the core process identity syscalls would need to be changed, but it
would be the framework for a much better network environment
integration, because the UID and GIDs would be local to one specific
computer, not global like NFS pretends they are.  Someone could
even have differing UIDs for local ext3 filesystems and remote NFSv3
and CIFS filesystems, like this:

/		"bobdoe@localhost" (32)
/mnt/nfs	"bdoe@cronos" (1054)
/mnt/cifs	"Bob Doe@ATLAS" (S-1-3-21-123123-456456-789789-32)

Of course, the standard disclaimer is that all this is far far down the
road, mainly because of how extensive such changes would be :-\.
It's always nice to dream, though :-D.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


