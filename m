Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWEHRUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWEHRUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWEHRUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:20:20 -0400
Received: from mailgate2.igd.fhg.de ([192.44.32.14]:33423 "EHLO
	mailgate2.igd.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932469AbWEHRUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:20:18 -0400
Message-ID: <445F7DCC.2000508@igd.fraunhofer.de>
Date: Mon, 08 May 2006 19:20:12 +0200
From: Tillmann Steinbrecher <tsteinbr@igd.fraunhofer.de>
Organization: Fraunhofer-Institute for Computer Graphics
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, dm-crypt@saout.de
Subject: dm-crypt is broken and causes massive data corruption
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it's been many months that dm-crypt has been broken, and is known to 
cause massive data corruption.

Various people have noticed this, have lost data and wasted many hours 
trying to find the reason, and still NOTHING is being done about it. The 
problem seems to occur only in conjunction with RAID (dm-crypt on top of 
RAID) (or possibly it occurs only in conjunction with large 
filesystems). I've had issues with that for many months as well, trying 
to eliminate other possible reasons. There are none.

Let's say this loud and clear:

dm-crypt causes data corruption. Yet it is not even marked as 
"EXPERIMENTAL" in the kernel config, when in fact it's more than just 
experimental, it's "DANGEROUS/BROKEN".

Here are some more reports:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=336153
(That was for 2.6.8, but the problems are still the same in recent 
kernel versions)

http://www.ubuntuforums.org/showthread.php?t=170304
(Similar config, similar problem - this time with 2.6.12 and 2.6.15)

http://episteme.arstechnica.com/groupee/forums/a/tpc/f/96509133/m/282007248731/r/224008458731
(Again the same constellation, and the same problem.)

http://marc.theaimsgroup.com/?l=linux-kernel&m=114664786711245&w=2
(Same config, same problem. This time with 2.6.16!)

BTW the problem seems to be independent from the filesystem used; 
however, filesystems seem to be more or less robust against this type of 
corruption. With ext3, the filesystem would mess itself up within hours 
on my system. With XFS, massive corruption (all data lost) had occured 
after a few weeks. With ReiserFS 3, occasional problems that were 
fixable using reiserfsck --rebuild-tree occured.

Sorry for the rant. But I think this is an important issue that needs to 
be adressed ASAP, before even more people lose their data. Keep in mind 
that crypto filesystems are typically used for systems where the data is 
sensitive and important! Something must be done about it - in the worst 
case, removing dm-crypt from the mainline kernel.

Please CC replies to me, as I'm not subscribed to either linux-kernel or 
dm-crypt.

bye,
Tillmann
-- 
Dipl.-Ing. Tillmann Steinbrecher        http://www.igd.fhg.de/~tsteinbr/
Cognitive Computing & Medical Imaging
Fraunhofer IGD, Fraunhoferstr. 5, D-64283 Darmstadt, Germany
All opinions are mine and not those of my employer.

