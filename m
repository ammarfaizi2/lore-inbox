Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282114AbRKWKIS>; Fri, 23 Nov 2001 05:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282109AbRKWKIK>; Fri, 23 Nov 2001 05:08:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:28362 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282101AbRKWKHv>;
	Fri, 23 Nov 2001 05:07:51 -0500
Date: Fri, 23 Nov 2001 13:05:30 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-smp@vger.kernel.org>
Subject: [patch] 2.4.15, PROC_CHANGE_PENALTY fix
Message-ID: <Pine.LNX.4.33.0111231300590.5641-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="8323328-556697092-1006345120=:8622"
Content-ID: <Pine.LNX.4.33.0111231300591.5641@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-556697092-1006345120=:8622
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0111231300592.5641@localhost.localdomain>


noticed another (more or less minor) SMP scheduler bug, affecting
HZ != 100 kernels. (such as the default Alpha kernel, or some x86
'low latency' kernel compilations used by some of us.).

If HZ != 100 then PROC_CHANGE_PENALTY does not get scaled along the size
of ->counter ticks. The effect of this bug on SMP Alpha is that the
'effecive' PROC_CHANGE_PENALTY of 20 (on Alpha) is degraded to a
comparable value of 2, which is *very* bad for SMP affinity. On x86, this
value is 15.

The solution is to scale the PROC_CHANGE_PENALTY value via TICK_SCALE.
I've added a *4 to it so that the 'traditional' (and more intuitive) value
of 15 can be used on x86. Or we could change the value of
PROC_CHANGE_PENALTY to be 60 on x86 and leave out the *4.

it would be nice to see whether anyone with access to an SMP/Alpha box
could confirm that this patch impacts things like kernel compilation speed
or other cache-intensive and affinity-sensitive applications.

	Ingo

--8323328-556697092-1006345120=:8622
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="smpschedfix-2.4.15-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0111231305300.5641@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="smpschedfix-2.4.15-A0"

LS0tIGxpbnV4L2tlcm5lbC9zY2hlZC5jLm9yaWcJV2VkIE5vdiAyMSAxMDo1
ODo1NiAyMDAxDQorKysgbGludXgva2VybmVsL3NjaGVkLmMJV2VkIE5vdiAy
MSAxMDo1OTozNyAyMDAxDQpAQCAtMTcyLDcgKzE3Miw3IEBADQogCQkvKiBH
aXZlIGEgbGFyZ2lzaCBhZHZhbnRhZ2UgdG8gdGhlIHNhbWUgcHJvY2Vzc29y
Li4uICAgKi8NCiAJCS8qICh0aGlzIGlzIGVxdWl2YWxlbnQgdG8gcGVuYWxp
emluZyBvdGhlciBwcm9jZXNzb3JzKSAqLw0KIAkJaWYgKHAtPnByb2Nlc3Nv
ciA9PSB0aGlzX2NwdSkNCi0JCQl3ZWlnaHQgKz0gUFJPQ19DSEFOR0VfUEVO
QUxUWTsNCisJCQl3ZWlnaHQgKz0gVElDS19TQ0FMRShQUk9DX0NIQU5HRV9Q
RU5BTFRZKjQpOw0KICNlbmRpZg0KIA0KIAkJLyogLi4gYW5kIGEgc2xpZ2h0
IGFkdmFudGFnZSB0byB0aGUgY3VycmVudCBNTSAqLw0K
--8323328-556697092-1006345120=:8622--
