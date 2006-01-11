Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbWAKNe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbWAKNe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWAKNe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:34:29 -0500
Received: from cernmx05.cern.ch ([137.138.166.161]:57025 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1751419AbWAKNe3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:34:29 -0500
Keywords: CERN SpamKiller Note: -51 Charset: west-latin
X-Filter: CERNMX05 CERN MX v2.0 051012.1312 Release
In-Reply-To: <1136983910.2929.39.camel@laptopd505.fenrus.org>
References: <20060111123745.GB30219@lgb.hu> <1136983910.2929.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3--234530370"
Message-Id: <4653C70B-04C2-4165-A073-24C6CD21214E@e18.physik.tu-muenchen.de>
Cc: lgb@lgb.hu, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: Re: OT: fork(): parent or child should run first?
Date: Wed, 11 Jan 2006 14:34:19 +0100
To: Arjan van de Ven <arjan@infradead.org>
X-Pgp-Agent: GPGMail 1.1 (Tiger)
X-Mailer: Apple Mail (2.746.2)
X-OriginalArrivalTime: 11 Jan 2006 13:34:24.0310 (UTC) FILETIME=[BC70BD60:01C616B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-3--234530370
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hi Arjan!

On 11 Jan 2006, at 13:51, Arjan van de Ven wrote:

> you just cannot depend on which would run first, child or parent. Even
> if linux would do it the other way around, you have no guarantee.  
> Think
> SMP or Dual Core processors and time slices and cache misses... your
> code just HAS to be able to cope with it. Even on solaris ;)

That means that the starting of the child process needs to be  
synchronized by the application itself. I tried it once but then I  
discovered that my case was easily solved in a completely different  
way (it was a very small project). However, which one is the easiest/ 
fastest way to do this synchronization? Using SysV-Semaphores? Pipes?  
Would something like this work?

int fd[2], pid;

pipe(fd);
pid = fork();
if (pid < 0) {
   error();
} else if (pid == 0) {
   close(fd[1]);
   read(fd[0]);
   close(fd[0]);
   child_code();
} else {
   store_pid();
   close(fd[0]);
   close(fd[1]); // this should wake up the child, right?
}

This should ensure that store_pid() is executed before child_code()...

Ciao,
                     Roland

--
TU Muenchen, Physik-Department E18, James-Franck-Str., 85748 Garching
Telefon 089/289-12575; Telefax 089/289-12570
--
UNIX was not designed to stop you from doing stupid things, because that
would also stop you from doing clever things.
	-Doug Gwyn
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GS/CS/M/MU d-(++) s:+ a-> C+++ UL++++ P+++ L+++ E(+) W+ !N K- w--- M 
+ !V Y+
PGP++ t+(++) 5 R+ tv-- b+ DI++ e+++>++++ h---- y+++
------END GEEK CODE BLOCK------





--Apple-Mail-3--234530370
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Darwin)

iD8DBQFDxQlfI4MWO8QIRP0RAsonAJ9hAg+X0TIMxZ1A6DqHBuYrr6V8CACfRQ1Q
XU2FtFTnqZgSMc0RrvaRAlI=
=RtIU
-----END PGP SIGNATURE-----

--Apple-Mail-3--234530370--
