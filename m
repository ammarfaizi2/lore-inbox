Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269568AbUIZQKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269568AbUIZQKb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 12:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269570AbUIZQKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 12:10:31 -0400
Received: from pat.uio.no ([129.240.130.16]:46055 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S269568AbUIZQKY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 12:10:24 -0400
Subject: Re: NFS TUNING: #define NFS3_MAXGROUPS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christian Fischer <Christian.Fischer@fischundfischer.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200409261638.36011.Christian.Fischer@fischundfischer.com>
References: <200409261638.36011.Christian.Fischer@fischundfischer.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1096215018.6828.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 26 Sep 2004 12:10:18 -0400
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 26/09/2004 klokka 10:38, skreiv Christian Fischer:
> Hello.
> 
> Please can you tell me if  NFS_MAXGROUPS is tunable for linux kernel? (and is 
> it safe?) I need more than 16 groups per user. For BSD-kernel it is a tunable 
> constant (i think so) and I'm not so familar with such things. 
> 
> What else must i do if it is really tunable?

No, it is NOT tunable. The SunRPC protocol (rfc1831) states clearly that
the AUTH_SYS (a.k.a. AUTH_UNIX) structure is defined as

      struct authsys_parms {
         unsigned int stamp;
         string machinename<255>;
         unsigned int uid;
         unsigned int gid;
         unsigned int gids<16>;
      };

If the BSDs are playing around with that, then they are not adhering to
the protocol, and will be incompatible with all other SunRPC
implementations.

Cheers,
  Trond

