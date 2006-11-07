Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753454AbWKGVzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbWKGVzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbWKGVzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:55:07 -0500
Received: from mx1.suse.de ([195.135.220.2]:31109 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753245AbWKGVzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:55:04 -0500
Date: Tue, 7 Nov 2006 13:54:44 -0800
From: Seth Arnold <seth.arnold@suse.de>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       chris friedhoff <chris@friedhoff.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1] security: introduce file posix caps
Message-ID: <20061107215444.GO30208@suse.de>
Mail-Followup-To: "Serge E. Hallyn" <serue@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	Stephen Smalley <sds@tycho.nsa.gov>,
	James Morris <jmorris@namei.org>,
	chris friedhoff <chris@friedhoff.org>,
	Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>
References: <20061107034550.GA13693@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dOjmQabedpZXoTR3"
Content-Disposition: inline
In-Reply-To: <20061107034550.GA13693@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dOjmQabedpZXoTR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2006 at 09:45:50PM -0600, Serge E. Hallyn wrote:
>  #define CAP_AUDIT_CONTROL    30
> =20
> +#define CAP_NUMCAPS	     31

[...]

> +struct vfs_cap_data_struct {
> +	__u32 version;
> +	__u32 effective;
> +	__u32 permitted;
> +	__u32 inheritable;
> +};

[...]

> +static int check_cap_sanity(struct vfs_cap_data_struct *cap)
> +{
> +	int i;
> +
> +	if (cap->version !=3D _LINUX_CAPABILITY_VERSION)
> +		return -EPERM;
> +
> +	for (i=3DCAP_NUMCAPS; i<sizeof(cap->effective); i++) {
> +		if (cap->effective & CAP_TO_MASK(i))
> +			return -EPERM;
> +	}
> +	for (i=3DCAP_NUMCAPS; i<sizeof(cap->permitted); i++) {
> +		if (cap->permitted & CAP_TO_MASK(i))
> +			return -EPERM;
> +	}
> +	for (i=3DCAP_NUMCAPS; i<sizeof(cap->inheritable); i++) {
> +		if (cap->inheritable & CAP_TO_MASK(i))
> +			return -EPERM;
> +	}
> +
> +	return 0;
> +}

for (i=3D31; i<4; i++) ...

I'm not sure this checks what you think it checks? :)

Thanks

--dOjmQabedpZXoTR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFFUQCk+9nuM9mwoJkRAnOYAKCgXWFlHKLXbfdbJNbTXf2ns6z/EwCZAcub
5t+661cnwX0v5xOjVw8z8Tw=
=+zZH
-----END PGP SIGNATURE-----

--dOjmQabedpZXoTR3--
