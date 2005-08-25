Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVHYON3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVHYON3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVHYON3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:13:29 -0400
Received: from sipsolutions.net ([66.160.135.76]:23815 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S965003AbVHYON2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:13:28 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: Johannes Berg <johannes@sipsolutions.net>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Robert Love <rml@novell.com>, Reuben Farrelly <reuben-lkml@reub.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1124978783.5039.29.camel@vertex>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124972307.6307.30.camel@localhost>
	 <1124977253.5039.13.camel@vertex>  <1124977672.32272.10.camel@phantasy>
	 <1124978614.6301.44.camel@localhost>  <1124978783.5039.29.camel@vertex>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EJSDJnLbQiBP1fIEpM7Y"
Date: Thu, 25 Aug 2005 16:13:13 +0200
Message-Id: <1124979193.19546.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EJSDJnLbQiBP1fIEpM7Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-25 at 10:06 -0400, John McCutchan wrote:
> > it fails on 2.6.13-rc6 as soon as the device is full and doesn't hold
> > any more directories.

Obviously this wasn't true, I was hitting the 8192 watches limit and
misinterpreted the error message. I just tested up to 100000 watches
with this program.

> Could you send me the new test program?

Below.

johannes

/* Author: Johannes Berg <johannes@sipsolutions.net>
 *
 * This is another small inotify test program that simply
 * repeatedly adds watches.
 */

#include <stdio.h>
#include <linux/inotify.h>
#include <linux/inotify-syscalls.h>

int main()
{
	int fd;
	int wd1, wd2;
	int ret, i =3D 0;
	char buf[1024];

	fd =3D inotify_init();

	if (fd < 0)
		perror("inotify_init");

	printf("inotify_init returned fd %d\n", fd);
=09
	mkdir("/tmp/inotify-test-dir-rm-rf-this", 0777);

	while (1) {
		i++;
		snprintf(buf,sizeof(buf),"/tmp/inotify-test-dir-rm-rf-this/%d",i>>10);
		mkdir(buf,0777);
		snprintf(buf,sizeof(buf),"/tmp/inotify-test-dir-rm-rf-this/%d/%d",i>>10,i=
);
		mkdir(buf, 0777);
		wd1 =3D inotify_add_watch(fd, buf, IN_ALL_EVENTS);

		if (wd1 < 0) {
			perror("inotify_add_watch");
			break;
		}
		printf("inotify_add_watch returned wd1 %d\n", wd1);
	}
}


--=-EJSDJnLbQiBP1fIEpM7Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQw3R+KVg1VMiehFYAQKThA//RkVsj+XOArzq7CYzWDBXKxa7HiKrk67T
L876r3vUtKC3lAaA6WUOk4c+vQIGT2HM2rtjyNtMPSLw7YAsSX4dJqocXowD9UMQ
oCBA6iMqmIcitP+8HjyP4YNfAEmFYHWelp3hRpCU7uH2y+vY6Lc3sF5AT/P4ijxS
ay7OJKJQQcn0PQvBFFI5QnGCxaPxgLdYCzerKKhyn+xYehbXW1MDKcjM3F0ptmR2
hlpSsGG1Rw23jvBnP7DCE5lNoqVsq2sev+eDDeGxgXgUeTh0P0KVPOwppknS15St
GbC4/BPjnh2CqlzKKt7UOJz6gPcRwoRzHRsQYLOuPhoFpQ0iDFBpfF43xU2ogAZj
1IFo3VNIwTRnYcvQtoQmBQ0CqNrO7TlBQ36m8PWOItv+us6WkJZ4q7GSiX/bmdCK
xoNJxTZGTaOebpnmF3pS6Wm3e51rjOe09Ox+jQoztm+rynqrbDUa+z+rnwwgiR68
YehUd5ayiAWNCYhOseVZ48bVFH1jctuAzKDxJ4B01CgJTuR9Gvod0sOxsek/EG5d
3SkdWoses4LkFWy3HtkkjdqMDRpoSbPDzV387GTl/jqYhG89EHKk3HPNsTewbsRs
buW7wt5t+10JE5DQM5eAud7aF/vRmz+6NjWtIJh3lcqnFaoEtpqxDYi7408DPWo0
ESh5+kFZehU=
=B7bC
-----END PGP SIGNATURE-----

--=-EJSDJnLbQiBP1fIEpM7Y--

