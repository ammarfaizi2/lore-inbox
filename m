Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267212AbTBDKkI>; Tue, 4 Feb 2003 05:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267215AbTBDKkI>; Tue, 4 Feb 2003 05:40:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37643 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267212AbTBDKkH>; Tue, 4 Feb 2003 05:40:07 -0500
Date: Tue, 4 Feb 2003 10:49:37 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Adam Belay <ambx1@neo.rr.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "greg@kroah.com" <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PnP model
Message-ID: <20030204104937.A13453@flint.arm.linux.org.uk>
Mail-Followup-To: Jaroslav Kysela <perex@perex.cz>,
	Adam Belay <ambx1@neo.rr.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"greg@kroah.com" <greg@kroah.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030204094634.A11346@flint.arm.linux.org.uk> <Pine.LNX.4.44.0302041117500.1278-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302041117500.1278-100000@pnote.perex-int.cz>; from perex@perex.cz on Tue, Feb 04, 2003 at 11:18:36AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 11:18:36AM +0100, Jaroslav Kysela wrote:
> I think that legacy devices must be probed after PnP ones, otherwise 
> you'll get these duplications.

Unfortunately, this isn't easy to do, while keeping stuff like serial
consoles working from early at bootup.  Alan Cox definitely does not
want to see the serial console initialised any later than it is today,
and he's not the only one.

In addition, the "legacy" devices are part of the 8250.c module - they
have to be for serial console.  The PNP devices are probed as part of
the 8250_pnp.c module, and since 8250_pnp.c depends on 8250.c, the
serial PNP ports will _always_ be initialised after the ISA probes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

