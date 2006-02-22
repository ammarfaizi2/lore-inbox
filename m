Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWBVKa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWBVKa6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 05:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbWBVKa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 05:30:58 -0500
Received: from cust.92.104.adsl.cistron.nl ([195.64.92.104]:39316 "EHLO
	router.forgottenland.net") by vger.kernel.org with ESMTP
	id S932592AbWBVKa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 05:30:57 -0500
Message-ID: <43FC3D5F.1090607@vanalteren.nl>
Date: Wed, 22 Feb 2006 11:30:55 +0100
From: Ramon van Alteren <ramon@vanalteren.nl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051217)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ramon van Alteren <ramon@vanalteren.nl>
Cc: linux-kernel@vger.kernel.org, ramon@hyves.nl
Subject: Re: Writing to an NFS share truncates files on >8Tb Raid + LVM2
References: <43FB3208.7020303@vanalteren.nl>
In-Reply-To: <43FB3208.7020303@vanalteren.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramon van Alteren wrote:

> I'd like to report a situation which looks like a bug in the kernelbased
> nfs server implementation.
>
> Based on responses from a different mailinglist and google I tried unfsd
>  the userspace nfsd implementation which appears to work fine (still
> testing) The above test-case works for both loopback and remote 
> mounted filesystems.
>
> I'm not on the list so please CC me.

unfsd appears to suffer from the same problem only it has a higher 
treshold for them to appear.
We're seeing the same behaviour with larger files created.

for i in `seq 1 10`; do dd count=400000 bs=1024 if=/dev/zero 
of=/root/test-tools/test.tst; ls -lha /root/test-tools/test.tst ; rm 
/root/test-tools/test.tst ; done

400000+0 records in
400000+0 records out
dd: closing output file `/root/test-tools/test.tst': No space left on device
-rw-r--r--  1 root root 328K Feb 22 09:53 /root/test-tools/test.tst
400000+0 records in
400000+0 records out
dd: closing output file `/root/test-tools/test.tst': No space left on device
-rw-r--r--  1 root root 176K Feb 22 09:53 /root/test-tools/test.tst
400000+0 records in
400000+0 records out
dd: closing output file `/root/test-tools/test.tst': No space left on device
-rw-r--r--  1 root root 168K Feb 22 09:53 /root/test-tools/test.tst
400000+0 records in
400000+0 records out
dd: closing output file `/root/test-tools/test.tst': No space left on device
-rw-r--r--  1 root root 176K Feb 22 09:53 /root/test-tools/test.tst

A test with the same command directly onto the local filesystem runs 
without problems.

for i in `seq 1 10`; do dd count=400000 bs=1024 if=/dev/zero 
of=/data/bonnie++/test.tst; ls -la /data/bonnie++/test.tst ; rm 
/data/bonnie++/test.tst ; done
400000+0 records in
400000+0 records out
-rw-r--r--  1 root root 409600000 Feb 22 09:59 /data/bonnie++/test.tst
400000+0 records in
400000+0 records out
-rw-r--r--  1 root root 409600000 Feb 22 09:59 /data/bonnie++/test.tst
400000+0 records in
400000+0 records out
-rw-r--r--  1 root root 409600000 Feb 22 09:59 /data/bonnie++/test.tst
400000+0 records in
400000+0 records out
-rw-r--r--  1 root root 409600000 Feb 22 09:59 /data/bonnie++/test.tst
400000+0 records in
400000+0 records out
-rw-r--r--  1 root root 409600000 Feb 22 10:00 /data/bonnie++/test.tst

Any help would be much appreciated.

Based on a comment from Lee Revell, I can reproduce the same behaviour 
with both sync & async options set on the nfs server (kernel and userspace)

Regards,

Ramon

-- 
To be stupid and selfish and to have good health are the three requirements for happiness, though if stupidity is lacking, the others are useless.

Gustave Flaubert

  
  

