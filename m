Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTFZOcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 10:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTFZOcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 10:32:09 -0400
Received: from vdp184.ath05.cas.hol.gr ([195.97.120.185]:22431 "EHLO
	pfn1.pefnos") by vger.kernel.org with ESMTP id S261801AbTFZObY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 10:31:24 -0400
From: "P. Christeas" <p_christ@hol.gr>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: Synaptics support kills my mouse
Date: Thu, 26 Jun 2003 17:46:14 +0300
User-Agent: KMail/1.5
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306261746.14578.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is true, 2.5.73 unconditionally detects and tries to use the Syn. Touchpad 
in 'absolute mode'. I wouldn't blame the authors of the module, however. They 
are already doing a great job :).

I 've read the code to see what's wrong and found that the problem is that the 
Touchpad itself doesn't report any data to the PS/2 port. The code still 
looks conforming to the specs.
However, you shouldn't give up 2.5.73 because of that. You can still use the 
PS/2 compatibility mode
 o Compile the ps mouse as a module "psmouse"
 o Arrange so that the module is loaded with the option "psmouse_noext=1"
 o Have gpm and X (you can even use both of them) read /dev/input/mice as an 
exps2 or imps2 mouse (Intellimouse Explorer PS/2) .

I don't think the "event interface" has any support yet. Nor the synaptics 
driver.
Reading from /dev/input/mice means that the psmouse module doesn't have to be 
loaded before X starts. You can safely rmmod/modprobe the module while X run.
You may find that tapping with the finger may not work (produce 'click' 
effect). I hope next release will have a fix (contact me in personal until 
the official patch is out).

