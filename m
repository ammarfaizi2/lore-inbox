Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272363AbTGaAaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272366AbTGaAaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:30:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:55003 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S272363AbTGaA3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:29:38 -0400
Date: Wed, 30 Jul 2003 20:27:58 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: James Morris <jmorris@intercode.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1 & ipsec-tools (xfrm_type_2_50?)
In-Reply-To: <Mutt.LNX.4.44.0307310959390.20194-100000@excalibur.intercode.com.au>
Message-ID: <Pine.LNX.4.56.0307302019430.9619@onqynaqf.yrkvatgba.voz.pbz>
References: <Mutt.LNX.4.44.0307310959390.20194-100000@excalibur.intercode.com.au>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003, James Morris wrote:

> > most of the module not found messages are fine, its xfrm_type_2_50 that
> > I'm worried about... What am I missing ?
>
> Possibly some aliases in /etc/modprobe.conf
>
> alias xfrm-type-2-50    esp4
> alias xfrm-type-2-51    ah4
> alias xfrm-type-2-108   ipcomp
> alias xfrm-type-10-50   esp6
> alias xfrm-type-10-51   ah6
> alias xfrm-type-10-108  ipcomp6

Well, I'll be...  I grepped through both the kernel and ipsec-tools
source (and google) and completely missed that - where did you find it ?

THANKS !!!

Now, that allows me to actually make the connection (after changing from
transport to tunnel mode), and actually use it :)

But I'm not out of the woods yet...
Something is getting lost wrt tracking IPSEC packets; my log is very
full of the following:

Jul 31 00:16:14 renegade kernel: nf_hook: hook 0 already set.
Jul 31 00:16:14 renegade kernel: skb: pf=2 (unowned) dev=eth0 len=52
Jul 31 00:16:14 renegade kernel: PROTO=6 9.51.94.26:23 9.30.62.131:34521
L=52 S=0x10 I=14806 F=0x4000 T=64
Jul 31 00:16:14 renegade kernel: nf_hook: hook 1 already set.
Jul 31 00:16:14 renegade kernel: skb: pf=2 (unowned) dev=eth0 len=52
Jul 31 00:16:14 renegade kernel: PROTO=6 9.51.94.26:23 9.30.62.131:34521
L=52 S=0x10 I=14806 F=0x4000 T=64
Jul 31 00:16:14 renegade kernel: nf_hook: hook 0 already set.
Jul 31 00:16:14 renegade kernel: skb: pf=2 (unowned) dev=eth0 len=52
Jul 31 00:16:14 renegade kernel: PROTO=6 9.51.94.26:23 9.30.62.131:34521
L=52 S=0x10 I=14807 F=0x4000 T=64
Jul 31 00:16:14 renegade kernel: nf_hook: hook 1 already set.
Jul 31 00:16:14 renegade kernel: skb: pf=2 (unowned) dev=eth0 len=52
Jul 31 00:16:14 renegade kernel: PROTO=6 9.51.94.26:23 9.30.62.131:34521
L=52 S=0x10 I=14807 F=0x4000 T=6

-- 
Rick Nelson
I can saw a woman in two, but you won't want to look in the box when I do
'For My Next Trick I'll Need a Volunteer' -- Warren Zevon
