Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757541AbWKXBBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757541AbWKXBBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 20:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757540AbWKXBBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 20:01:51 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:61628 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1757541AbWKXBBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 20:01:50 -0500
Message-ID: <45664477.4030003@garzik.org>
Date: Thu, 23 Nov 2006 20:01:43 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
References: <ek2nva$vgk$1@sea.gmane.org> <Pine.LNX.4.61.0611230107240.26845@yvahk01.tjqt.qr> <20061124004855.GA10937@thunk.org>
In-Reply-To: <20061124004855.GA10937@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Thu, Nov 23, 2006 at 01:10:08AM +0100, Jan Engelhardt wrote:
>> Disk activities are "somewhat predictable", like network traffic, and 
>> hence are not (or should not - have not checked it) contribute to the 
>> pool. Note that urandom is the device which _always_ gives you data, and 
>> when the pool is exhausted, returns pseudorandom data.
> 
> Plesae read the following article before making such assertions:
> 
> 	D. Davis, R. Ihaka, P.R. Fenstermacher, "Cryptographic
> 	Randomness from Air Turbulence in Disk Drives", in Advances in
> 	Cryptology -- CRYPTO '94 Conference Proceedings, edited by Yvo
> 	G. Desmedt, pp.114--120. Lecture Notes in Computer Science
> 	#839. Heidelberg: Springer-Verlag, 1994.
> 	http://world.std.com/~dtd/random/forward.ps

Note that the controller hardware in question plays a large role in 
these things.  Most modern network controllers, and a few recent SATA or 
SAS controllers, include hardware interrupt mitigation, which can cause 
interrupts to fire on a timed basis in some load profiles.

Compounding that, both software and hardware interrupt mitigation lead 
(intentionally) to a marked decrease in overall interrupts, which leads 
to less entropy even if the interrupt handler is sampling randomness.

IMO there is an overall trend needing-more-entropy-than-you-have for 
headless network servers.  If you have a hardware RNG, use that and rngd 
to fill the entropy pool.  If you don't, look into various entropy 
gathering daemons (audio-entropyd, video-entropyd, egd, and others). 
You can gather entropy from system stats, open microphones, open video 
channels, thermal diodes, ...

	Jeff



