Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVBPWOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVBPWOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 17:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVBPWOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 17:14:40 -0500
Received: from mail.Space.Net ([195.30.0.8]:37132 "HELO mail.space.net")
	by vger.kernel.org with SMTP id S262101AbVBPWOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 17:14:38 -0500
From: bernd@rhm.de
Message-Id: <200502162214.XAA29751@node130.rhm.de>
Subject: Login on 2.6.x: can't reopen tty
To: linux-kernel@vger.kernel.org
Date: Wed, 16 Feb 2005 23:14:30 +0100 (MEZ)
X-Mailer: ELM [version [Version 2.3.rh] PL0]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, hope I'm not of topic here but had no response elsewhere...
                                     
we observe a problem with login starting with kernel 2.6. Actually
the problem still exists in 2.6.11-rc3-bk3-20050206171922-bigsmp
which we loaded from SuSE. We never saw this problem before and
we used nearly every release in the past. The problem:
                                                               
When we try to login to a remote machine with telnet or rsh we
sometimes fall back immediately with the message 'connection closed'.
When we try again the login mostly succeeds. The ratio of bad/good
attempts over all is 1/10. It doesn't depend on the state of the 
machines e.g. type if hardware or load. It happens on laptops as
well as smp-machines. In messages we see:
                                                           
 "login[xxx]: FATAL: can't reopen tty: No such file or directory"
                                                                 
We debugged login and tracked the problem down to the fopen of
/dev/pts/nn in function opentty() just after a call to the kernel
function vhangup().
                              
The questions:
 
   - why does /dev/pts/nn disappear (and never comes back)?
   - is this a kernel bug? is there something wrong in vhangup()?
   - is anybody else aware of this problem?
     (there's only one additional posting from Yehavi Bourvine)
   - is there a solution (pending)?
                                       
Thanks in advance for any hint, we are pretty losts...
                              
Greetings
Bernd Rieke
