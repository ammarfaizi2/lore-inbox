Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVFPWmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVFPWmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVFPWlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:41:22 -0400
Received: from relay.snowman.net ([66.92.160.56]:61457 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id S261849AbVFPWeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:34:02 -0400
Date: Thu, 16 Jun 2005 18:33:57 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, laforge@netfilter.org,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: Shouldn't we be using alloc_skb/kfree_skb in net/ipv4/netfilter/ipt_recent.c::ip_recent_ctrl ?
Message-ID: <20050616223357.GR30011@ns.snowman.net>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, laforge@netfilter.org,
	Jesper Juhl <juhl-lkml@dif.dk>
References: <Pine.LNX.4.62.0506170025140.2477@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FpMH1X0+ap4szZ+d"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506170025140.2477@dragon.hyggekrogen.localhost>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 18:31:45 up 5 days, 14:52,  5 users,  load average: 0.35, 0.25, 0.14
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FpMH1X0+ap4szZ+d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings,

* Jesper Juhl (juhl-lkml@dif.dk) wrote:
> I was just grep'ing through the source looking for places where skb's=20
> might be freed by plain kfree() and, amongst other things, I noticed=20
> net/ipv4/netfilter/ipt_recent.c::ip_recent_ctrl, where a struct sk_buff*=
=20
> is defined and then storage for it is allocated with kmalloc() and freed=
=20
> with kfree(), and I'm wondering if we shouldn't be using=20
> alloc_skb/kfree_skb instead (as pr the patch below)? Or is there some goo=
d=20
> reason for doing it the way it's currently done?

  This sounds reasonable to me.  I'm about 99% sure I just based that
  usage off some other usage in the kernel I found back when I
  originally wrote the module.

  So, for what it's worth I suppose (if anything, and I'm probably not
  doing it right anyway)-

Signed-off-by: Stephen Frost <sfrost@snowman.net>

		Enjoy,

			Stephen

> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> ---
>=20
>  net/ipv4/netfilter/ipt_recent.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> --- linux-2.6.12-rc6-mm1-orig/net/ipv4/netfilter/ipt_recent.c	2005-06-12 =
15:58:58.000000000 +0200
> +++ linux-2.6.12-rc6-mm1/net/ipv4/netfilter/ipt_recent.c	2005-06-16 23:41=
:55.000000000 +0200
> @@ -303,7 +303,7 @@ static int ip_recent_ctrl(struct file *f
>  	strncpy(info->name,curr_table->name,IPT_RECENT_NAME_LEN);
>  	info->name[IPT_RECENT_NAME_LEN-1] =3D '\0';
> =20
> -	skb =3D kmalloc(sizeof(struct sk_buff),GFP_KERNEL);
> +	skb =3D alloc_skb(sizeof(struct sk_buff),GFP_KERNEL);
>  	if (!skb) {
>  		used =3D -ENOMEM;
>  		goto out_free_info;
> @@ -322,7 +322,7 @@ static int ip_recent_ctrl(struct file *f
> =20
>  	kfree(skb->nh.iph);
>  out_free_skb:
> -	kfree(skb);
> +	kfree_skb(skb);
>  out_free_info:
>  	kfree(info);
> =20
>=20

--FpMH1X0+ap4szZ+d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCsf5VrzgMPqB3kigRApsGAJ4yGLxWUfZKIbJVLvDuiem0DRfh7wCeLjhh
YXsZjWAmWKAkQbzKQT67nMY=
=YekI
-----END PGP SIGNATURE-----

--FpMH1X0+ap4szZ+d--
