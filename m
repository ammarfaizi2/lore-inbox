Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbTL3BBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 20:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTL3BBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 20:01:51 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:25031 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S264314AbTL3BBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 20:01:49 -0500
Date: Tue, 30 Dec 2003 02:01:45 +0100
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI problems (was: Re: Synaptics PS/2 driver and 2.6.0-test11)
Message-ID: <20031230010145.GM916@mail.muni.cz>
References: <20031229215913.GH916@mail.muni.cz> <m21xqngmyw.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m21xqngmyw.fsf@telia.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 01:37:11AM +0100, Peter Osterlund wrote:
> That's normal. The hardware generates 80 packets/second and it keeps
> generating packets 1 second after you stop using the touchpad. Each
> packet is 6 bytes and the i8042 controller generates one
> interrupt/byte.
> 
> 500 interrupts/s shouldn't be any problem to handle though.

Well it depends. If ACPI disables interrupts or it keeps some spin lock then
there is a high probability that some interrupts are lost. 

If I do (with no load nor i/o stress):

# time cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            unknown
remaining capacity:      4000 mAh
present voltage:         14800 mV

real    0m1.118s
user    0m0.001s
sys     0m0.007s


However for me it looks odd that sound is not corrupted (and I believe 
that dma buffer does not hold 1 sec of sound data) while serio and soft modem
is.

-- 
Luká¹ Hejtmánek
