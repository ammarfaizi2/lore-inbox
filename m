Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130251AbRBLTJQ>; Mon, 12 Feb 2001 14:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131468AbRBLTI5>; Mon, 12 Feb 2001 14:08:57 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:10231 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S130251AbRBLTIp>; Mon, 12 Feb 2001 14:08:45 -0500
Date: Mon, 12 Feb 2001 15:27:07 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org, jschlst@turbolinux.com,
        Andrew Morton <andrewm@uow.edu.au>,
        "Bryan K. Walton" <bryan@bryansweb.com>,
        Russell Coker <russell@coker.com.au>, dahinds@sourceforge.net,
        kuznet@ms2.inr.ac.ru, jgarzik@mandrakesoft.com
Subject: Re: [PATCH] to deal with bad dev->refcnt in unregister_netdevice()
Message-ID: <20010212152707.B31354@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>,
	linux-kernel@vger.kernel.org, jschlst@turbolinux.com,
	Andrew Morton <andrewm@uow.edu.au>,
	"Bryan K. Walton" <bryan@bryansweb.com>,
	Russell Coker <russell@coker.com.au>, dahinds@sourceforge.net,
	kuznet@ms2.inr.ac.ru, jgarzik@mandrakesoft.com
In-Reply-To: <3A8831D2.7EDB25D3@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <3A8831D2.7EDB25D3@yahoo.co.uk>; from jdthoodREMOVETHIS@yahoo.co.uk on Mon, Feb 12, 2001 at 01:56:18PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 12, 2001 at 01:56:18PM -0500, Thomas Hood escreveu:
> Sorry, but it turns out that the bug is not completely
> fixed by the change that acme made.  With the change,
> ifup-ing and if-downing eth0 with the ipx module loaded
> no longer reduces eth0's refcnt to an indefinitely low
> (larger and larger negative) number.  However if the ipx
> module is loaded first and ipx configured on eth0, and
> then the network card inserted and "ifconfig eth0 up" done,
> and then "ifconfig eth0 down" done, then once again the
> refcnt is too low, so that when I try to "cardctl eject"
> my ethernet card, "modprobe -r xirc2ps_cs" hangs up.
> This whole business of refcnts needs to be thought 
> through more carefully.

As I've told in the message I've sent, I'm unfortunately damn busy these
days and wrote this patch in a hurry, was waiting for your feedback to see
if it fixed the problem or not, but it was applied because it seemed
obviously correct. I'll try to work on this as soon as possible, but this
can take some time.

- Arnaldo
 
> > This bug was fixed by "acme" in 2.4.1-ac10.  :)
> > The ipx driver now increments refcnt on NETDEV_UP to
> > match downing the interface on NETDEV_DOWN.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
