Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUHPDTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUHPDTm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267386AbUHPDTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:19:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56199 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267385AbUHPDTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:19:39 -0400
Date: Mon, 16 Aug 2004 05:20:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816032036.GA11598@elte.hu>
References: <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de> <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net> <20040816025051.GA9481@elte.hu> <20040816025846.GA10240@elte.hu> <1092625901.867.130.camel@krustophenia.net> <20040816031420.GA10919@elte.hu> <1092626132.867.132.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <1092626132.867.132.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Lee Revell <rlrevell@joe-job.com> wrote:

> > did you try mlock-test.cc too? Just to make sure that mlock-test.cc is
> > equivalent to mlockall-test.cc.
> 
> That attachment was also missing.

attached now.

	Ingo

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mlock-test.cc"

// here is the code i used to test the mlockall caused xruns
#include <sys/mman.h>
#include <iostream>
#include <sstream>
#include <unistd.h>

int main (int argc, char *argv[]) {
        if (argc < 2) {
                std::cout << "how many kbytes you want allocated and mlockall'ed?" << std::endl;
        }

        std::stringstream stream(argv[1]);
        int kbytes;
        stream >> kbytes;
        char *mem = new char[kbytes*1024];
        std::cout << "filling with 0's" << std::endl;
        for (int i = 0; i < kbytes*1024; ++i) {
                mem[i] = 0;
        }

        std::cout << "ok, you want " << kbytes << "kb of memory mlocked.  going for it.." << std::endl;
        int error = mlock(mem, kbytes*1024);
        if (error != 0) { std::cout << "mlock error" << std::endl; }
        else { std::cout << "mlock successfull" << std::endl;}
}


--lrZ03NoBR/3+SXJZ--
