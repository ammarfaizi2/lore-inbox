Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263307AbVCDXwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbVCDXwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbVCDXuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:50:10 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:40392 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263309AbVCDWhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:37:52 -0500
Message-ID: <4228E33D.5010505@g-house.de>
Date: Fri, 04 Mar 2005 23:37:49 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.1 (Windows/20050225)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: size of /proc/kcore grows?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i've just tried to "search for something in the RAM", so i thougt 
/proc/kcore would be a good address to start. i really only wanted to 
grep for raw data throught it, i did not need any specific meta-data.

ok, i checked:

$ ls -lah /proc/kcore
-r--------  1 root root 256M Mar  4 23:25 /proc/kcore

which makes sense, since i have 256MB RAM.

$ su -
Password:
root$ cp /proc/kcore /data/Incoming/
`/proc/kcore' -> `/data/Incoming/kcore'
root$ ls -la /proc/kcore /data/Incoming/kcore
-r--------  1 root root 1.0G Mar  4 23:26 /data/Incoming/kcore
-r--------  1 root root 1.0G Mar  4 23:27 /proc/kcore

whooha! /proc/kcore and its new on-disk copy are now both 1GB in size.
how comes? i could imagine, that when "cp" tried to copy /proc/kcore the 
RAM gets filled with /proc/kcore again, thus doubling it...somehow...but 
cp continued with no errors, why should it double /proc/kcore 
(256MB->512MB) and then again (512MB->1024MB), but stop after this? i 
would've expected cp to never stop copying...

i don't get it,
Christian.



