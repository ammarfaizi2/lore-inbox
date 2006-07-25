Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWGYMfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWGYMfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 08:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWGYMfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 08:35:18 -0400
Received: from ns.suse.de ([195.135.220.2]:19150 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751230AbWGYMfP (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 25 Jul 2006 08:35:15 -0400
Date: Tue, 25 Jul 2006 14:35:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Rene Rebe <rene@exactcode.de>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060725123558.GA32243@opteron.random>
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <200607230920.04129.rene@exactcode.de> <17604.31639.213450.987415@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17604.31639.213450.987415@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm no reiserfs user (nor v3 nor v4), but I respect views of people
that needs the fs to handle zillons of tiny files, for that reiser3
did a good job, and my humble opinion is that the only chance for
reiser4 to stabilize is to grow the userbase and including it in
mainline or in some distro would obviously help (like it happened to
reiser3 in the past with SUSE inclusion first and mainline inclusion
later, nothing has changed dramatically since then, reiser3 was very
buggy at the time too, it was probably my backport of lfs that made us
notice it couldn't even handle lfs on-disk so they had to change the
fs format later on with some backwards compatibility mess with older
kernels, hopefully this time the fixage of v4 for production usage
won't require a change of the on-disk format).

On Mon, Jul 24, 2006 at 11:49:43AM +0400, Nikita Danilov wrote:
> Any data backing up that estimation? Just to give an example, that

Probably KLive is the only tool that can provide an estimate of the
part of the reiser4 userbase compared to the other fs. reiser4 had so
far 1926 days of total uptime and 4409 users using it at least once
for root or anyway mounted nearly at boot. Avg uptime is 16 hours, max
uptime is 28 days.

I can also provide the exact storage scsi/SATA/ATA chipsets used in
combination with it, but it doesn't seem necessary.

klive=> select f, count(*), sum(uptime), avg(uptime), max(uptime) from fs natural inner join klive where f = 'reiser4' group by f order by sum(uptime) desc;
                f                 | count |             sum              |       avg       |       max        
----------------------------------+-------+------------------------------+-----------------+------------------
 reiser4                          |  4409 | 1926 days 27479:22:27.459534 | 16:42:59.666015 | 28 days 16:16:15
(1 row)

klive=> select f, count(*), sum(uptime), avg(uptime), max(uptime) from fs natural inner join klive where f = 'ext4' group by f order by sum(uptime) desc;
 f | count | sum | avg | max 
---+-------+-----+-----+-----
(0 rows)

klive=> 

Full data of all fs (all kernels not just mainline ones) follows. In
total uptime and avg uptime terms it beats many other common fs like
isofs, autofs and ramfs. It'd be cool if I'd be able to receive a
packet during sigterm so I could then differentiate sessions that
rebooted cleanly from the ones that didn't. Receiving oopses
(optionally encrypted) is also a long term planned feature. At the
moment I can't (and I've no much time to work on klive), but this is
still good to quantify the current userbase compared to the other more
common fs.

klive=> select f, count(*), sum(uptime), avg(uptime), max(uptime) from fs natural inner join klive group by f order by sum(uptime) desc;
                f                 | count |              sum               |           avg           |           max           
----------------------------------+-------+--------------------------------+-------------------------+-------------------------
 sysfs                            | 40998 | 35138 days 259797:16:29.93576  | 26:54:23.100394         | 173 days 16:16:15
 tmpfs                            | 40507 | 35025 days 257298:57:48.690973 | 27:06:14.154311         | 173 days 16:16:15
 usbfs                            | 38803 | 26681 days 241169:00:36.268676 | 22:43:03.543444         | 173 days 16:16:15
 reiserfs                         | 19934 | 19257 days 133294:48:27.256508 | 29:52:18.181361         | 155 days 16:16:15
 ext3                             | 22077 | 16346 days 132190:42:38.862752 | 23:45:27.062502         | 173 days 16:16:15
 ext2                             |  9396 | 5629 days 63099:50:27.500173   | 21:05:37.103821         | 139 days 14:54:11
 nfs                              |  2824 | 6373 days 23368:45:22.667638   | 2 days 14:26:11.502361  | 86 days 16:16:15
 binfmt_misc                      |  4396 | 5421 days 33069:20:47.871638   | 1 day 13:07:06.944466   | 173 days 16:16:15
 nfsd                             |  2231 | 4727 days 19824:00:00.354481   | 2 days 11:44:11.187967  | 89 days 16:16:15
 xfs                              |  4326 | 4067 days 28000:38:11.762818   | 29:02:08.685105         | 139 days 14:54:11
 vfat                             |  8684 | 2470 days 46585:39:49.859957   | 12:11:27.193673         | 68 days 16:16:15
 ntfs                             |  8482 | 2382 days 47344:00:52.902741   | 12:19:17.846369         | 68 days 16:16:15
 rpc_pipefs                       |  1188 | 3078 days 11297:55:12.600343   | 2 days 23:41:30.667172  | 173 days 16:16:15
 reiser4                          |  4409 | 1926 days 27479:22:27.459534   | 16:42:59.666015         | 28 days 16:16:15
^^^^^^^^^^^^^
 autofs                           |  2030 | 2374 days 14512:14:16.617646   | 1 day 11:12:57.170748   | 54 days 16:16:15
 ramfs                            |  2847 | 817 days 14809:30:42.122875    | 12:05:20.562741         | 32 days 16:16:15
 selinuxfs                        |   600 | 1006 days 3466:41:58.91087     | 1 day 22:01:04.198185   | 173 days 16:16:15
 smbfs                            |   222 | 1053 days 2155:11:48.374153    | 4 days 27:32:45.353037  | 122 days 16:20:01
 jfs                              |   370 | 971 days 2435:07:17.805929     | 2 days 21:33:54.696773  | 160 days 16:16:15
 iso9660                          |   651 | 792 days 4698:41:27.153665     | 1 day 12:24:56.90807    | 84 days 16:06:15
 subfs                            |   611 | 736 days 3482:38:06.342656     | 1 day 10:36:35.558662   | 122 days 16:20:01
 devfs                            |    51 | 713 days 543:13:20.51142       | 13 days 34:10:50.99042  | 155 days 16:16:15
 supermount                       |   260 | 437 days 1281:43:13.500606     | 1 day 21:16:05.359618   | 68 days 16:16:15
 cifs                             |   506 | 222 days 2997:17:59.130448     | 16:27:11.381681         | 35 days 16:16:15
 openpromfs                       |    53 | 296 days 631:17:42.10027       | 5 days 25:56:56.266043  | 43 days 16:16:15
 fuse                             |   390 | 163 days 2443:31:37.846769     | 16:17:46.404735         | 17 days 16:16:15
 squashfs                         |    62 | 198 days 622:55:15.099784      | 3 days 14:41:32.179029  | 34 days 16:16:15
 configfs                         |    45 | 160 days 504:05:40.811143      | 3 days 24:32:07.573581  | 23 days 16:16:15
 capifs                           |    67 | 135 days 569:04:11.286495      | 2 days 08:51:06.437112  | 39 days 16:16:15
 minix                            |    35 | 128 days 428:57:59             | 3 days 28:01:39.40      | 16 days 16:16:15
 cramfs                           |     6 | 140 days 69:58:03.269142       | 23 days 19:39:40.544857 | 58 days 16:16:15
 udf                              |    15 | 102 days 161:35:54.111551      | 6 days 29:58:23.607437  | 51 days 16:16:15
 debugfs                          |   314 | 39 days 1144:50:09.253475      | 06:37:36.717368         | 11 days 16:14:23.049312
 ufs                              |   146 | 24 days 884:40:35.839055       | 10:00:16.683829         | 10 days 16:16:11.062917
 usbdevfs                         |   139 | 1076:04:34.054012              | 07:44:29.597511         | 19:39:58
 shm                              |   139 | 1076:04:34.054012              | 07:44:29.597511         | 19:39:58
 hfsplus                          |    80 | 14 days 480:38:46.186027       | 10:12:29.077325         | 2 days 23:36:48
 unionfs                          |    23 | 24 days 129:38:06              | 1 day 06:40:47.217391   | 22 days 16:16:15
 ocfs2_dlmfs                      |     1 | 23 days 16:16:15               | 23 days 16:16:15        | 23 days 16:16:15
 oprofilefs                       |     1 | 23 days 16:16:08.088967        | 23 days 16:16:08.088967 | 23 days 16:16:08.088967
 nfs4                             |     5 | 20 days 71:36:00               | 4 days 14:19:12         | 12 days 16:16:15
 nnpfs                            |     9 | 18 days 78:16:50               | 2 days 08:41:52.222222  | 8 days 16:16:15
 afs                              |     1 | 19 days 16:16:15               | 19 days 16:16:15        | 19 days 16:16:15
 securityfs                       |     9 | 4 days 22:13:22                | 13:08:09.111111         | 4 days 16:16:15
 ufsd                             |    15 | 75:38:57                       | 05:02:35.80             | 23:01:05
 vmware-hgfs                      |     1 | 1 day 04:56:21                 | 1 day 04:56:21          | 1 day 04:56:21
 shfs                             |     2 | 14:46:00                       | 07:23:00                | 11:27:35
(47 rows)

Now let's eliminate from the screen all sessions that rebooted (or
crashed) in less than one day:

klive=> select f, count(*), sum(uptime), avg(uptime), max(uptime) from fs natural inner join klive where uptime > '1 day' group by f order by sum(uptime) desc;
                f                 | count |              sum              |           avg           |           max           
----------------------------------+-------+-------------------------------+-------------------------+-------------------------
 sysfs                            |  5385 | 35138 days 80491:02:11.763381 | 6 days 27:33:04.202742  | 173 days 16:16:15
 tmpfs                            |  5344 | 35025 days 79890:55:31.804764 | 6 days 28:14:51.192329  | 173 days 16:16:15
 usbfs                            |  4681 | 26681 days 69552:08:46.865054 | 5 days 31:39:17.301189  | 173 days 16:16:15
 reiserfs                         |  2959 | 19257 days 44003:36:16.956207 | 6 days 27:03:42.161864  | 155 days 16:16:15
 ext3                             |  2520 | 16346 days 37501:47:54.627011 | 6 days 26:33:28.283582  | 173 days 16:16:15
 nfs                              |   645 | 6373 days 10050:19:24.173861  | 9 days 36:43:00.409572  | 86 days 16:16:15
 ext2                             |  1012 | 5629 days 15173:13:30.06032   | 5 days 28:29:14.555396  | 139 days 14:54:11
 binfmt_misc                      |   806 | 5421 days 12168:47:27.060755  | 6 days 32:31:01.59685   | 173 days 16:16:15
 nfsd                             |   634 | 4727 days 9800:42:01.958542   | 7 days 26:23:54.892679  | 89 days 16:16:15
 xfs                              |   607 | 4067 days 9311:21:11.733095   | 6 days 32:08:38.075343  | 139 days 14:54:11
 rpc_pipefs                       |   445 | 3078 days 6789:18:13.704195   | 6 days 37:15:40.884729  | 173 days 16:16:15
 vfat                             |   669 | 2470 days 9424:11:09.850314   | 3 days 30:41:48.624589  | 68 days 16:16:15
 ntfs                             |   636 | 2382 days 9081:10:26.573867   | 3 days 32:09:55.324802  | 68 days 16:16:15
 autofs                           |   405 | 2374 days 6335:32:22.311385   | 5 days 36:19:29.240275  | 54 days 16:16:15
 reiser4                          |   509 | 1926 days 7617:09:58.618041   | 3 days 33:46:41.961921  | 28 days 16:16:15
^^^^^^^^^^
 smbfs                            |    96 | 1053 days 1476:55:37.466481   | 10 days 38:38:04.765276 | 122 days 16:20:01
 selinuxfs                        |    97 | 1006 days 1584:22:47.021437   | 10 days 25:14:27.701252 | 173 days 16:16:15
 jfs                              |    71 | 971 days 1070:04:09.186991    | 13 days 31:17:48.298408 | 160 days 16:16:15
 ramfs                            |   241 | 817 days 3394:18:10.874752    | 3 days 23:26:42.8667    | 32 days 16:16:15
 iso9660                          |    85 | 792 days 1321:54:28.689609    | 9 days 23:10:31.396348  | 84 days 16:06:15
 subfs                            |    89 | 736 days 1346:31:28.394797    | 8 days 21:36:05.038144  | 122 days 16:20:01
 devfs                            |    24 | 713 days 399:55:43.321687     | 29 days 33:39:49.30507  | 155 days 16:16:15
 supermount                       |    34 | 437 days 466:58:54.119926     | 12 days 34:12:19.238821 | 68 days 16:16:15
 openpromfs                       |    29 | 296 days 515:10:26.10027      | 10 days 22:43:48.486216 | 43 days 16:16:15
 cifs                             |    39 | 222 days 622:53:46.261055     | 5 days 32:35:13.493873  | 35 days 16:16:15
 squashfs                         |    23 | 198 days 410:38:26            | 8 days 32:27:45.478261  | 34 days 16:16:15
 fuse                             |    36 | 163 days 534:27:25.006209     | 4 days 27:30:45.694617  | 17 days 16:16:15
 configfs                         |    23 | 160 days 344:26:41.378742     | 6 days 37:55:56.581684  | 23 days 16:16:15
 minix                            |    24 | 128 days 393:11:05            | 5 days 24:22:57.708333  | 16 days 16:16:15
 cramfs                           |     4 | 140 days 66:29:40.119926      | 35 days 16:37:25.029981 | 58 days 16:16:15
 capifs                           |    11 | 135 days 170:13:33            | 12 days 22:01:13.909091 | 39 days 16:16:15
 udf                              |     4 | 102 days 64:26:53             | 25 days 28:06:43.25     | 51 days 16:16:15
 debugfs                          |    11 | 39 days 182:23:03.211977      | 3 days 29:40:16.655634  | 11 days 16:14:23.049312
 ufs                              |    11 | 24 days 151:36:11.289322      | 2 days 18:08:44.662666  | 10 days 16:16:11.062917
 unionfs                          |     2 | 24 days 39:53:03              | 12 days 19:56:31.50     | 22 days 16:16:15
 ocfs2_dlmfs                      |     1 | 23 days 16:16:15              | 23 days 16:16:15        | 23 days 16:16:15
 oprofilefs                       |     1 | 23 days 16:16:08.088967       | 23 days 16:16:08.088967 | 23 days 16:16:08.088967
 nfs4                             |     4 | 20 days 62:33:56              | 5 days 15:38:29         | 12 days 16:16:15
 nnpfs                            |     4 | 18 days 73:50:18              | 4 days 30:27:34.50      | 8 days 16:16:15
 afs                              |     1 | 19 days 16:16:15              | 19 days 16:16:15        | 19 days 16:16:15
 hfsplus                          |    11 | 14 days 109:35:09             | 1 day 16:30:28.090909   | 2 days 23:36:48
 securityfs                       |     1 | 4 days 16:16:15               | 4 days 16:16:15         | 4 days 16:16:15
 vmware-hgfs                      |     1 | 1 day 04:56:21                | 1 day 04:56:21          | 1 day 04:56:21
(43 rows)

Now let's eliminate everything that rebooted or crashed in less than 10 days:

klive=> select f, count(*), sum(uptime), avg(uptime), max(uptime) from fs natural inner join klive where uptime > '10 day' group by f order by sum(uptime) desc;
                f                 | count |              sum              |           avg           |           max           
----------------------------------+-------+-------------------------------+-------------------------+-------------------------
 sysfs                            |   948 | 22969 days 15224:50:33.717548 | 24 days 21:33:13.073542 | 173 days 16:16:15
 tmpfs                            |   949 | 22960 days 15240:45:20.729486 | 24 days 20:42:47.250505 | 173 days 16:16:15
 usbfs                            |   689 | 16015 days 11048:34:25.54762  | 23 days 21:53:15.450722 | 173 days 16:16:15
 reiserfs                         |   516 | 12330 days 8297:16:33.102261  | 23 days 37:34:06.110663 | 155 days 16:16:15
 ext3                             |   453 | 10925 days 7258:04:40.240741  | 24 days 18:49:48.698103 | 173 days 16:16:15
 nfs                              |   193 | 4902 days 3138:54:10.459336   | 25 days 25:50:19.950567 | 86 days 16:16:15
 binfmt_misc                      |   154 | 3581 days 2484:52:11.438999   | 23 days 22:12:48.385968 | 173 days 16:16:15
 ext2                             |   139 | 3359 days 2218:31:49.225427   | 24 days 19:55:54.742629 | 139 days 14:54:11
 nfsd                             |   135 | 3226 days 2186:35:50.40609    | 23 days 37:42:29.262267 | 89 days 16:16:15
 xfs                              |   116 | 2666 days 1848:31:20.130065   | 22 days 39:31:18.276983 | 139 days 14:54:11
 rpc_pipefs                       |    84 | 2034 days 1356:31:00.312955   | 24 days 21:17:30.718011 | 173 days 16:16:15
 autofs                           |    69 | 1366 days 1095:10:03.052435   | 19 days 35:00:08.73989  | 54 days 16:16:15
 ntfs                             |    56 | 1058 days 905:01:16.41019     | 18 days 37:35:22.793039 | 68 days 16:16:15
 vfat                             |    52 | 1060 days 846:41:12.168038    | 20 days 25:30:47.541693 | 68 days 16:16:15
 reiser4                          |    53 | 820 days 859:44:03.65926      | 15 days 27:32:31.767156 | 28 days 16:16:15
^^^^^^^^^^^^
 jfs                              |    21 | 837 days 336:58:57            | 39 days 36:37:05.571429 | 160 days 16:16:15
 smbfs                            |    30 | 815 days 475:06:57.099919     | 27 days 19:50:13.903331 | 122 days 16:20:01
 selinuxfs                        |    28 | 767 days 454:42:21.021437     | 27 days 25:40:05.03648  | 173 days 16:16:15
 devfs                            |    14 | 686 days 233:05:03.154639     | 49 days 16:38:55.939617 | 155 days 16:16:15
 iso9660                          |    24 | 596 days 386:04:44.125293     | 24 days 36:05:11.838554 | 84 days 16:06:15
 subfs                            |    20 | 542 days 306:50:12.359485     | 27 days 17:44:30.617974 | 122 days 16:20:01
 supermount                       |    13 | 383 days 210:20:37.087554     | 29 days 27:15:25.929812 | 68 days 16:16:15
 ramfs                            |    17 | 327 days 261:34:11.310952     | 19 days 21:02:00.66535  | 32 days 16:16:15
 openpromfs                       |    13 | 238 days 211:24:12.08448      | 18 days 23:38:47.083422 | 43 days 16:16:15
 squashfs                         |     8 | 142 days 130:10:00            | 17 days 34:16:15        | 34 days 16:16:15
 cramfs                           |     3 | 137 days 48:48:44.087554      | 45 days 32:16:14.695851 | 58 days 16:16:15
 cifs                             |     6 | 115 days 97:37:30             | 19 days 20:16:15        | 35 days 16:16:15
 capifs                           |     4 | 116 days 65:05:00             | 29 days 16:16:15        | 39 days 16:16:15
 configfs                         |     5 | 95 days 80:52:24.077093       | 19 days 16:10:28.815419 | 23 days 16:16:15
 udf                              |     3 | 96 days 48:10:38              | 32 days 16:03:32.666667 | 51 days 16:16:15
 fuse                             |     6 | 85 days 93:19:29              | 14 days 19:33:14.833333 | 17 days 16:16:15
 minix                            |     3 | 42 days 48:48:45              | 14 days 16:16:15        | 16 days 16:16:15
 ocfs2_dlmfs                      |     1 | 23 days 16:16:15              | 23 days 16:16:15        | 23 days 16:16:15
 oprofilefs                       |     1 | 23 days 16:16:08.088967       | 23 days 16:16:08.088967 | 23 days 16:16:08.088967
 unionfs                          |     1 | 22 days 16:16:15              | 22 days 16:16:15        | 22 days 16:16:15
 afs                              |     1 | 19 days 16:16:15              | 19 days 16:16:15        | 19 days 16:16:15
 nfs4                             |     1 | 12 days 16:16:15              | 12 days 16:16:15        | 12 days 16:16:15
 debugfs                          |     1 | 11 days 16:14:23.049312       | 11 days 16:14:23.049312 | 11 days 16:14:23.049312
 ufs                              |     1 | 10 days 16:16:11.062917       | 10 days 16:16:11.062917 | 10 days 16:16:11.062917
(39 rows)

klive=> 

Now let's eliminate everything that rebooted or crashed in less than 20 days:

klive=> select f, count(*), sum(uptime), avg(uptime), max(uptime) from fs natural inner join klive where uptime > '20 day' group by f order by sum(uptime) desc;
                f                 | count |             sum              |           avg           |           max           
----------------------------------+-------+------------------------------+-------------------------+-------------------------
 sysfs                            |   425 | 15940 days 6844:38:13.264145 | 37 days 28:14:46.337092 | 173 days 16:16:15
 tmpfs                            |   425 | 15908 days 6844:19:50.221708 | 37 days 26:26:18.329933 | 173 days 16:16:15
 usbfs                            |   266 | 10341 days 4258:02:54.770525 | 38 days 37:01:48.927709 | 173 days 16:16:15
 reiserfs                         |   236 | 8553 days 3809:00:57.232965  | 36 days 21:56:11.428953 | 155 days 16:16:15
 ext3                             |   197 | 7465 days 3163:26:12.784865  | 37 days 37:29:58.846624 | 173 days 16:16:15
 nfs                              |   127 | 4029 days 2066:09:04.104158  | 31 days 33:39:17.04019  | 86 days 16:16:15
 binfmt_misc                      |    63 | 2318 days 1020:40:19.272961  | 36 days 35:14:55.544015 | 173 days 16:16:15
 nfsd                             |    63 | 2243 days 1023:44:21.136625  | 35 days 30:43:33.668835 | 89 days 16:16:15
 ext2                             |    53 | 2220 days 827:52:02.580825   | 41 days 36:54:11.36945  | 139 days 14:54:11
 xfs                              |    42 | 1665 days 662:12:10.297862   | 39 days 31:11:43.10233  | 139 days 14:54:11
 rpc_pipefs                       |    30 | 1286 days 486:09:06.068985   | 42 days 37:00:18.202299 | 173 days 16:16:15
 autofs                           |    23 | 756 days 374:13:45           | 32 days 37:08:25.434783 | 54 days 16:16:15
 jfs                              |    10 | 677 days 158:20:12           | 67 days 32:38:01.20     | 160 days 16:16:15
 vfat                             |    20 | 636 days 326:41:41.13894     | 31 days 35:32:05.056947 | 68 days 16:16:15
 smbfs                            |    15 | 620 days 231:13:12.099919    | 41 days 23:24:52.806661 | 122 days 16:20:01
 devfs                            |     9 | 609 days 151:46:53.100264    | 67 days 32:51:52.566696 | 155 days 16:16:15
 ntfs                             |    20 | 584 days 325:04:00.023183    | 29 days 21:03:12.001159 | 68 days 16:16:15
 selinuxfs                        |     9 | 485 days 145:33:36.021437    | 53 days 37:30:24.002382 | 173 days 16:16:15
 iso9660                          |    13 | 463 days 207:52:24           | 35 days 30:45:34.153846 | 84 days 16:06:15
 subfs                            |    10 | 403 days 144:54:16.30619     | 40 days 21:41:25.630619 | 122 days 16:20:01
 supermount                       |     9 | 325 days 145:38:07.087554    | 36 days 18:50:54.120839 | 68 days 16:16:15
 ramfs                            |    10 | 249 days 147:43:34.143084    | 24 days 36:22:21.414308 | 32 days 16:16:15
 reiser4                          |    10 | 240 days 161:33:44.187484    | 24 days 16:09:22.418748 | 28 days 16:16:15
^^^^^^^^^^^^^
 cramfs                           |     3 | 137 days 48:48:44.087554     | 45 days 32:16:14.695851 | 58 days 16:16:15
 openpromfs                       |     5 | 130 days 81:21:15            | 26 days 16:16:15        | 43 days 16:16:15
 capifs                           |     3 | 102 days 48:48:45            | 34 days 16:16:15        | 39 days 16:16:15
 udf                              |     3 | 96 days 48:10:38             | 32 days 16:03:32.666667 | 51 days 16:16:15
 cifs                             |     3 | 81 days 48:48:45             | 27 days 16:16:15        | 35 days 16:16:15
 squashfs                         |     3 | 79 days 48:48:45             | 26 days 24:16:15        | 34 days 16:16:15
 configfs                         |     3 | 64 days 48:28:45             | 21 days 24:09:35        | 23 days 16:16:15
 ocfs2_dlmfs                      |     1 | 23 days 16:16:15             | 23 days 16:16:15        | 23 days 16:16:15
 oprofilefs                       |     1 | 23 days 16:16:08.088967      | 23 days 16:16:08.088967 | 23 days 16:16:08.088967
 unionfs                          |     1 | 22 days 16:16:15             | 22 days 16:16:15        | 22 days 16:16:15
(33 rows)

klive=> 

Currently the number of reiser4 users is 35, this lists only the
kernels running in real time as I write this that are running reiser4:

klive=> select f, count(*), sum(uptime), avg(uptime), max(uptime) from fs natural inner join klive where last + '1 day' > 'now' group by f order by sum(uptime) desc;
                f                 | count |             sum             |           avg           |           max           
----------------------------------+-------+-----------------------------+-------------------------+-------------------------
 sysfs                            |   484 | 3928 days 4530:39:11.52799  | 8 days 12:08:15.76762   | 173 days 16:16:15
 tmpfs                            |   480 | 3927 days 4501:01:21.406313 | 8 days 13:43:37.669596  | 173 days 16:16:15
 usbfs                            |   437 | 2903 days 3824:39:39.983599 | 6 days 24:11:04.485088  | 173 days 16:16:15
 ext3                             |   279 | 2053 days 2355:05:46.852916 | 7 days 17:02:36.08191   | 173 days 16:16:15
 reiserfs                         |   230 | 1949 days 2245:30:53.639863 | 8 days 21:08:13.276695  | 155 days 16:16:15
 xfs                              |    58 | 624 days 587:32:09.569396   | 10 days 28:20:12.578783 | 139 days 14:54:11
 ext2                             |    91 | 608 days 933:47:49.912624   | 6 days 26:36:47.361677  | 139 days 14:54:11
 binfmt_misc                      |    58 | 600 days 619:39:09.233036   | 10 days 18:57:34.297121 | 173 days 16:16:15
 nfsd                             |    32 | 546 days 420:58:29.048813   | 17 days 14:39:19.657775 | 89 days 16:16:15
 jfs                              |    10 | 546 days 143:40:39          | 54 days 28:46:03.90     | 160 days 16:16:15
 nfs                              |    28 | 518 days 380:48:49.210675   | 18 days 25:36:01.757524 | 64 days 16:16:15
 rpc_pipefs                       |    25 | 473 days 347:10:34.048813   | 18 days 35:58:01.361953 | 173 days 16:16:15
 autofs                           |    17 | 211 days 218:50:13.090969   | 12 days 22:45:18.417116 | 54 days 16:16:15
 selinuxfs                        |    10 | 204 days 105:21:47          | 20 days 20:08:10.70     | 173 days 16:16:15
 devfs                            |     3 | 193 days 48:35:34.022351    | 64 days 24:11:51.340784 | 155 days 16:16:15
 ntfs                             |    74 | 93 days 459:41:24.880971    | 1 day 12:22:27.092986   | 30 days 16:16:15
 vfat                             |    64 | 83 days 437:49:49.197282    | 1 day 13:57:57.956208   | 37 days 16:16:15
 iso9660                          |    16 | 90 days 126:40:31.377898    | 5 days 22:55:01.961119  | 75 days 13:45:31
 smbfs                            |     7 | 72 days 122:03:20           | 10 days 24:17:37.142857 | 27 days 16:16:15
 reiser4                          |    35 | 56 days 314:41:54.194701    | 1 day 23:23:28.976991   | 24 days 16:16:15
^^^^^^^^^^^^^^^
 udf                              |     1 | 51 days 16:16:15            | 51 days 16:16:15        | 51 days 16:16:15
 ramfs                            |    11 | 45 days 82:10:59.027323     | 4 days 09:39:10.820666  | 30 days 16:16:15
 configfs                         |     2 | 24 days 25:15:41            | 12 days 12:37:50.50     | 22 days 16:06:15
 squashfs                         |     1 | 21 days 16:16:15            | 21 days 16:16:15        | 21 days 16:16:15
 subfs                            |     2 | 20 days 18:08:18.063223     | 10 days 09:04:09.031611 | 20 days 16:15:43.063223
 cifs                             |     6 | 15 days 66:54:31            | 2 days 23:09:05.166667  | 11 days 16:16:15
 openpromfs                       |     3 | 14 days 61:21:33.08448      | 4 days 36:27:11.02816   | 11 days 16:09:12.08448
 fuse                             |     4 | 10 days 34:01:09            | 2 days 20:30:17.25      | 8 days 16:16:15
 debugfs                          |     6 | 9 days 46:25:01             | 1 day 19:44:10.166667   | 8 days 16:16:15
 minix                            |     1 | 8 days 16:16:15             | 8 days 16:16:15         | 8 days 16:16:15
 hfsplus                          |     1 | 1 day 12:20:26              | 1 day 12:20:26          | 1 day 12:20:26
 ufs                              |     7 | 10:55:17                    | 01:33:36.714286         | 04:18:01
 supermount                       |     2 | 03:14:39                    | 01:37:19.50             | 01:52:35
 securityfs                       |     1 | 00:38:07                    | 00:38:07                | 00:38:07
(34 rows)

klive=> 

And these are the respective kernel versions:

klive=> select kernel_release, count(*), sum(uptime), avg(uptime), max(uptime) from fs natural inner join klive where last + '1 day' > 'now' and f = 'reiser4' group by kernel_release order by sum(uptime) desc;
     kernel_release      | count |          sum           |          avg           |          max           
-------------------------+-------+------------------------+------------------------+------------------------
 2.6.17-ckpp1            |     1 | 24 days 16:16:15       | 24 days 16:16:15       | 24 days 16:16:15
 2.6.17-beyond2          |     3 | 9 days 61:26:13.021287 | 3 days 20:28:44.340429 | 6 days 16:13:52.021287
 2.6.15-gentoo-r1-blip-1 |     1 | 10 days 16:16:15       | 10 days 16:16:15       | 10 days 16:16:15
 2.6.16-gentoo-r12       |     1 | 6 days 16:06:15        | 6 days 16:06:15        | 6 days 16:06:15
 2.6.17-beyond1.1        |     1 | 3 days 17:41:00        | 3 days 17:41:00        | 3 days 17:41:00
 2.6.16-reiser4-r7       |     1 | 2 days 08:58:55.041969 | 2 days 08:58:55.041969 | 2 days 08:58:55.041969
 2.6.18-rc1-mm2-non14    |     1 | 1 day 21:35:33         | 1 day 21:35:33         | 1 day 21:35:33
 2.6.17-no4              |     1 | 1 day 04:56:21         | 1 day 04:56:21         | 1 day 04:56:21
 2.6.17-beyond2.1        |     2 | 24:53:40               | 12:26:50               | 23:01:05
 2.6.16-beyond4.1        |     1 | 22:51:05               | 22:51:05               | 22:51:05
 2.6.17-PRX5.1           |     2 | 18:16:52               | 09:08:26               | 18:16:52
 2.6.18-rc1-mm2          |     1 | 18:16:52               | 18:16:52               | 18:16:52
 2.6.17-gentoo-r3        |     3 | 11:02:11               | 03:40:43.666667        | 07:05:39
 2.6.17-rc1-no2          |     2 | 10:24:03.045926        | 05:12:01.522963        | 07:05:39
 2.6.17-beyond1          |     1 | 09:02:04               | 09:02:04               | 09:02:04
 2.6.17-beyond-git2      |     1 | 09:02:04               | 09:02:04               | 09:02:04
 2.6.16-beyond3          |     1 | 07:05:39               | 07:05:39               | 07:05:39
 2.6.17-no1              |     3 | 06:33:04               | 02:11:01.333333        | 03:18:25
 2.6.17-beyond2-r2       |     1 | 05:22:31               | 05:22:31               | 05:22:31
 2.6.17-gentoo-r4        |     1 | 04:18:01               | 04:18:01               | 04:18:01
 2.6.16-beyond4          |     3 | 03:19:24.068344        | 01:06:28.022781        | 03:09:24.068344
 2.6.17-reiser4-r4       |     2 | 00:57:37.017176        | 00:28:48.508588        | 00:57:37.017176
 2.6.16-reiser4-r11      |     1 | 00:00:00               | 00:00:00               | 00:00:00
(23 rows)

klive=> 

This is the whole list of kernel_releases that ever run reiser4:
           kernel_release            | count |              sum              |           avg            |           max
-------------------------------------+-------+-------------------------------+--------------------------+--------------------------
 2.6.15-gentoo-r1                    | 15726 | 12498 days 94186:27:26.881778 | 25:03:46.27794           | 139 days 14:54:11
 2.6.15.6                            |   262 | 6192 days 4014:29:48.915128   | 23 days 30:31:43.011126  | 114 days 16:16:15
 2.6.16-gentoo-r7                    |  5893 | 3852 days 34120:33:11.729484  | 21:28:40.005384          | 35 days 16:11:20.052466
 2.6.16-gentoo-r9                    |  7349 | 3505 days 39841:34:06.868008  | 16:52:04.132109          | 45 days 16:16:15
 2.6.14-gentoo-r5                    |  3363 | 3774 days 25871:49:28.023204  | 1 day 10:37:34.22778     | 85 days 16:16:15
 2.6.16-rc5                          |  1309 | 3909 days 10877:31:17.420649  | 2 days 31:58:47.179084   | 42 days 16:16:15
 2.6.15-gentoo-r7                    |  4183 | 2741 days 25823:28:50.761387  | 21:53:59.811322          | 48 days 16:10:16.072702
 2.6.16-gentoo-r8                    |  3300 | 2737 days 21674:06:24.528491  | 26:28:24.116524          | 55 days 16:16:15
 2.6.16-gentoo-r3                    |  4780 | 2369 days 26106:57:10.720939  | 17:21:22.558728          | 91 days 16:16:15
 2.6.16-gentoo-r2                    |  2303 | 2600 days 17412:40:17.134521  | 1 day 10:39:21.449038    | 89 days 16:16:15
 2.6.15.1                            |  1463 | 2818 days 10447:34:09.563652  | 1 day 29:22:10.177419    | 136 days 16:16:15
 2.6.16-gentoo-r1                    |  3608 | 2233 days 21934:44:07.471825  | 20:55:59.270364          | 64 days 16:03:18.045239
 2.6.16                              |  1165 | 2508 days 9354:44:26.049247   | 2 days 11:41:48.382875   | 53 days 16:06:15
 2.6.16-gentoo-r6                    |  2075 | 2300 days 13980:21:11.200159  | 1 day 09:20:23.745157    | 58 days 16:16:15
 2.6.15-gentoo-r5                    |  3321 | 1909 days 17474:22:48.504908  | 19:03:27.458147          | 104 days 16:15:50.041517
 2.6.17-gentoo                       |  3291 | 1753 days 19508:59:15.100422  | 18:42:42.97633           | 30 days 16:16:15
 2.6.17-rc1                          |   785 | 2053 days 8234:01:41.533576   | 2 days 25:15:21.912782   | 69 days 16:16:15
 2.6.15                              |  2206 | 1673 days 14112:53:10.800042  | 24:35:55.571532          | 45 days 16:16:15
 2.6.15-gentoo                       |  3284 | 1260 days 20322:09:18.149661  | 15:23:47.453761          | 26 days 16:16:15
 2.6.16-beyond4                      |  2123 | 1268 days 15252:17:49.21025   | 21:31:07.484319          | 21 days 16:16:15
 2.6.16-archck1                      |  1330 | 1388 days 10490:30:49.827973  | 1 day 08:56:03.195359    | 36 days 16:16:15
 2.6.15.4                            |   302 | 1683 days 2958:42:00.940999   | 5 days 23:32:43.314374   | 80 days 16:16:15
 2.6.12-12mdk                        |   360 | 1630 days 3696:44:27.785247   | 4 days 22:56:07.410515   | 84 days 16:06:15
 2.6.15-ck3-r1                       |   769 | 1364 days 6171:30:41.606372   | 1 day 26:35:41.796627    | 43 days 16:16:15
 2.6.15-nitro3                       |  1709 | 1142 days 10979:07:40.254166  | 22:27:42.293888          | 31 days 16:16:15
 2.6.16-beyond3                      |  1806 | 1030 days 13334:56:02.827243  | 21:04:17.011532          | 22 days 16:14:05.037859
 2.6.15-ck7                          |   637 | 1357 days 5372:37:06.322867   | 2 days 11:33:41.07743    | 31 days 16:16:15
 2.6.9-22.0.1.ELsmp                  |    13 | 1571 days 211:31:15           | 120 days 36:34:42.692308 | 173 days 16:16:15
 2.6.15-archck                       |  2579 | 865 days 15948:06:33.240877   | 14:14:00.478186          | 28 days 16:16:15
 2.6.15-1-k7                         |   164 | 1376 days 2179:27:47.995174   | 8 days 22:39:18.95119    | 35 days 16:16:15
 2.6.16-ck11                         |  1402 | 1016 days 10372:57:34.350942  | 24:47:27.542333          | 39 days 16:14:38.079596
 2.6.16-gentoo                       |  1927 | 942 days 11516:24:54.920025   | 17:42:30.853617          | 47 days 16:16:15
 2.6.14.5                            |   169 | 1318 days 1681:33:11          | 7 days 29:07:17.816568   | 86 days 16:16:15
 2.6.16-ck10                         |   814 | 1130 days 5987:58:35.725072   | 1 day 16:40:23.483692    | 40 days 16:16:15
 2.6.14-hardened-r5                  |   636 | 1194 days 4394:03:05.986415   | 1 day 27:57:55.76413     | 52 days 16:16:15
 2.6.12-gentoo-r10                   |   300 | 1213 days 3756:26:28.092538   | 4 days 13:33:41.293642   | 89 days 16:16:15
 2.6.17                              |  1038 | 918 days 10628:20:44.642394   | 31:27:52.875378          | 32 days 16:04:49.04156
 2.6.16-ck3                          |  1043 | 1053 days 6467:18:14.426646   | 1 day 06:25:50.809613    | 54 days 16:16:15
 2.6.16.1                            |   314 | 1161 days 3632:43:26.24459    | 3 days 28:18:28.937085   | 67 days 16:16:15
 2.6.15-archck2                      |  1738 | 727 days 12587:25:00.214091   | 17:16:53.751562          | 14 days 16:16:15
 2.6.13-gentoo-r5                    |   880 | 833 days 9688:10:28.922616    | 33:43:38.896503          | 34 days 16:16:15
 2.6.15-ck2pwr                       |    92 | 1127 days 1357:25:27.655134   | 12 days 20:45:16.604947  | 52 days 16:16:15
[..]

too long to list them all.

> "patchup" is used by (tens of) thousands of computers in governmental
> laboratories the US "national security" depends upon.

I don't see any ext4 in the klive logs, it'd be nice if I would know
how to track your ext4 patchset too to make a more accurate
comparison. We can't compare the above numbers to the klive ones, the
above is the interpolation of the reiser4 and klive userbase
only. While if I could detect the ext4 "patchup" it would be feasible
to attempt a comparison.

Disclaimer: the data should not be trusted, use it at your
risk. Furthermore it may not represent a reliable sample, because the
fs are only submitted at the first connection with the server after
reboot, so if reiser4 or fuse are mounted later on (normally after an
average of 5 minutes) they may not get logged in KLive. OTOH this also
means that all computers showing reiser4 in the logs had it mounted
since about the boot time (so if reiser4 would corrupt memory badly by
just mounting nobody could reasonably hope to reach 20 days of
uptime).

Hope this helps.
