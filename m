Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUCWEcs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 23:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUCWEcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 23:32:48 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:33671 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261967AbUCWEcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 23:32:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Synaptics touchpad + external mouse with Linux 2.6?
Date: Mon, 22 Mar 2004 23:32:29 -0500
User-Agent: KMail/1.6.1
Cc: Joshua Kwan <joshk@triplehelix.org>
References: <m33c81lsnk.fsf@defiant.pm.waw.pl> <20040322061657.GA346@ucw.cz> <pan.2004.03.23.02.41.08.115427@triplehelix.org>
In-Reply-To: <pan.2004.03.23.02.41.08.115427@triplehelix.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403222332.31308.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 March 2004 09:41 pm, Joshua Kwan wrote:
> On Mon, 22 Mar 2004 07:16:57 +0100, Vojtech Pavlik wrote:
> > I'm sorry to say it, but it's not possible. Well, it might be, but still
> > the magic to recognize which device is sending the data would be rather
> > crazy.
> 
> Forgive me if I'm being naive, but...
> 
> Why can't synaptics be transparent? Why can't it do all the stuff it
> requires special userspace things for in kernel space?
> 
> I should think that mapping the scroll buttons to their normal PS/2
> equivalents on a Synaptics touchpad is possible in kernel space.
> 
> A friend recently expressed his discontent with this condition when he
> tried to plug in another mouse and use it while the Synaptics touchpad was
> still present.
> 
> So, please enlighten me...
> 

Because it is not implementation, it is hardware limitation. Synaptics native
protocol uses 6 bytes, standard PS/2 3 or 4. The protocols are not compatible
at all so unless the PC has an active multiplexing controller (which provides
up to 4 completely independent AUX ports) all devices have to speak the same
protocol. 

I have seen 2 different behaviors for PCs without active multiplexor:
1. Plugging external mouse forces synaptics into hardware PS/2 compatibility
   mode (Dells).
2. Hardware completely hides presence of external mouse (older Compaqs, ASUS).
   In this case psmouse.proto option is needed to force both devices use the
   same protocol, but all advanced features of Synaptics are lost.

As a side note what is normal PS/2 equivalent lower left corner tap has? What
about lower right corner tap? 3-finger tap? Synaptics provides much more
features than you can have with standard PS/2.


Hope that helps.

-- 
Dmitry
