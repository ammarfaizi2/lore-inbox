Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVAZJof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVAZJof (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 04:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVAZJoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 04:44:34 -0500
Received: from acomp.externet.hu ([212.40.96.68]:681 "HELO www.acomp.hu")
	by vger.kernel.org with SMTP id S262075AbVAZJoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 04:44:25 -0500
Date: Wed, 26 Jan 2005 10:44:22 +0100
From: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: waiting for ppp0 to become free (Re: ppp0 out of control)
Message-ID: <20050126094422.GA31040@lk8rp.mail.xeon.eu.org>
Mail-Followup-To: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20050121144444.GA2100@roxor.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050121144444.GA2100@roxor.be>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-01-21 at 15:44:44, Aurélien GÉRÔME wrote:
> I am running 2.6.10 from kernel.org on Debian Sid ppc/x86, the same
> issue occurs with 2.6.9. Though, 2.6.8.1 and previous are fine.
> 
> When my ISP connection via PPPoE (kernel side) goes down, reconnection
> does not occur, and the kernel displays continuous:
> 
> kernel: unregister_netdevice: waiting for ppp0 to become free. Usage count = 1

BTW, I have seen many cases when this symptom annoyed me too, the last
one is that my shutdown scripts tried unloading the network driver
modules.  Is your setup doing this by any chance?  In my case,
apparently there were conntrack entries keeping the device in use,
which is almost useless when preparing to shutdown :)

OTOH, I couldn't find a way to flush those conntracks, so I worked
around it by not rmmoding ethernet drivers.

In your case, it's probably conntrack too, I'd presume you are using
that PPPoE machine as a masquerading gateway, which by definition needs
connection tracking...  I'm not sure either if this is a "real" change,
I only vaguely recollect as some moons earlier this wasn't a problem in
2.6.

-- 
Janos | romfs is at http://romfs.sourceforge.net/ | Don't talk about silence.
