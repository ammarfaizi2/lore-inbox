Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVAYEPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVAYEPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 23:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVAYEPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 23:15:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22658 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261799AbVAYEPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 23:15:40 -0500
Message-ID: <41F5C6D4.4030106@redhat.com>
Date: Mon, 24 Jan 2005 20:11:00 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 1/7] posix-timers: tidy up clock interfaces and consolidate
 dispatch logic
References: <200501232322.j0NNMcxe006476@magilla.sf.frob.com> <41F5ABB8.8070308@mvista.com>
In-Reply-To: <41F5ABB8.8070308@mvista.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig61B2E2032BA3F5B57AD93118"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig61B2E2032BA3F5B57AD93118
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

George Anzinger wrote:
> As I understand it modern machines, the indirect call does really bad 
> things to the pipeline.

Unless the call happens often, really often, you'll not be able to 
measure differences.  Indirect jump obviously cause pipeline stalls 
which often, but not always, can be avoided with direct calls.  But we 
are not talking here about huge delays.  And the delays are equivalent 
in cost to a mispredicted branch.  If you have a couple of ifs in a row 
you are likely to incur problems with the branch prediction.  I would 
just use the indirect jumps but if you want, do some timing and see 
whether you can filter the difference out of the noise.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖

--------------enig61B2E2032BA3F5B57AD93118
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFB9cbU2ijCOnn/RHQRAjUfAJ9IN5TfGyfuFfsWFKrsBpJACJy6BQCffjkt
LsoxrxP0/DwqvhXSQttBYMs=
=E5lI
-----END PGP SIGNATURE-----

--------------enig61B2E2032BA3F5B57AD93118--
