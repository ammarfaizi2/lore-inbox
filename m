Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316632AbSFQRN6>; Mon, 17 Jun 2002 13:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316644AbSFQRN5>; Mon, 17 Jun 2002 13:13:57 -0400
Received: from pat.uio.no ([129.240.130.16]:29416 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S316632AbSFQRNy>;
	Mon, 17 Jun 2002 13:13:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Roberto Nibali <ratz@drugphish.ch>
Subject: Re: NFS (vfs-related) syscall logging
Date: Mon, 17 Jun 2002 19:13:53 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <3D0A5E64.3020705@drugphish.ch> <shsadpv7y3y.fsf@charged.uio.no> <3D0E10BA.3010604@drugphish.ch>
In-Reply-To: <3D0E10BA.3010604@drugphish.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206171913.53561.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 June 2002 18:39, Roberto Nibali wrote:
> > efficient to log using 'tcpdump' (and the libpcap binary format)
> > instead of all those printks.
>
> Can't do that, company policy and I doubt this would be more efficient
> since you need a damn intelligent parser to get the same information
> from a packet dump.

'ethereal' *is* a damned intelligent parser that understands RPC/NFS/... ;-)
You should be able to use its read filtering capabilities to cherry-pick 
exactly the information that interests you.

>
> But thanks for your input. Maybe you or someone else would be able to
> give me a response to my other questions too, if possible. I'd really
> appreciate it.

If you are going to insist on logging using printks, you might as well just 
use the existing RPC debugging code. Just rewrite your printks to the format

dfprintk(BITMASK, format,...)

The value of BITMASK can be whatever you want, although the masks between 
0x0001 and 0x0200 are already used by the existing nfsd debugging code (see 
include/linux/nfsd/debug.h).

Then just 'echo BITMASK >/proc/sys/sunrpc/nfsd_debug' in order to begin 
logging.

Cheers,
  Trond
