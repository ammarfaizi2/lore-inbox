Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbUJYNXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbUJYNXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUJYNXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:23:08 -0400
Received: from kone17.procontrol.vip.fi ([212.149.71.178]:60118 "EHLO
	danu.procontrol.fi") by vger.kernel.org with ESMTP id S261795AbUJYNWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:22:33 -0400
In-Reply-To: <20041025123722.GA5107@thunk.org>
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi> <20041025123722.GA5107@thunk.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-12-144261182"
Message-Id: <E933728A-2688-11D9-8AC3-000393CC2E90@iki.fi>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Timo Sirainen <tss@iki.fi>
Subject: Re: readdir loses renamed files
Date: Mon, 25 Oct 2004 16:22:25 +0300
To: "Theodore Ts'o" <tytso@mit.edu>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-12-144261182
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 25.10.2004, at 15:37, Theodore Ts'o wrote:

> This is not a bug; the POSIX specification explicitly allows this
> behavior.  If a filename is renamed during a readdir() session of a
> directory, it is undefined where that neither, either, or both of the
> new and old filenames will be returned.

BTW. Would be nice if this was mentioned in readdir(3) manual page. 
UNIX98 specs also didn't mention rename specifically, and I don't know 
of other freely available specs.

> And that's because there's no good way to do this without trashing the
> performance of the system, especially when most applications don't
> care.  (Do you really want your entire system running significantly
> slower, penalizing all other applications on your system, just because
> of one stupid/badly-written application?)  In order to do this, the
> kernel would have to atomically snapshot the directory --- even one
> which might be several megabytes in length, and store a copy of it in
> memory, while the application calls readdir().  Several processes
> could perform a denial-of-service attack by starting to call
> readdir(), and then stopping.  This would end up locking up huge
> amounts of non-pageable system memory, and cause the system to come
> down in a hurry.

That would be a generic kernel solution for it, but it's not what I'm 
asking.

Only thing needed not to lose the files would be that renamed files 
appeared always at the end of the readdir() list, or at the same 
location where the original file was. But apparently that's not how 
filesystems nowadays implement it, and probably not very simple to 
change to work that way.

--Apple-Mail-12-144261182
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (Darwin)

iD8DBQFBfP4RyUhSUUBViskRAlYnAJ9vqrITze9HKTHr8RWDGO4nj7ftJACgpmrm
8frr+RFC44KOty4h3Q1S4PY=
=S4Tj
-----END PGP SIGNATURE-----

--Apple-Mail-12-144261182--

