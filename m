Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292964AbSBVThN>; Fri, 22 Feb 2002 14:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292963AbSBVTgy>; Fri, 22 Feb 2002 14:36:54 -0500
Received: from varenorn.icemark.net ([212.40.16.200]:21654 "EHLO
	varenorn.internal.icemark.net") by vger.kernel.org with ESMTP
	id <S292961AbSBVTgs>; Fri, 22 Feb 2002 14:36:48 -0500
Date: Fri, 22 Feb 2002 20:34:02 +0100 (CET)
From: Benedikt Heinen <beh@icemark.net>
X-X-Sender: beh@berenium.icemark.ch
To: Thomas Hood <jdthood@mail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17: oops in kapm-idled?   (on IBM Thinkpad A30P [2653-66U])
In-Reply-To: <1014400995.1811.30.camel@thanatos>
Message-ID: <Pine.LNX.4.44.0202222029550.1126-100000@berenium.icemark.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Trying to suspend my A30P, the screen goes black, and then about a
> > second later, I have this on the console (and syslog of course):
> [...]
> >
> > EIP:    0010:[<f882a876>]    Tainted: PF
> What kernel modules do you have loaded when this happens?

These:

	beh@berenium:~ $ /sbin/lsmod
	Module                  Size  Used by    Tainted: PF
	snd-card-intel8x0       8288   0
	snd-pcm-oss            34944   0 (unused)
	snd-mixer-oss           8864   0 [snd-pcm-oss]
	snd-pcm                45760   0 [snd-card-intel8x0 snd-pcm-oss]
	snd-timer               9760   0 [snd-pcm]
	snd-ac97-codec         22720   0 [snd-card-intel8x0]
	snd                    23368   0 [snd-card-intel8x0 snd-pcm-oss snd-mixer-oss snd-pcm snd-timer snd-ac97-codec]
	soundcore               3268   3 [snd]
	xsvc                   21864   2 (autoclean)
	vmnet                  18016   6
	vmmon                  18228   0 (unused)
	ds                      6368   2
	yenta_socket            8384   2
	pcmcia_core            37568   0 [ds yenta_socket]
	nfsd                   64768   1 (autoclean)
	lockd                  46624   1 (autoclean) [nfsd]
	sunrpc                 57428   1 (autoclean) [nfsd lockd]
	dummy                    960   0 (unused)
	e100                   60228   1
	beh@berenium:~ $ su -

Note:
	snd-*		-> ALSA 0.9.0beta9
	e100		-> EtherExpress Pro driver from Intel,
			   compiled from the debian e100-source package
	xsvc		-> Summit (Accelerated X) driver
			   The problem also occurs without it;
			   Just trying Accelerated X since I can't get
			   agpgart+XFree86+DRI to run...  agpgart fails
			   on modprobe... :/
	vmnet/vmmon	-> VMware 3.0
	pcmcia stuff	-> pcmcia-cs-3.1.31




Hope this helps...

	Benedikt

  BEAUTY, n.  The power by which a woman charms a lover and terrifies a
    husband.
			(Ambrose Bierce, The Devil's Dictionary)

