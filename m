Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbTC1JGC>; Fri, 28 Mar 2003 04:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262837AbTC1JGC>; Fri, 28 Mar 2003 04:06:02 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:31429 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S262835AbTC1JF6>; Fri, 28 Mar 2003 04:05:58 -0500
Message-ID: <20030328091707.27905.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: kernel-janitor-discuss@lists.sourceforge.net
Cc: smatch-discuss@lists.sf.net, linux-kernel@vger.kernel.org
Date: Fri, 28 Mar 2003 04:17:07 -0500
Subject: smatch results for 2.5.66
X-Originating-Ip: 66.127.101.73
X-Originating-Server: ws3-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5.66 results for smatch are up on kbugs.org

Sadly, I haven't changed any of the scripts since 
2.5.65.  I did get some work done on the gcc part
but it turns out there is a problem and I had to 
revert to diff-smatch-v.42 to compile the kernel. :(

mysql> select kernelver, script, count(script) from 
bugs where kernelver = "2.5.65" or kernelver = "2.5.66" 
group by script, kernelver;
+-----------+-------------------+---------------+
| kernelver | script            | count(script) |
+-----------+-------------------+---------------+
| 2.5.65    | Dereference       |           321 |
| 2.5.66    | Dereference       |           263 |
| 2.5.65    | GFP_DMA           |             5 |
| 2.5.66    | GFP_DMA           |             2 |
| 2.5.65    | ReleaseRegion     |            48 |
| 2.5.66    | ReleaseRegion     |            48 |
| 2.5.65    | SpinlockUndefined |            44 |
| 2.5.66    | SpinlockUndefined |            33 |
| 2.5.65    | SpinSleepLazy     |             6 |
| 2.5.66    | SpinSleepLazy     |             5 |
| 2.5.65    | UncheckedReturn   |           118 |
| 2.5.66    | UncheckedReturn   |            74 |
| 2.5.65    | UnFree            |           872 |
| 2.5.66    | UnFree            |           660 |
| 2.5.65    | UnreachedCode     |            28 |
| 2.5.66    | UnreachedCode     |            25 |
+-----------+-------------------+---------------+
16 rows in set (0.22 sec)

As you can see, there were bug fixes all everywhere.  :)

mysql> select kernelver, count(kernelver) from bugs 
where kernelver = "2.5.65" or kernelver = "2.5.66" 
group by kernelver;
+-----------+------------------+
| kernelver | count(kernelver) |
+-----------+------------------+
| 2.5.65    |             1442 |
| 2.5.66    |             1110 |
+-----------+------------------+

That's 332 bugs fixed.  :)

regards,
dan carpenter


-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

