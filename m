Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135903AbRD0ET5>; Fri, 27 Apr 2001 00:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135910AbRD0ETr>; Fri, 27 Apr 2001 00:19:47 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:18190 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S135903AbRD0ETf>;
	Fri, 27 Apr 2001 00:19:35 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15080.62346.34932.272251@argo.ozlabs.ibm.com.au>
Date: Fri, 27 Apr 2001 14:20:26 +1000 (EST)
To: William Ie <wie@CS.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
Subject: Re: [CHECKER] security rules?
In-Reply-To: <Pine.GSO.4.21.0104261426520.18211-100000@Xenon.Stanford.EDU>
In-Reply-To: <200104130947.CAA21780@csl.Stanford.EDU>
	<Pine.GSO.4.21.0104261426520.18211-100000@Xenon.Stanford.EDU>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Ie writes:

> 4.linux/2.4.3/drivers/net/ppp_async.c:345:ppp_async_ioctl
> case PPPIOCGFLAGS:
> 		val = ap->flags | ap->rbits;
> 		if (put_user(val, (int *) arg))
> 			break;
> 		err = 0;
> 		break;
> case PPPIOCSFLAGS:
> 		if (get_user(val, (int *) arg))
> 			break;
> 		ap->flags = val & ~SC_RCV_BITS;
> 		spin_lock_bh(&ap->recv_lock);
> 		ap->rbits = val & SC_RCV_BITS;
> 		spin_unlock_bh(&ap->recv_lock);
> 		err = 0;
> 		break;
> seems to be getting and setting some flags without CAP_NET_ADMIN like in
> ppp_synctty.c

It is OK because this is a channel ioctl routine called from
ppp_generic.c as a result of an ioctl call on /dev/ppp, and it is not
possible to open /dev/ppp unless you have CAP_NET_ADMIN.

Paul.
