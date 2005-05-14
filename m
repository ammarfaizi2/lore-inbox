Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbVENLkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbVENLkQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 07:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVENLkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 07:40:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39068 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262745AbVENLkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 07:40:11 -0400
Date: Sat, 14 May 2005 02:10:50 +0200
From: Pavel Machek <pavel@suse.cz>
To: Marcel Holtmann <holtmann@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Billionton bluetooth USB: how to make it work
Message-ID: <20050514001050.GA1896@elf.ucw.cz>
References: <20050512233902.GA3157@elf.ucw.cz> <1115942337.18499.86.camel@pegasus> <20050513004606.GA1957@elf.ucw.cz> <1115975517.18499.100.camel@pegasus> <20050513101739.GI1780@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513101739.GI1780@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Okay, so the magic sequence seems to be:

# Take 2.6.12-rc3-mm3
#
# PCMCIA config:
# card "Cyber-blue Compact Flash Card"
#   manfid 0x0279, 0x950b
#   bind "serial_cs"
#
killall hciattach
sleep .1
setserial /dev/ttyS4 baud_base 921600
hciattach -s 921600 /dev/ttyS4 bcsp
hciconfig
hciconfig hci0 up
hciconfig

It took me a hour trying to debug weird stuff before I realized that I
need to do hciconfig up... to see some results...

								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
