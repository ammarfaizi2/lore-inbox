Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbTBLU2k>; Wed, 12 Feb 2003 15:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbTBLU2j>; Wed, 12 Feb 2003 15:28:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:24039 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267624AbTBLU1z>;
	Wed, 12 Feb 2003 15:27:55 -0500
Date: Wed, 12 Feb 2003 12:36:29 -0800
From: Andrew Morton <akpm@digeo.com>
To: Siim Vahtre <siim@pld.ttu.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unable to mount 'remote' loopback block devices
Message-Id: <20030212123629.6b3bfd33.akpm@digeo.com>
In-Reply-To: <Pine.SOL.4.31.0302120007020.28624-100000@pitsa.pld.ttu.ee>
References: <Pine.SOL.4.31.0302120007020.28624-100000@pitsa.pld.ttu.ee>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Feb 2003 20:37:39.0196 (UTC) FILETIME=[9572D3C0:01C2D2D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siim Vahtre <siim@pld.ttu.ee> wrote:
>
> 
> Hi,
> 
> When I try to mount a 'remote' image (on NFS/samba share) I get
> "ioctl: LOOP_SET_FD: Inappropriate ioctl for device"
> 
> However, when I copy that same image to local hd, it works.
> 
> 2.5.59 and 2.5.60 both have the same problem, 2.4 was OK.

This broke when the loop driver was converted to use the backing
filesystems's sendfile operation.  NFS, SMBFS and CIFS (at least) do not
implement sendfile, so none of them can now be looped upon.

Trond says we can get NFS sendfile working pretty easily.  As for the others,
we may need to revert the loop change.
