Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290934AbSASLPs>; Sat, 19 Jan 2002 06:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290935AbSASLPf>; Sat, 19 Jan 2002 06:15:35 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:8618 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S290934AbSASLPX>; Sat, 19 Jan 2002 06:15:23 -0500
Date: Sat, 19 Jan 2002 13:15:11 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020119111511.GC135220@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain> <Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com> <a2afsg$73g$2@ncc1701.cistron.net> <a2almg$vtl$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2almg$vtl$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 06:29:36PM -0800, you [H. Peter Anvin] said:
> 
> This *might* work:
> 
> link("/proc/self/fd/40", newpath);

I don't think so: firstly, it would create a cross device link and secondly,
/proc/<pid>/fd/* are symbolic links. See:

/tmp>while true; do sleep 1; echo kukkanen; done > r &
[1] 19925
/tmp>L /proc/19925/fd 
total 0
lrwx------    1 root     root           64 Jan 19 13:10 0 -> /dev/pts/7
l-wx------    1 root     root           64 Jan 19 13:10 1 -> /tmp/r
lrwx------    1 root     root           64 Jan 19 13:10 2 -> /dev/pts/7
/tmp>rm r               
/tmp>L /proc/19925/fd
total 0
lrwx------    1 root     root           64 Jan 19 13:10 0 -> /dev/pts/7
l-wx------    1 root     root           64 Jan 19 13:10 1 -> /tmp/r (deleted)
lrwx------    1 root     root           64 Jan 19 13:10 2 -> /dev/pts/7
/tmp>ln /proc/19925/fd/1 r2
ln: /proc/19925/fd/1: warning: making a hard link to a symbolic link is not portable
ln: create hard link `r2' to `/proc/19925/fd/1': Invalid cross-device link

I think one has to use lsof, ps and/or fuser and then kill.


-- v --

v@iki.fi
