Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbUKBO0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbUKBO0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbUKBOYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:24:10 -0500
Received: from penguin.cohaesio.net ([212.97.129.34]:16790 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S263516AbUKBOXE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:23:04 -0500
From: Anders Saaby <as@cohaesio.com>
Organization: Cohaesio A/S
To: linux-kernel@vger.kernel.org
Subject: 2.6.9: NFS (+XFS) Problem - Clients getting Stale filehandles.
Date: Tue, 2 Nov 2004 15:23:12 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411021523.12746.as@cohaesio.com>
X-OriginalArrivalTime: 02 Nov 2004 14:22:59.0980 (UTC) FILETIME=[749F6CC0:01C4C0E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I'm having a rather vierd(!) NFS (+XFS) Problem. We have a disk-backup server 
running an NFS server exporting an XFS filesystem to a number of clients 
which use it for nightly backups.

These clients get a stale filehandle on the NFS mount after ~10 mins of 
inactivity. Client and server are on the same LAN - no firewall.

- Here's the vierd thing: To get these mounts working again, I simply have to 
run a "ls /exported_dir" serverside. - then all NFS mounts work again (for 
~10 mins). This behavior is always reproducable. - I have absolutely no clue 
to what is causing this behavior.

Example:

- Serverside: /mnt/backup/ is exported
- Serverside: "mkdir /mnt/backup/server_name"
- Clientside: /mnt/backup/server_name is mounted.
- Wait for ~10 mins without activity on the mount.
- Clientside: "ls /mnt/backup/server_name" gives: "bash: cd: server_name: 
Stale NFS file" handle
- Serverside: "ls /mnt/backup/server_name"
- Clientside: "ls /mnt/backup/server_name" returns ok.

Any ideas anyone? - I will be happy to test and give more info!

System info:

Server kernel: Linux server_name 2.6.9 #1 SMP Thu Oct 21 01:13:17 CEST 2004 
i686 unknown

Client kernels are different 2.4 and 2.6 kernels.

Client kernel log: "nfs_statfs: statfs error = 116" is repeated.
Server kernel log has no NFS related entries.

Tcpdump between server and client:
client > server: 132 getattr [|nfs] (DF) (ttl 64, id 458, len 160)
server > client reply ok 28 getattr ERROR: Stale NFS file handle (DF) (ttl 64, 
id 17733, len 56)
client > server: 136 access [|nfs] (DF) (ttl 64, id 459, len 164)
server > client: reply ok 32 access ERROR: Stale NFS file handle attr: (DF) 
(ttl 64, id 17734, len 60


-- 
Med venlig hilsen - Best regards - Meilleures salutations

Anders Saaby
Systems Engineer
------------------------------------------------
Cohaesio A/S - Maglebjergvej 5D - DK-2800 Lyngby
Phone: +45 45 880 888 - Fax: +45 45 880 777
Mail: as@cohaesio.com - http://www.cohaesio.com
------------------------------------------------
