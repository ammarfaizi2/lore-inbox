Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271947AbRIDLPD>; Tue, 4 Sep 2001 07:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271946AbRIDLOx>; Tue, 4 Sep 2001 07:14:53 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:18448 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S271943AbRIDLOh>;
	Tue, 4 Sep 2001 07:14:37 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Benjamin Gilbert <bgilbert@backtick.net>
Date: Tue, 4 Sep 2001 13:14:16 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb problems with dualhead G400
CC: Ghozlane Toumi <gtoumi@messel.emse.fr>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <27DB1B1012B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Sep 01 at 22:31, Benjamin Gilbert wrote:
> On Mon, Sep 03, 2001 at 02:51:44PM +0000, Petr Vandrovec (VANDROVE@vc.cvut.cz) wrote:
> > You must boot your kernel with 'video=scrollback:0'. Otherwise your
> > kernel die sooner or later... JJ's scrollback code does not cope with
> > more than one visible console, so you must disable it if you have more
> > than one display in the box.
> 
> That doesn't fix it.  Shift-PgUp no longer works (of course), and
> it's not immediately oopsing on me, but I still have the same type of
> intrusion onto the secondary display.

And did you run 'fbset <anymode>' on first head after secondary head
was registered? You have to... After bootup first head uses all 16MB
for picture. When you load secondary head module, videoram is split
8MB for first head/8MB for second. And because of for correct
checking driver have to scan all your VCs for picture size, and refuse
to load if any resolution is over 8MB, I just decided to put this
task on user - run 'fbset -a -depth 8' after you load secondary head
module. It will shrink '-vyres' values for primary head displays
from their current value to maximum value possible for new memory
configuration.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
