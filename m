Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264876AbTFLQMx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbTFLQMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:12:53 -0400
Received: from pat.uio.no ([129.240.130.16]:34693 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264876AbTFLQMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:12:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16104.43445.918001.683257@charged.uio.no>
Date: Thu, 12 Jun 2003 09:26:29 -0700
To: dipankar@in.ibm.com
Cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
In-Reply-To: <20030612155345.GB1438@in.ibm.com>
References: <20030612125630.GA19842@butterfly.hjsoft.com>
	<20030612135254.GA2482@in.ibm.com>
	<16104.40370.828325.379995@charged.uio.no>
	<20030612155345.GB1438@in.ibm.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dipankar Sarma <dipankar@in.ibm.com> writes:

     > Does my patch meet the requirements that you had for __d_drop()
     > ?

I still need a real fix for d_move(). In addition, I'm getting worried
about the changes in functionality that you've introduced here. It
seems to me that your lockless scheme opens for a *lot* of races:

Look at all those functions that take dcache_lock, and then test
dentry->d_count. Unless I'm missing something here, your d_lookup()
clearly has them all screwed, no?

Cheers,
  Trond
