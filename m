Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130008AbQLHJWR>; Fri, 8 Dec 2000 04:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130864AbQLHJV6>; Fri, 8 Dec 2000 04:21:58 -0500
Received: from www1.ExperTeam.de ([195.138.53.252]:56632 "EHLO
	www1.ExperTeam.de") by vger.kernel.org with ESMTP
	id <S130008AbQLHJVs>; Fri, 8 Dec 2000 04:21:48 -0500
Message-Id: <200012080852.JAA19341@www1.ExperTeam.de>
X-Mailer: exmh version 2.2 06/23/2000 (debian 2.2-1) with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Cc: rgooch@atnf.csiro.au, "H. Peter Anvin" <hpa@transmeta.com>
Subject: [PATCH] Make devfs create /dev/shm (was: Re: Trashing ext2 with hdparm) )
In-Reply-To: Your message of "Thu, 07 Dec 2000 01:05:47 +0100."
             <F947C7609FCD02F0412569AD007A3EC0.000087C3412569AE@experteam.de> 
X-Face: "7u#"=sUEnmXhasPDW#QwNqMOaW5JQ2,rqy\Yt"a1yk9LI640Mv9g!TLQpp/tatO@T`=S:S
 xuqEDD30%F#fw>|!oX?g24"P/fr%)/]LhB~9++.hNy]}X/@q(XPGn:~p[q:n_[.B-SE;?J,%gHIq;N
 bl+of~~UF8/A9Jat?P!=Y%Q18tk
Organization: ExperTeam AG
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Dec 2000 09:46:09 +0100
From: Roderich Schupp <rsch@ExperTeam.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Meadors wrote:
>
> On 6 Dec 2000, H. Peter Anvin wrote:
>
> > <HARP>
> > Please don't use the path /var/shm... it was a really bad precedent
> > set when someone suggested it.  Use /dev/shm.
> > </HARP>
>
> And I'll ask again...  If this is now the recommend mount point, can we
> have devfs create this directory for us?


C'mon guys, this is just to easy:


--- 2.4.0-test11/ipc/shm.c.~1~       Thu Dec  7 22:32:47 2000
+++ 2.4.0-test11/lipc/shm.c   Thu Dec  7 22:38:59 2000
@@ -221,6 +221,7 @@
 #ifdef CONFIG_PROC_FS
        create_proc_read_entry("sysvipc/shm", 0, 0, sysvipc_shm_read_proc, NULL);
 #endif
+       devfs_mk_dir (NULL, "shm", NULL);
        zero_id = ipc_addid(&shm_ids, &zshmid_kernel.shm_perm, 1);
        shm_unlock(zero_id);
        INIT_LIST_HEAD(&zshmid_kernel.zero_list);


Cheers, Roderich
-- 
         When in trouble or in doubt,
         run in circles, scream and shout.

Roderich Schupp 		mailto:rsch@ExperTeam.de
ExperTeam GmbH			http://www.experteam.de/
Munich, Germany

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
