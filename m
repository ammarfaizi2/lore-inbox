Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278709AbRJXSpg>; Wed, 24 Oct 2001 14:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278713AbRJXSp0>; Wed, 24 Oct 2001 14:45:26 -0400
Received: from s1.relay.oleane.net ([195.25.12.48]:22961 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S278709AbRJXSpR>; Wed, 24 Oct 2001 14:45:17 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Grover, Andrew" <andrew.grover@intel.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] New Driver Model for 2.5
Date: Wed, 24 Oct 2001 20:45:38 +0200
Message-Id: <20011024184538.15471@smtp.adsl.oleane.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6A1@orsmsx111.jf.intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6A1@orsmsx111.jf.intel.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Awesome.
>
>So non i386 archs do not have the problem with the video bios having to run
>on resume, or did you have to handle this somehow?

Fortunately, Mac laptops don't shut the chip down, the PM microcontroller will
just suspend the clock to it. fbdev's are mandatory on macs, and so we use the
fbdev for mach64 or r128 (the 2 types of chips you find on mac laptops, radeon
is coming soon however) to save a few things and put the chip in D2 mode
(or vendor specific suspend mode for mach64).

The problem do exist with Mac desktops as they power off the PCI and AGP
slots. That's the main reason why I don't add support for those in Linux
currently. We need some way to revive the card, which can be either done
with a chip-specific init sequence (in the fbdev), a small forth emulator
with enough of Open Firmware environement to run the OF driver for the
card, or a shell to run the MacOS driver for the card. All of these
solutions are tricky however.

Ben.


