Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbTDCQd7>; Thu, 3 Apr 2003 11:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbTDCQd7>; Thu, 3 Apr 2003 11:33:59 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:10094 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261335AbTDCQd5>;
	Thu, 3 Apr 2003 11:33:57 -0500
Message-ID: <3E8C6522.2010208@mvista.com>
Date: Thu, 03 Apr 2003 10:45:22 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@redhat.com>
Subject: Re: IPMI driver version 19 release
References: <3E8C6022.6060304@mvista.com> <20030403163700.GA13769@gtf.org>
In-Reply-To: <20030403163700.GA13769@gtf.org>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This only occurs in "run to completion" mode, which is a special mode
the driver goes into after a panic.  This allows the driver to get
messages out during a panic to do things like extend the watchdog timer
and send panic information.

- -Corey

Jeff Garzik wrote:

>On Thu, Apr 03, 2003 at 10:24:02AM -0600, Corey Minyard wrote:
>
>>@@ -563,8 +576,9 @@
>>         spin_lock_irqsave(&(kcs_info->kcs_lock), flags);
>>         result = kcs_event_handler(kcs_info, 0);
>>         while (result != KCS_SM_IDLE) {
>>-            udelay(500);
>>-            result = kcs_event_handler(kcs_info, 500);
>>+            udelay(KCS_SHORT_TIMEOUT_USEC);
>>+            result = kcs_event_handler(kcs_info,
>>+                           KCS_SHORT_TIMEOUT_USEC);
>>         }
>>         spin_unlock_irqrestore(&(kcs_info->kcs_lock), flags);
>>         return;
>
>
>
>Do you really want to udelay this long with interrupts disabled?
>Certainly comments in kcs_event[_handler] indicate you're aware of the
>issue, but the code does not belie this fact :)
>
>Not only is the udelay itself "long" relatively speaking, but it's in a
>loop.  Which also calls a function that contains a loop that is
>potentially infinite is hardware is being wonky.
>
>    Jeff
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+jGUhmUvlb4BhfF4RAp2ZAJ40cXa1O1tv1wITiFzMsTuaTDejEgCfeOzM
Uw0PgpEhlmDkyF9yejO/r4A=
=l5ia
-----END PGP SIGNATURE-----


