Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWGEN61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWGEN61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWGEN61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:58:27 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:5292 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932421AbWGEN60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:58:26 -0400
X-Sasl-enc: i40fnrDtj6hX0JMXwY5jMmvFV5RMMAyf08nsSk21bgVw 1152107903
Date: Wed, 5 Jul 2006 10:58:16 -0300
From: Henrique de Moraes Holschuh <hmh@debian.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net,
       Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060705135816.GA8452@khazad-dum.debian.net>
References: <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <20060704162346.GE9447@khazad-dum.debian.net> <20060704235717.GD11872@elf.ucw.cz> <20060705073455.GA6027@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705073455.GA6027@suse.cz>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jul 2006, Vojtech Pavlik wrote:
> > > I don't know about AMS, but talking to HDAPS when
> > > you don't need to does waste enough system resources and power to actually
> > > justify implementing this.
> 
> I'd doubt any of the accelerometer implementations would consume much
> power or CPU.

It is not just CPU or power, although IMO striving for perfection on power
management in a laptop is almost always a good thing if it can be done
safely.

HDAPS talks to the embedded controller using IO over the LPC bus, and not to
the accelerometer chip or to a simple A/D i2c chip which is used excusively
for accelerometer access.  The EC interface for HDAPS data retrieval is
not friendly to any errors, and hardlocks the machine somehow if any
firmware bugs hit or if we violate any of the rules (that are not written
anywhere) about how to access the EC without geting the SMBIOS unhappy.

So, turning off HDAPS polling while it is not necessary really looks like a
good idea overall.

We are investigating the ACPI global lock as a way to at least get the
SMBIOS to stay away from the EC while we talk to it, but we don't know if
the entire SMBIOS firmware respects that lock.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
