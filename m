Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWEIAnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWEIAnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 20:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWEIAnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 20:43:23 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:50340 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750827AbWEIAnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 20:43:23 -0400
References: <1147130298.30649.33.camel@localhost.localdomain>
Message-ID: <cone.1147135389.188411.32203.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: tim.c.chen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Regression seen for patch =?ISO-8859-1?Q?=22sched:dont?=
         decrease idle sleep =?ISO-8859-1?B?YXZnIg==?=
Date: Tue, 09 May 2006 10:43:09 +1000
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-32203-1147135389-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-32203-1147135389-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Tim Chen writes:

> Con,
> 
> As a result of the patch "sched:dont decrease idle sleep avg" 
> introduced after 2.6.15, there is a 4% drop in Volanomark 
> throughput on our Itanium test machine.  
> Probably the following happened:
> Compared to previous code, this patch slightly increases 
> the the priority boost when a job is woken up.
> This adds priority spread and variations to the wait time of jobs
> on run queue if we have a lot of similar jobs in the system.
> 
> See patch:
> http://www.kernel.org/git/?
> p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e72ff0bb2c163eb13014ba113701bd42dab382fe 

Lovely

This patch corrects a bug in the original code which unintentionally dropped 
the priority of tasks that were idle but were already high priority on other 
merits. It doesn't further increase the priority. The 4% almost certainly is 
due to the lack of any locking in the threading model used by the java 
virtual machine on volanomark and it being pure luck that penalising 
particularly idle tasks previously improved the wakeup timing of basically 
yielding dependant threads. This patch did fix bugs related to interactive 
yet idle tasks like consoles misbehaving. The fact that the presence of that 
particular bug improved a multithreaded benchmark that uses such a threading 
model is pure chance and (obviously) not design. I wouldn't like to see this 
bug reintroduced on the basis of this benchmark result.

---
-ck


--=_mimegpg-kolivas.org-32203-1147135389-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBEX+WdZUg7+tp6mRURAibSAJwLm8VyjxrmG/chjdrwQxXWM9K8kQCdHRcT
6tgKkyVkvF01kucNU9H0z9g=
=b+iT
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-32203-1147135389-0001--
