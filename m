Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbVITVmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVITVmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 17:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVITVmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 17:42:50 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:54735 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750770AbVITVmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 17:42:50 -0400
Message-ID: <BAYC1-PASMTP03F0944EE3C2918E216673AE950@cez.ice>
X-Originating-IP: [67.71.125.52]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <41938.10.10.10.28.1127252566.squirrel@linux1>
Date: Tue, 20 Sep 2005 17:42:46 -0400 (EDT)
Subject: using -gitX snapshot tags [was Re: Arrr! Linux v2.6.14-rc2]
From: "Sean" <seanlkml@sympatico.ca>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Jan Dittmer" <jdittmer@ppp0.net>, "Alexander Nyberg" <alexn@telia.com>,
       "Gene Heskett" <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050920174246_64299"
X-Priority: 3 (Normal)
Importance: Normal
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>            
    <200509201005.49294.gene.heskett@verizon.net>            
    <20050920141008.GA493@flint.arm.linux.org.uk>            
    <200509201025.36998.gene.heskett@verizon.net>            
    <56402.10.10.10.28.1127229646.squirrel@linux1>            
    <20050920153231.GA2958@localhost.localdomain>         
    <BAYC1-PASMTP030BBDF3F9B2552DA9CF26AE950@cez.ice>         
    <43303650.5030202@sfhq.hn.org>      
    <BAYC1-PASMTP033EBAB483DBE4397549B2AE950@cez.ice>      
    <43303C85.1020301@ppp0.net>   
    <BAYC1-PASMTP0390B5ABE91EDE56C81EDBAE950@cez.ice>   
    <Pine.LNX.4.58.0509200959220.2553@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509200959220.2553@g5.osdl.org>
X-OriginalArrivalTime: 20 Sep 2005 21:42:20.0871 (UTC) FILETIME=[2DF3AD70:01C5BE2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050920174246_64299
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Tue, September 20, 2005 1:02 pm, Linus Torvalds said:

> It is. Just get the "id" file that is associated with a snapshot, and
> it gives the git commit ID for that state.
>
> So for example, the 2.6.14-rc1-git3 snapshot is associated with the ID
> file patch-2.6.14-rc1-git3.id, which contains
>
> 	v2.6/snapshots(0)$ cat patch-2.6.14-rc1-git3.id
> 	065d9cac98a5406ecd5a1368f8fd38f55739dee9
>
> so once you know that something broke between rc1-git3 and rc1-git4,
> you can now do
>
> 	git bisect start
> 	git bisect good 065d9cac98a5406ecd5a1368f8fd38f55739dee9
> 	git bisect bad bc5e8fdfc622b03acf5ac974a1b8b26da6511c99
>
> and off you go..


The attached patch grabs all the .id files from the snapshot directory on
kernel.org and converts them into tags in a local git repository.  So
after running "gtags", your example becomes:

       git bisect start
       git bisect good v2.6.14-rc1-git3
       git bisect bad v2.6.14-rc1-git4

Sean

#----[gtags]-----
#!/bin/sh
cd .git/refs/tags/ || exit
lftp http://www.kernel.org <<\EOF
  cd /pub/linux/kernel/v2.6/snapshots/
  mget patch*.id
  cd /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/
  mget *
EOF
rename patch- v patch-*.id
rename .id "" v*.id


------=_20050920174246_64299
Content-Type: application/octet-stream; name="gtags"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="gtags"

IyEvYmluL3NoCmNkIC5naXQvcmVmcy90YWdzLyB8fCBleGl0CmxmdHAgaHR0cDovL3d3dy5rZXJu
ZWwub3JnIDw8XEVPRgogIGNkIC9wdWIvbGludXgva2VybmVsL3YyLjYvc25hcHNob3RzLwogIG1n
ZXQgcGF0Y2gqLmlkCiAgY2QgL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51
eC0yLjYuZ2l0L3JlZnMvdGFncy8KICBtZ2V0ICoKRU9GCnJlbmFtZSBwYXRjaC0gdiBwYXRjaC0q
LmlkCnJlbmFtZSAuaWQgIiIgdiouaWQKCg==
------=_20050920174246_64299--

