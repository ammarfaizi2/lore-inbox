Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTJBPkz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 11:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTJBPkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 11:40:55 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:58284 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263376AbTJBPkx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 11:40:53 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16252.18179.242071.708771@laputa.namesys.com>
Date: Thu, 2 Oct 2003 19:40:51 +0400
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Zan Lynx <zlynx@acm.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.0-test6 crash while reading files in /proc/fs/reiserfs/sda1
In-Reply-To: <20031002120133.GC7665@parcelfarce.linux.theplanet.co.uk>
References: <1064936688.4222.14.camel@localhost.localdomain>
	<200309302006.32584.vitaly@namesys.com>
	<1065019441.4226.1.camel@localhost.localdomain>
	<16251.5348.570797.101912@laputa.namesys.com>
	<20031001184338.GW7665@parcelfarce.linux.theplanet.co.uk>
	<16251.63770.622805.143036@laputa.namesys.com>
	<20031002103550.GB7665@parcelfarce.linux.theplanet.co.uk>
	<16252.798.375208.261677@laputa.namesys.com>
	<20031002120133.GC7665@parcelfarce.linux.theplanet.co.uk>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk writes:
 > [Linus, please wait with applying the patch below until ACK from Nikita, OK?]
 > 

[...]

 > 
 > 
 > If you are OK with the patch below - please ACK it.  AFAICS it's the minimal
 > fix and combined with optimistic sget() patch it should address all objections.

Yes, it works (cum optimistic sget()).

 > 
 > diff -urN B6-rest/fs/reiserfs/procfs.c B6-current/fs/reiserfs/procfs.c
 > --- B6-rest/fs/reiserfs/procfs.c	Sat Sep 27 22:04:57 2003
 > +++ B6-current/fs/reiserfs/procfs.c	Thu Oct  2 07:57:31 2003
 > @@ -478,14 +478,15 @@
 >  static void *r_next(struct seq_file *m, void *v, loff_t *pos)
 >  {
 >  	++*pos;
 > +	if (v)
 > +		deactivate_super(v);
 >  	return NULL;
 >  }
 >  
 >  static void r_stop(struct seq_file *m, void *v)
 >  {
 > -	struct proc_dir_entry *de = m->private;
 > -	struct super_block *s = de->data;
 > -	deactivate_super(s);
 > +	if (v)
 > +		deactivate_super(v);
 >  }
 >  
 >  static int r_show(struct seq_file *m, void *v)

Nikita.
