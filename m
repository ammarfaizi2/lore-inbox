Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUHJL7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUHJL7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 07:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUHJL7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 07:59:52 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:49361 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S264500AbUHJL6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 07:58:51 -0400
Message-ID: <4118B88A.9090300@metaparadigm.com>
Date: Tue, 10 Aug 2004 19:59:06 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040802 Debian/1.7.1-5
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, jeremy@goop.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - Initial dothan speedstep support
References: <41131120.5060202@metaparadigm.com> <411365C9.5020909@metaparadigm.com> <20040809142819.GD21238@redhat.com>
In-Reply-To: <20040809142819.GD21238@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------000605030803090805050902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000605030803090805050902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dave, Jeremy,

I thought i'd give the ACPI code in speedstep-centrino a try as I wanted
to see what the BIOS freq/voltage tables the vendor was using due to the
apparent choice of voltages (VID#A through VID#C) in the processor specs.

Anyway this is what I found (with the debug code in attached patch):

centrino_cpu_init_acpi: 1800000000 Hz, 1340e-03 volts
centrino_cpu_init_acpi: 1600000000 Hz, 1292e-03 volts
centrino_cpu_init_acpi: 1400000000 Hz, 1228e-03 volts
centrino_cpu_init_acpi: 1200000000 Hz, 1164e-03 volts
centrino_cpu_init_acpi: 1000000000 Hz, 1116e-03 volts
centrino_cpu_init_acpi: 800000000 Hz, 1052e-03 volts
centrino_cpu_init_acpi: 600000000 Hz, 988e-03 volts

It appears the T42 is using the VID#A voltages (the highest) and my
patch was using VID#C (the 2nd from lowest) for which the upper voltage
has the biggest difference being 0.032 volts lower - not much in it.

As I said earlier in my reading of the specs there seemed to be no
guidance on which profile to use aside from the voltage and ripple
tolerance tables.

So the attached patch (in addition to ACPI freq table debug message)
changes the table version to use the VID#A voltage so as to err on the
conservative side of a higher voltage (as the upper voltage max for
the chip is 1.6v) to allow for cases where the error on the voltage
would drop it too low - not sure if just IBM are using this. Would be
interesting to see the ACPI freq/voltage tables for other vendor's
Dothan laptops.

Not sure on whether we should do this although it means we match at least
what one vendor has done? Any ideas? (debug printk may be useful for those
with ACPI and speedstep for debugging incorrect BIOS tables).

Thanks
~mc

--------------000605030803090805050902
Content-Type: application/octect-stream;
 name="cpufreq-speedstep-dothan-VidA.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cpufreq-speedstep-dothan-VidA.patch"

LS0tIGxpbnV4LTIuNi44LXJjMy1tbTEvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJlcS9z
cGVlZHN0ZXAtY2VudHJpbm8uYy50bXAJMjAwNC0wOC0xMCAxOToyMjo0Ny4wMDAwMDAwMDAg
KzA4MDAKKysrIGxpbnV4LTIuNi44LXJjMy1tbTEvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1
ZnJlcS9zcGVlZHN0ZXAtY2VudHJpbm8uYwkyMDA0LTA4LTEwIDE5OjIyOjUzLjAwMDAwMDAw
MCArMDgwMApAQCAtMjA2LDcgKzIwNiw3IEBACiAjZGVmaW5lIE9QKG1oeiwgbXZhLCBtdmIs
IG12YywgbXZkKQkJCQkJXAogCXsJCQkJCQkJCVwKIAkJLmZyZXF1ZW5jeSA9IChtaHopICog
MTAwMCwJCQkJXAotCQkuaW5kZXggPSAoKChtaHopLzEwMCkgPDwgOCkgfCAoKG12YyAtIDcw
MCkgLyAxNikgICAgICAgCVwKKwkJLmluZGV4ID0gKCgobWh6KS8xMDApIDw8IDgpIHwgKCht
dmEgLSA3MDApIC8gMTYpICAgICAgIAlcCiAJfQogCiAvKiBJbnRlbCBQZW50aXVtIE0gcHJv
Y2Vzc29yIDcxNSAvIDEuNTBHSHogKERvdGhhbikgKi8KQEAgLTQ5Myw2ICs0OTMsMTAgQEAK
ICAgICAgICAgZm9yIChpPTA7IGk8cC5zdGF0ZV9jb3VudDsgaSsrKSB7CiAJCWNlbnRyaW5v
X21vZGVsLT5vcF9wb2ludHNbaV0uaW5kZXggPSBwLnN0YXRlc1tpXS5jb250cm9sOwogCQlj
ZW50cmlub19tb2RlbC0+b3BfcG9pbnRzW2ldLmZyZXF1ZW5jeSA9IHAuc3RhdGVzW2ldLmNv
cmVfZnJlcXVlbmN5ICogMTAwMDsKKwkJcHJpbnRrKEtFUk5fREVCVUcgImNlbnRyaW5vX2Nw
dV9pbml0X2FjcGk6ICIKKwkJICAgICAgICIlZCBIeiwgJWRlLTAzIHZvbHRzXG4iLCAKKwkJ
ICAgICAgIGNlbnRyaW5vX21vZGVsLT5vcF9wb2ludHNbaV0uZnJlcXVlbmN5ICogMTAwMCwK
KwkJICAgICAgIChjZW50cmlub19tb2RlbC0+b3BfcG9pbnRzW2ldLmluZGV4ICYgMHhmZikg
KiAxNiArIDcwMCk7CiAJfQogCWNlbnRyaW5vX21vZGVsLT5vcF9wb2ludHNbcC5zdGF0ZV9j
b3VudF0uZnJlcXVlbmN5ID0gQ1BVRlJFUV9UQUJMRV9FTkQ7CiAK
--------------000605030803090805050902--
