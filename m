Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTLYK1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 05:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264294AbTLYK1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 05:27:33 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:39389 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264292AbTLYK1b
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Thu, 25 Dec 2003 05:27:31 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16362.48018.56337.690901@laputa.namesys.com>
Date: Thu, 25 Dec 2003 13:27:30 +0300
To: Hugang <hugang@soulinfo.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: [PATCH] laptop-mode for 2.6, version 2
In-Reply-To: <20031225174033.1abb5401.hugang@soulinfo.com>
References: <3FE92517.1000306@samwel.tk>
	<20031224215120.66b74f66.hugang@soulinfo.com>
	<16361.41348.444243.919179@laputa.namesys.com>
	<20031225105916.67e74599.hugang@soulinfo.com>
	<16362.43831.569086.825899@laputa.namesys.com>
	<20031225174033.1abb5401.hugang@soulinfo.com>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugang writes:
 > On Thu, 25 Dec 2003 12:17:43 +0300
 > Nikita Danilov <Nikita@Namesys.COM> wrote:
 > 
 > > >    unsigned long blocks;
 > > >    unsigned long mount_options = REISERFS_SB(s)->s_mount_opt;
 > > >    unsigned long safe_mask = 0;
 > > > +  unsigned int commit_max_age = -1;
 > > 
 > > Assigning -1 to the unsigned int looks strange. Let's use 0, it is
 > > invalid anyway.
 > Yes, must change to -1, fixed.
 > 
 > > I think that it would be better to first
 > > 
 > > SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb) = val
 > > 
 > > in the parse_options() (after checking for validity), and in
 > > journal_init() do something like
 > > 
 > > if (SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb) == 0) {
 > >   SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb) = le32_to_cpu (jh->jh_journal.jp_journal_max_commit_age);
 > > }
 > > 
 > > This will also get rid of
 > > 
 > > +  if(commit_max_age != -1) {
 > > +	  SB_JOURNAL_MAX_COMMIT_AGE(s) = commit_max_age;
 > > +  }
 > > +
 > > 
 > > piece in reiserfs_remount.
 > > 
 > > Otherwise patch looks ok. Have you tested it?
 > > 
 > In the parse_options() can not assigning commit max age to super block, 
 > the journal memory not malloc, so I pass a it to journal_init.
 > 
 > Yes, It works in my laptop for 1 days. Every thinks is fine.

+		if ( val > 0 ) {
+			*commit_max_age = val;
+		}

here warning should be issued, and mount refused, if val == 0.

 > 
 > Thanks.

Nikita.
