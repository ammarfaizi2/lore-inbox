Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264539AbTCYVVY>; Tue, 25 Mar 2003 16:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264541AbTCYVVY>; Tue, 25 Mar 2003 16:21:24 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:8124 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S264539AbTCYVVX>;
	Tue, 25 Mar 2003 16:21:23 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Martin J. Bligh" <mbligh@aracnet.com>
Date: Tue, 25 Mar 2003 22:32:14 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Bug 502] New: Broken cursor when using neofb
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
X-mailer: Pegasus Mail v3.50
Message-ID: <77A7083F62@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Mar 03 at 11:57, Martin J. Bligh wrote:
> Mar 25 20:04:58 gswi1164 kernel: Console: switching to colour frame buffer device 128x48
> 
> On a vc the line cursor looks like
> ****** ** ********
> instead of
> ****************** (the normally continous line is broken).
> Emacs uses a block cursor that is broken similar, the block
> is broken by two vertical bars.

Well, then it's not my bug then. Go to the drivers/video/console/fbcon.c,
and do (pseudopatch):

+ memset(data, 0xff, size);
  if (cursor->set & FB_CUR_SETSIZE) {
-    memset(data, 0xff, size);
     cursor->set |= FB_CUR_SETSHAPE;
  }
 
Correct cursor should appear after that. It is questionable whether this
layer should do this SETSIZE -> SETSHAPE propagation, as soft_cursor()
does same. I recommend leaving this here, and removing it from
soft_cursor() code.
                                                            Petr
                                                            

