Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272751AbRILLNV>; Wed, 12 Sep 2001 07:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272749AbRILLNL>; Wed, 12 Sep 2001 07:13:11 -0400
Received: from pat.uio.no ([129.240.130.16]:33423 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S272751AbRILLMx>;
	Wed, 12 Sep 2001 07:12:53 -0400
To: Marcus Sundberg <marcus@cendio.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs is stupid ("getfh failed")
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman>
	<15261.47176.73283.841982@notabene.cse.unsw.edu.au>
	<vebskgpu32.fsf@inigo.sthlm.cendio.se>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 12 Sep 2001 13:13:12 +0200
In-Reply-To: Marcus Sundberg's message of "12 Sep 2001 12:44:01 +0200"
Message-ID: <shsvgiohdbr.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Marcus Sundberg <marcus@cendio.se> writes:

     > neilb@cse.unsw.edu.au (Neil Brown) writes:
    >> On September 10, marcus@cendio.se wrote:
    >> > cachefs sucks. It doesn't seem to cache stat(2) information.
    >> > Doing ls -F in a ~100-entries directory takes several seconds
    >> > over a link with 50ms round-trip time.
    >>
    >> Well, I said "concept" not "implementation", but I suspect that
    >> Solaris cachefs does cache stat information.  Maybe you just
    >> need to increase the timeouts for the attribute cache.

     > Considering that I did several ls'es on the order of
     > milliseconds apart I doubt that would help...

The NFS close-to-open cache consistency requirement forces them to
compare the attribute cache to the server every time someone does a
call to open(). This is true whether or not one uses cachefs.

After the file has actually been opened, you can call fstat() as many
times as you like. The cached attributes to be used, and they will
then be checked on the server only after the cache times out.

Cheers,
   Trond
