Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVAaUbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVAaUbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVAaUbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:31:51 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:52122 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261355AbVAaUb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:31:26 -0500
Message-ID: <41FE9582.7090003@kolivas.org>
Date: Tue, 01 Feb 2005 07:30:58 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Alexander Nyberg <alexn@dsv.su.se>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] sched - Implement priority and fifo support for SCHED_ISO
References: <41F76746.5050801@kolivas.org> <87acqpjuoy.fsf@sulphur.joq.us>
In-Reply-To: <87acqpjuoy.fsf@sulphur.joq.us>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig66A50698898B57C0A8F1E5B0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig66A50698898B57C0A8F1E5B0
Content-Type: multipart/mixed;
 boundary="------------000505060808060905090508"

This is a multi-part message in MIME format.
--------------000505060808060905090508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jack O'Quin wrote:
> Loading the realtime-lsm and then running with SCHED_FIFO *does* work
> as expected on this kernel.  I should retry the test with *exactly*
> the expected patch sequence.  What would that be?

Sure enough I found the bug in less than 5 mins, and it would definitely 
cause this terrible behaviour.

A silly bracket transposition error on my part :P

Cheers,
Con

--------------000505060808060905090508
Content-Type: text/x-diff;
 name="iso_preempt_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iso_preempt_fix.diff"

Index: linux-2.6.11-rc2-iso/kernel/sched.c
===================================================================
--- linux-2.6.11-rc2-iso.orig/kernel/sched.c	2005-02-01 07:28:40.171079813 +1100
+++ linux-2.6.11-rc2-iso/kernel/sched.c	2005-02-01 07:29:21.332297160 +1100
@@ -326,9 +326,9 @@ static int task_preempts_curr(task_t *p,
 				goto out;
 			}
 			p_prio = ISO_PRIO;
+		}
 		if (iso_task(rq->curr))
 			curr_prio = ISO_PRIO;
-		}
 	}
 out:
 	if (p_prio < curr_prio)

--------------000505060808060905090508--

--------------enig66A50698898B57C0A8F1E5B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB/pWCZUg7+tp6mRURAu70AJ0TxZVmSRd6PzTuFKkiwdcV9CotQgCfbyCF
SIb4CrEiqboxSZbqn9l9YCU=
=K4ot
-----END PGP SIGNATURE-----

--------------enig66A50698898B57C0A8F1E5B0--
