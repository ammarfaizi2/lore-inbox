Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268042AbUJLWir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268042AbUJLWir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUJLWg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:36:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29121 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268045AbUJLWfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:35:51 -0400
Message-ID: <416C5C26.9020403@redhat.com>
Date: Tue, 12 Oct 2004 15:35:18 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041010
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] lsm: add bsdjail module
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041010104113.GC28456@infradead.org> <1097502444.31259.19.camel@localhost.localdomain> <20041012131124.GA2484@IBM-BWN8ZTBWA01.austin.ibm.com>
In-Reply-To: <20041012131124.GA2484@IBM-BWN8ZTBWA01.austin.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Serge E. Hallyn wrote:

> +If a private IP was specified for the jail, then
> +		cat /proc/$$/attr/current

How is this going to interact with SELinux?  Currently SELinux uses
/proc/*/attr/current to report the current security context of the
process.  libselinux expects the file to contain one string (not even a
newline) which is the textual representation of the context.  Now with
your changes you want to change this.  libselinux as-is would break
miserably.

I don't know the history of the file and who is hijacking the file.
Fact is that the file content is currently unstructured and libselinux
couldn't possibly determine what part is of interest to itself.

So, either you use another file, SELinux uses another file, or the file
gets tagged lines like

  selinux: user_u:user_r:user_t

I guess you couldn't even start the userlevel code in FC3 in such a jail
in the moment since the libselinux startup tests would fail.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBbFwm2ijCOnn/RHQRAvimAJ9W3bIil5Yi1Ex/CX1FpUjzxyheIQCeNKRu
RHv5SGG0iQSEsmbIWfHmwAA=
=HZM3
-----END PGP SIGNATURE-----
