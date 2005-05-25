Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVEYSmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVEYSmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVEYSjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:39:42 -0400
Received: from mail.murom.net ([213.177.124.17]:15489 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S262392AbVEYSeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:34:07 -0400
Date: Wed, 25 May 2005 22:33:27 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: proper API for sched_setaffinity ?
Message-Id: <20050525223327.511ee381.vsu@altlinux.ru>
In-Reply-To: <4294BAD8.4030300@nortel.com>
References: <4294BAD8.4030300@nortel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__25_May_2005_22_33_27_+0400_38y6ryolXgyRyxsz"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__25_May_2005_22_33_27_+0400_38y6ryolXgyRyxsz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 25 May 2005 11:50:16 -0600 Chris Friesen wrote:

> On my system (Mandrake 10.0) the man page for sched_setaffinity() lists 
> the prototype as:
> 
> int  sched_setaffinity(pid_t  pid,  unsigned  int  len,  unsigned  long
>         *mask);
> 
> 
> But /usr/include/sched.h gives it as
> 
> extern int sched_setaffinity (__pid_t __pid, __const cpu_set_t *__mask)
> 
> Which is correct?

Here "man sched_setaffinity" says:

HISTORY
       The affinity syscalls were  introduced  in  Linux  kernel  2.5.8.   The
       library  calls  were  introduced  in  glibc 2.3, and are still in glibc
       2.3.2. Later glibc 2.3.2 development versions changed this interface to
       one without the len field, and still later versions reverted again. The
       glibc prototype is now

       /* Set the CPU affinity for a task */
       extern int sched_setaffinity (pid_t pid, size_t cpusetsize,
                                     const cpu_set_t *cpuset);

       /* Get the CPU affinity for a task */
       extern int sched_getaffinity (pid_t pid, size_t cpusetsize,
                                     cpu_set_t *cpuset);

So looks like you have a version of glibc with a broken interface (and
2.3.5 here has correct prototypes).

--Signature=_Wed__25_May_2005_22_33_27_+0400_38y6ryolXgyRyxsz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFClMT6W82GfkQfsqIRAvLJAJ9CApDnmFO1L5zRNbTwYy1l2iI2aACggXkO
GjypMH/Dud+31ouqZs/dNmE=
=yoGL
-----END PGP SIGNATURE-----

--Signature=_Wed__25_May_2005_22_33_27_+0400_38y6ryolXgyRyxsz--
