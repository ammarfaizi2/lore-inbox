Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132864AbRDPGfg>; Mon, 16 Apr 2001 02:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132862AbRDPGf0>; Mon, 16 Apr 2001 02:35:26 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:27142 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132865AbRDPGfT>;
	Mon, 16 Apr 2001 02:35:19 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104160635.f3G6Z6Q414864@saturn.cs.uml.edu>
Subject: Re: Bug in EZ-Drive remapping code (ide.c)
To: Andries.Brouwer@cwi.nl
Date: Mon, 16 Apr 2001 02:35:06 -0400 (EDT)
Cc: Jochen.Hoenicke@informatik.uni-oldenburg.de, linux-kernel@vger.kernel.org,
        andre@linux-ide.org
In-Reply-To: <UTC200103301115.NAA61753.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at Mar 30, 2001 01:15:31 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer writes:

> What one wants is to remap access to sector 0 to sector 1,
> and leave all other sectors alone. Thus, if someone asks
> for sectors 0 1 2 3 4, she should get sectors 1 1 2 3 4.

No, because then you can't write to the real first sector.
Assuming translation is good, 1 0 2 3 4 is a better order.
Then "dd if=/dev/zero of=/dev/hda bs=1k count=999" will get
rid of all this crap. Otherwise, killing it is difficult.

> So yes, the problem is known, but I do not see a clean solution,
> unless the solution is to rip out all this EZ drive nonsense.

Linux should still be able to read the partition table.
The translation can go.


