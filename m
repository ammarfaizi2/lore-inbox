Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286962AbSBBWTM>; Sat, 2 Feb 2002 17:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292402AbSBBWTC>; Sat, 2 Feb 2002 17:19:02 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:24988 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S286962AbSBBWSu>;
	Sat, 2 Feb 2002 17:18:50 -0500
Date: Sat, 2 Feb 2002 23:18:48 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: SIOCDEVICE ?
Message-ID: <20020202231848.A5644@fafner.intra.cogenit.fr>
In-Reply-To: <200201311304.FAA00344@adam.yggdrasil.com> <20020131181241.A3524@fafner.intra.cogenit.fr> <m3665iqhqn.fsf@defiant.pm.waw.pl> <20020202154424.A5845@fafner.intra.cogenit.fr> <20020202154348.A26147@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020202154348.A26147@havoc.gtf.org>; from garzik@havoc.gtf.org on Sat, Feb 02, 2002 at 03:43:48PM -0500
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <garzik@havoc.gtf.org> :
> On Sat, Feb 02, 2002 at 03:44:24PM +0100, Francois Romieu wrote:
> > Your patch doesn't apply against 2.5.3. I did a quick update and noticed the
> > patch is the sole user of SIOCDEVICE (with dscc4) and SIOCDEVPRIVATE.
> 
> SIOCDEVPRIVATE is verboten in 2.5.x, it doesn't pass through ioctl
> translation layers like that which exists on sparc64 and ia64; they are
> untyped awful interfaces.
> 
> The correction would perhaps define a real command as needed...

Yes, I've seen the big fat comment in include/linux/sockios.h for
SIOCDEVPRIVATE. I can only infer that SIOCDEVICE isn't allowed any more
as it seems it sneakly escaped from the kernel sources. 

<executive summary of Krzysztof Halasa's update>
The struct hdlc_device_struct offers under an union the protocol specific 
(raw hdlc, frame relay, cisco, pppsync (1)) parameters of the interface. 
Those are set from userspace through ifreq.ifr_settings.data and an 
ifreq.ifr_settings.type of IF_PROTO_{HDLC/CISCO/FR/X25},... resp. which 
specifies the size of the expected data (2).
You retrieve it from userspace with IF_GET_PROTO.
Once an interface is configured for frame-relay, pvc creation/deletion is
done with IF_PROTO_FR_{ADD/DEL}_PVC.

(1) Let's forget pppsync and it's revolting games with net_device.priv for now.
(2) ifr->ifr_settings.data_length checking duplication should be avoided imho.

</summary>

As this question was postponed until 2.5, I'd like someone to state what the 
accepted api will be.

Let's hope it's not too much on-topic. :o)

-- 
Ueimor
