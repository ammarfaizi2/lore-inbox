Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262003AbSJVCL3>; Mon, 21 Oct 2002 22:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSJVCL3>; Mon, 21 Oct 2002 22:11:29 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:1717 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S262046AbSJVCK3>; Mon, 21 Oct 2002 22:10:29 -0400
Message-ID: <3DB4B517.1070906@redhat.com>
Date: Mon, 21 Oct 2002 19:16:55 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021014
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sean finney <seanius@seanius.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: problem opening multiple pipes with pipe(2) in 2.4.1[78]
References: <20021021213220.A26136@sccs.swarthmore.edu>
In-Reply-To: <20021021213220.A26136@sccs.swarthmore.edu>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

sean finney wrote:

>
> int main(){
> 	int p1[2], p2[2];
> 	pipe(p1);
> 	perror("p1");
> 	pipe(p2);
> 	perror("p2");
> 	return 0;
> }


The fault is entirely yours.  You're not allowed to look at errno unless
a function, which is defined to modify error on failure, is reporting it
failed.  Both pipe() calls work just fine and errno has some random
value which happens to be ESPIPE for you.  Read the standard.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9tLUX2ijCOnn/RHQRAsAvAJoCBHjJY+Fw8ngfW2HeH8i1ozMenwCdH/Zd
49t/9uthYez2yYk4JoYgbrU=
=Ijan
-----END PGP SIGNATURE-----

