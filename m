Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVASUUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVASUUM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVASUUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:20:12 -0500
Received: from modemcable240.48-200-24.mc.videotron.ca ([24.200.48.240]:43648
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261871AbVASUUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:20:03 -0500
Date: Wed, 19 Jan 2005 15:19:16 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@localhost.localdomain
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
cc: Jean Delvare <khali@linux-fr.org>, Jonas Munsin <jmunsin@iki.fi>,
       Simone Piunno <pioppo@ferrara.linux.it>, djg@pdp8.net, greg@kroah.com
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
In-Reply-To: <20050110203427.5061cf0d.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.61.0501191448160.5315@localhost.localdomain>
References: <200501080150.44653.pioppo@ferrara.linux.it>
 <20050108172020.64999e50.khali@linux-fr.org> <200501082023.54881.pioppo@ferrara.linux.it>
 <200501102023.44847.pioppo@ferrara.linux.it> <20050110203427.5061cf0d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1996361894-1106165218=:5315"
Content-ID: <Pine.LNX.4.61.0501191508430.5315@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1996361894-1106165218=:5315
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.61.0501191508431.5315@localhost.localdomain>

On Mon, 10 Jan 2005, Jean Delvare wrote:

> When I get this, I'll compare with the datasheets so as to understand
> how your chip is configured (or left unconfigured) by your BIOS. This
> will both help me propose a workaround in the it87 driver and explain
> the Gigabyte support what I think they should do.

FWIW, I have a Gigabyte motherboard with an it87 chip too.  Reading 
about this it87 polarity thing I'm suspecting something is really wrong 
here:

When system is idle, the sensors report shows:
CPU temp = +25°C and CPU fan = 2136 RPM (and rather noisy)

When system is 100% busy (with dd if=/dev/urandom of=/dev/null):
CPU temp = +41°C and CPU fan =   1288 RPM (and obviously much quieter)

I'm running a 2.6.10 kernel (not -mm) so I guess the BIOS settings for 
fan control are not altered.  And incidentally the BIOS has a setting 
called "smart fan control" set to "enabled" which maps to the ITxxF 
automatic PWM control mode I suppose.  So if the BIOS actually set the 
fan polarity wrong then the fan would slow down when the temperature 
rises and vice versa, right?


Nicolas
--8323328-1996361894-1106165218=:5315--
