Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWJBUAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWJBUAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWJBUAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:00:15 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39862 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964929AbWJBUAN (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:00:13 -0400
Message-Id: <200610021957.k92Jvk6c004169@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: jt@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, Pavel Roskin <proski@gnu.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
In-Reply-To: Your message of "Mon, 02 Oct 2006 10:52:45 PDT."
             <20061002175245.GA14744@bougret.hpl.hp.com>
From: Valdis.Kletnieks@vt.edu
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu> <20060928202931.dc324339.akpm@osdl.org> <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu> <20060929124558.33ef6c75.akpm@osdl.org> <200609300001.k8U01sPI004389@turing-police.cc.vt.edu> <20060929182008.fee2a229.akpm@osdl.org>
            <20061002175245.GA14744@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159819066_3357P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 15:57:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159819066_3357P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Oct 2006 10:52:45 PDT, Jean Tourrilhes said:
> On Fri, Sep 29, 2006 at 06:20:08PM -0700, Andrew Morton wrote:
> > On Fri, 29 Sep 2006 20:01:54 -0400
> > > 
> > > % grep ioctl /tmp/foo2 | sort -u | more
> > > ioctl(13, SIOCGIWESSID, 0xbfbcdb9c)     = 0
> > > ioctl(13, SIOCGIWRANGE, 0xbfbcdbdc)     = 0
> > > ioctl(13, SIOCGIWRATE, 0xbfbcdbbc)      = 0
> > 
> > Yes.  The main thing which those WE-21 patches do is to shorten the size of
> > various buffers which are used in wireless ioctls.
> 
> 	Ok, I've found it. Actually, I feel ashamed, as it is a fairly
> classical buffer overflow, we put one extra char in a buffer. Now, I
> don't understand why it did not blow up on my box ;-)
> 	New patch. I think it is right, but I would not mind Pavel to
> have a look at it. On my box it does not make thing worse.
> 	Valdis : would you mind trying if this patch fix the problem
> you are seeing with WE-21 ? If it fixes it, I'll send it to John...

Been up and running with we-21 configured in, and gkrellm doing the monitoring
that gave it indigestion.  It was dying in 1-2 minutes, now been up for 30 mins
with no issues....

--==_Exmh_1159819066_3357P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFIW86cC3lWbTT17ARAm5YAKDhD4Cpy1VshSwCJRKNc+v0q4IHwACeJbTF
QD9vlJjo0NeVietrs44RLwE=
=rsmA
-----END PGP SIGNATURE-----

--==_Exmh_1159819066_3357P--
