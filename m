Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130431AbQKTBXK>; Sun, 19 Nov 2000 20:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbQKTBXB>; Sun, 19 Nov 2000 20:23:01 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:4870 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129626AbQKTBWp>; Sun, 19 Nov 2000 20:22:45 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jasper Spaans <jasper@spaans.ds9a.nl>,
        Linus Torvalds <torvalds@transmeta.com>
Date: Mon, 20 Nov 2000 11:49:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14872.29951.707116.16506@notabene.cse.unsw.edu.au>
Cc: George Garvey <tmwg-linuxknl@inxservices.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: [PATCH] Re: What is 2.4.0-test10: md1 has overlapping physical units with md2!
In-Reply-To: message from Jasper Spaans on Sunday November 19
In-Reply-To: <20001119033943.C935@inxservices.com>
	<20001119140809.A21693@spaans.ds9a.nl>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, Ingo:

 the attached patch, modifies a warning message in md.c which seems to
 often cause confusion - the following email includes one example
 there-of (there have been others over the months).

 Hopefully the new text is clearer.

 (patch against 2.4.0-test11-pre7)

NeilBrown


On Sunday November 19, jasper@spaans.ds9a.nl wrote:
> On Sun, Nov 19, 2000 at 03:39:43AM -0800, George Garvey wrote:
> > Is this something to be concerned about? It sounds like a disaster waiting
> > to happen from the message. This is on 2 systems (with similar disk setups
> > [same other than size]).
> 
> > Nov 18 16:31:02 mwg kernel: md: serializing resync, md1 has overlapping physical units with md2!  
> 
> Nope, nothing to worry about -- it's just a bad choice of wording ;)
> 
> What it means is that some partititions in md1 and md2 are on the same disk,
> and that the md-code will not do the reconstruction of these arrays in
> parallel [of course, for performance reasons].
> 


--- ./drivers/md/md.c	2000/11/20 00:33:08	1.2
+++ ./drivers/md/md.c	2000/11/20 00:44:19	1.3
@@ -3279,7 +3279,7 @@
 		if (mddev2 == mddev)
 			continue;
 		if (mddev2->curr_resync && match_mddev_units(mddev,mddev2)) {
-			printk(KERN_INFO "md: serializing resync, md%d has overlapping physical units with md%d!\n", mdidx(mddev), mdidx(mddev2));
+			printk(KERN_INFO "md: serializing resync, md%d has shares one or more physical units with md%d!\n", mdidx(mddev), mdidx(mddev2));
 			serialize = 1;
 			break;
 		}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
