Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTHUPDs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTHUPDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:03:48 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:49360 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S262738AbTHUPDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:03:45 -0400
Date: Thu, 21 Aug 2003 17:03:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: <20030821164435.B3518@pclin040.win.tue.nl>
Message-ID: <Pine.GSO.3.96.1030821164926.2489M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Andries Brouwer wrote:

> >  Hmm, that would make some sense, but how does it work when an external
> > keyboard is attached?
> 
> Usually the keyboard and mouse commands are sent to all attached
> keyboards resp. mice. Thus, with an internal keyboard that only
> knows about Set 2 and an external keyboard that also knows about
> Set 3 you can change the kbds to Set 3. Now the internal one is
> dead, but the external one functions.

 I meant: how does the translation work if there is only a single onboard
controller that does scanning of the embedded keyboard and presents set #1
of codes directly?  But after a bit of thinking I suppose it does support
translation for an external keyboard (which presents set #2 by default and
a lot of PC software expects set #1) and probably a pass-through mode for
it as well. 

 What the big fault of all these limited implementations is, there is no
reliable way to query what is supported.  If a device does not support
mode switching or a particular mode, it should NAK a command that does it,
or at least report the original mode if queried afterwards.  Another
possibility is to return a different device ID -- IBM chose a single value
of 256 possible for its PS/2 keyboards -- why couldn't the incompatible
others have chosen something different, sigh?... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

