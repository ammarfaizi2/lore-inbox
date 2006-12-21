Return-Path: <linux-kernel-owner+w=401wt.eu-S1422665AbWLUDhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWLUDhh (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422671AbWLUDhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:37:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55203 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422647AbWLUDhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:37:34 -0500
Subject: Re: Network drivers that don't suspend on interface down
From: Dan Williams <dcbw@redhat.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Daniel Drake <dsd@gentoo.org>, Michael Wu <flamingice@sourmilk.net>,
       Stephen Hemminger <shemminger@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20061221032547.GB1277@srcf.ucam.org>
References: <20061220042648.GA19814@srcf.ucam.org>
	 <20061220144906.7863bcd3@dxpl.pdx.osdl.net>
	 <20061221011209.GA32625@srcf.ucam.org>
	 <200612202105.31093.flamingice@sourmilk.net>
	 <20061221021832.GA723@srcf.ucam.org> <4589F39C.7010201@gentoo.org>
	 <20061221024533.GA1025@srcf.ucam.org> <4589FAA6.509@gentoo.org>
	 <20061221032547.GB1277@srcf.ucam.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 22:37:57 -0500
Message-Id: <1166672277.23168.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-21 at 03:25 +0000, Matthew Garrett wrote:
> On Wed, Dec 20, 2006 at 10:08:22PM -0500, Daniel Drake wrote:
> > Matthew Garrett wrote:
> > >Hm. Does the spec not set any upper bound on how long it might take for 
> > >APs to respond? I'm afraid that my 802.11 knowledge is pretty slim. 
> > 
> > I'm not sure, but thats not entirely relevant either.  The time it takes 
> > for the AP to respond is not related to the delay between userspace 
> > sending the siwscan and giwscan ioctls (unless you're thinking of 
> > userspace being too quick, but GIWSCAN already returns -EINPROGRESS when 
> > appropriate so this is detectable)
> 
> Ah - I've mostly been looking at the ipw* drivers, where giwscan just 
> seems to return information cached by the ieee80211 layer. A quick scan 
> suggests that most cards behave like this, but prism54 seems to refer to 
> the hardware. I can see why that would cause problems.

Prism54 (fullmac) does background scanning all the time when the
interface is up.  You can't turn it off AFAIK.  If you look at SIWSCAN,
you'll see that it's essentially a NOP since the firmware is always
scanning, and you'll always have up-to-date scan results.  Ideally, all
drivers would do it like prism54 does (and some later ipw versions, I
think).

Dan

> 
> > I think it's reasonable to keep the interface down, but then when the 
> > user does want to connect, bring the interface up, scan, present scan 
> > results. Scanning is quick, there would be minimal wait needed here.
> 
> Yeah, that's true.
> 

