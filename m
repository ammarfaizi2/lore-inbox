Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbSKTIqm>; Wed, 20 Nov 2002 03:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265974AbSKTIqm>; Wed, 20 Nov 2002 03:46:42 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:62217 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265947AbSKTIqi>; Wed, 20 Nov 2002 03:46:38 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15835.19857.377606.242310@laputa.namesys.com>
Date: Wed, 20 Nov 2002 11:53:37 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: acc@cs.stanford.edu
Cc: mc@cs.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 74 potential buffer overruns in 2.5.33
In-Reply-To: <20021119234531.GA2723@Xenon.stanford.edu>
References: <20021119234531.GA2723@Xenon.stanford.edu>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Tomato: Green
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Chou writes:
 > Here are 74 out-of-bounds array accesses in Linux 2.5.33 found by the
 > MC checker.  This checker only considers statically allocated arrays
 > with indices that can be calculated at compile time.
 > 
 > The code fragment in each description below is incomplete; you'll need
 > to look at the source in some cases to determine if the report is
 > really a bug.
 > 
 > We'd appreciate any feedback -- even if it's not a bug.
 > 
 > -Andy Chou
 > 
 > 
 > # BUGs	|	File Name
 > 4	|	/isdn/isdn_common.c
 > 4	|	/message/i2o_block.c
 > 4	|	/net/sch_gred.c

[...]

 > ---------------------------------------------------------
 > [BUG] Not really sure.  Maybe just missing an assert?
 > /home/acc/linux/2.5.33/fs/reiserfs/fix_node.c:2400:fix_nodes: 
 > ERROR:BUFFER:2400:2400:Array bounds error: p_s_tb->insert_size[5] indexed 
 > with [5]
 > 		       become the root node.  */
 > 	  
 > 		    RFALSE( n_h == MAX_HEIGHT - 1,
 > 			    "PAP-8355: attempt to create too high of a 
 > tree");

RFALSE asserts that (n_h == MAX_HEIGHT - 1) is false. It is only
compiled conditionally, though. Hmm, and trees are rather tall than high.

 > 
 > 
 > Error --->
 > 		    p_s_tb->insert_size[n_h + 1] = (DC_SIZE + KEY_SIZE) * 
 > (p_s_tb->blknum[n_h] - 1) + DC_SIZE;
 > 		}
 > 		else
 > 		    if ( n_h < MAX_HEIGHT - 1 )

Nikita.
