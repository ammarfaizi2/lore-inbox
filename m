Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271080AbTGPUrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271079AbTGPUqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:46:43 -0400
Received: from fep06-svc.mail.telepac.pt ([194.65.5.211]:52137 "EHLO
	fep06-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S271069AbTGPUqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:46:06 -0400
Date: Wed, 16 Jul 2003 22:00:59 +0100
From: Nuno Monteiro <nuno.monteiro@ptnix.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Edward Tandi <ed@efix.biz>,
       linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Subject: Re: woes with 2.6.0-test1 and xscreensaver/xlock
Message-ID: <20030716210059.GA1564@hobbes.itsari.int>
References: <20030716172758.GA1792@hobbes.itsari.int> <Pine.LNX.4.53.0307161454180.32541@montezuma.mastecende.com> <20030716195656.GA1567@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030716195656.GA1567@hobbes.itsari.int>; from nuno.monteiro@ptnix.com on Wed, Jul 16, 2003 at 20:56:56 +0100
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2003.07.16 20:56, Nuno Monteiro wrote:
> 
> 
[bla bla bla snipped]

Replying to myself:

Ok, I figured it out. It's a definitely a pam problem. I fetched latest 
pam rpm from RH RawHide and picked up their sigchld patch, applied it to 
mandrake cookers's latest pam package, rebuilt, et voila'. All is well 
again, it doesnt hang anymore. I think the bug in bugzilla can be closed 
now. I'm attaching the patch to pam 0.77, if anyone wants to give it a 
spin. Also, should anyone from mandrake is reading this, it'd be 
adviseable to apply it to the official package. I'll ping them anyway, to 
let them know of this.

Thanks for the input, everyone.



Regards, 
		Nuno

--FCuugMFkClbJLl1L
Content-Type: text/x-diff; charset=unknown-8bit
Content-Disposition: attachment; filename="pam-0.77-sigchld.patch"

Specifying SIG_IGN for SIGCHLD (which by default, is ignored) is not the same
as specifying SIG_DFL.  See the NOTES section of wait(2) for the skinny on this.

--- Linux-PAM-0.77/modules/pam_pwdb/support.-c	2003-07-09 00:15:06.000000000 -0400
+++ Linux-PAM-0.77/modules/pam_pwdb/support.-c	2003-07-09 00:15:19.000000000 -0400
@@ -370,7 +370,7 @@
 	 * The "noreap" module argument is provided so that the admin can
 	 * override this behavior.
 	 */
-	sighandler = signal(SIGCHLD, SIG_IGN);
+	sighandler = signal(SIGCHLD, SIG_DFL);
     }
 
     /* fork */
--- Linux-PAM-0.77/modules/pam_unix/support.c	2003-07-09 00:15:29.000000000 -0400
+++ Linux-PAM-0.77/modules/pam_unix/support.c	2003-07-09 00:15:41.000000000 -0400
@@ -597,7 +597,7 @@
 	 * The "noreap" module argument is provided so that the admin can
 	 * override this behavior.
 	 */
-	sighandler = signal(SIGCHLD, SIG_IGN);
+	sighandler = signal(SIGCHLD, SIG_DFL);
     }
 
     /* fork */

--FCuugMFkClbJLl1L--
