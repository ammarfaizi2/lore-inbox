Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271924AbTHSQPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270805AbTHSQP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:15:29 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53499 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S271924AbTHSQN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:13:27 -0400
Date: Tue, 19 Aug 2003 15:04:58 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: <20030818122933.A970@pclin040.win.tue.nl>
Message-ID: <Pine.GSO.3.96.1030819143241.29184C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003, Andries Brouwer wrote:

> >  Well, mode #3 with no translation in the i8042 looks quite sanely. 
> 
> In theory perhaps. In practice it isnt sane at all.

 Yep, the design is clean.  And we can handle it for good devices, for its
additional functionality (e.g. autorepeat of <Pause> ;-) ) and to have a
clean reference design of code.  I see no reason to "punish" good devices
for the faults of bad ones. 

> (That is, the majority of the keyboards sold today do not do as one
> would wish. Since Microsoft does not require anything for Set 3,
> behaviour in Set 3 is essentially random, especially for these
> additional keys and buttons. A single keypress may give several
> scancodes, or none at all. Many laptops do not have any support

 Well, we need not take care of non-standard keys -- as such they need to
be handled on a case-by-case basis (with customized key maps).  The sort
of standard Win keys seem to have a consistent definition across devices;
at least it was the case with the ones I've encountered.

 If standard keys are broken, then we can still revert to mode #2 with all
its limits as we do now.  At least we can disable the translation in the
i8042 to get full and unambiguous scan codes.

> for Set 3. USB compatibility only implements compatibility with
> translated Set 2.)

 That's actually irrelevant -- it's already an emulation.  AFAIK, we can
handle USB keyboards natively just fine, so we don't need to make use of
this translation layer.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

